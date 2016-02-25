// graphic routines for cloud_bdc


  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

//////////////////////// COLOR MAP ////////////////

mapi = 100
mapki = mapi


 rgb_v = getRGB("BLACK")

// 0 - 10 dBZ
 for (i = 0; i < 5; i++) {
  setrgb(mapki,rgb_v[0],rgb_v[1], rgb_v[2])
  mapki++
 }

 pi = getColorIndexFromName("lightblue")

 for (i = 5; i < 10; i++) {
  setrgbfromIndex(mapki,pi)
  mapki++
 }


// 5-15

    pi = getColorIndexFromName("skyblue")
    rgb_v = getRGB("skyblue")

 for (i = 10; i < 15; i++) {

    setrgb(mapki,rgb_v)

    r_rgb_v = getRGB(mapki)

//   <<"$mapki $r_rgb_v \n"

    mapki++
 }

// 15 -20  BLUE

 for (i = 15; i < 20; i++) {
  setrgbfromIndex(mapki,BLUE)
  mapki++
 }


 pi = getColorIndexFromName("green")

 for (i = 20; i < 30; i++) {
  setrgbfromIndex(mapki,pi)
  mapki++
 }

 for (i = 30; i < 40; i++) {
  setrgbfromIndex(mapki,YELLOW)
  mapki++
 }

// RED

 pi = getColorIndexFromName("red")

 for (i = 40; i < 50; i++) {
    setrgbfromIndex(mapki,RED)
    mapki++
 }

// 45 ->>

  pi = getColorIndexFromName("purple")

 for (i = 50; i < 65; i++) {
    setrgbfromIndex(mapki,pi)
    mapki++
 }

  pi = getColorIndexFromName("white")

 for (i = 65; i < 200; i++) {
    setrgbfromIndex(mapki,WHITE)
    mapki++
 }


///////////////////// WO SETUP  ///////////
// Window creation and gline setup

int sri_nxp
int sri_nyp

int CI[]

upper_dbz = 80.0 

    n_alt_levels = 120
    aw= CreateGwindow(@title,"CLOUD_BACK_PROJ")

    SetGwindow(aw,@resize,0.01,0.15,0.99,0.95,0)
    SetGwindow(aw,@drawon,@pixmapon,@save)
    SetGwindow(aw,@clip,0.1,0.1,0.95,0.9)

    lri_wo=createGWOB(aw,@GRAPH,@resize,0.05,0.7,0.25,0.95,@name,"RAWDBZ",@color,"white")
    lrist_wo=createGWOB(aw,@GRAPH,@resize,0.05,0.4,0.25,0.65,@name,"ST",@color,"white")
    setgwob(lrist_wo,@drawon,@clip,0.01,0.1,0.98,0.9,@scales,0,0,120,n_alt_levels,@savescales,0)
    setgwob(lrist_wo,@border,RED,@clipborder,GREEN)

    // radar-beam paint
    // bpj wo

    lrbpj_wo=createGWOB(aw,@GRAPH,@resize,0.3,0.7,0.5,0.95,@name,"BPDBZ",@color,"white")
    lrbpjst_wo=createGWOB(aw,@GRAPH,@resize,0.3,0.4,0.5,0.65,@name,"ST",@color,"white")
    setgwob(lrbpjst_wo,@drawon,@clip,0.01,0.1,0.98,0.9,@scales,0,0,120,n_alt_levels,@savescales,0)
    setgwob(lrbpjst_wo,@border,RED,@clipborder,GREEN)

       // lri image 185 units of 1200 meters  --- range is 120 nmiles

   setgwob(lri_wo,@drawon,@pixmapon,@save,@clip,10,10,185,120,2,@scales,0,0,120,120,@savescales,0)
   setgwob(lrbpj_wo,@drawon,@pixmapon,@save,@clip,10,10,185,120,2,@scales,0,0,120,120,@savescales,0)




   sigi_wo=createGWOB(aw,@GRAPH,@resize,0.05,0.1,0.35,0.35,@name,"PY",@color,"white")
   setgwob(sigi_wo,@drawoff,@pixmapon,@save,@clip,0.01,0.1,0.98,0.9,@scales,0,0,120,upper_dbz,@savescales,0)

   sigs_wo=createGWOB(aw,@GRAPH,@resize,0.36,0.1,0.66,0.35,@name,"PY",@color,"white")
   setgwob(sigs_wo,@drawoff,@pixmapon,@save,@clip,0.01,0.1,0.98,0.9,@scales,0,0,120,upper_dbz,@savescales,0)

//   sigs_gl=CreateGline(@woid,sigs_wo,@type,"XY",@xvec, XV, @yvec, Spat, @color, "red" ,@usescales,0)
     sigs_gl=CreateGline(@woid,sigs_wo,@color, "red" ,@usescales,0)



//   sigd_wo=createGWOB(aw,@GRAPH,@resize,0.67,0.1,0.97,0.35,@name,"PY",@color,"white")
//   setgwob(sigd_wo,@drawoff,@pixmapon,@save,@clip,0.01,0.1,0.98,0.9,@scales,0,0,240,1000,@savescales,0)


   CI =getWoClip(lri_wo)

   nxp = CI[3] - CI[1]
   nyp = CI[4] - CI[2]

<<"%V$nxp $CI[3] $CI[1]\n"
<<"%V$nyp $CI[4] $CI[2]\n"

   CI =getWoClip(lrbpj_wo)

   nxp = CI[3] - CI[1]
   nyp = CI[4] - CI[2]

<<"%V$nxp $CI[3] $CI[1]\n"
<<"%V$nyp $CI[4] $CI[2]\n"

   text(aw,fn,0.8,0.8)


////////////////////////////////  GRAPHIC ROUTINES  FOR BDC //////////////////////////////////////////////


///////////////////     GRAPHIC  ROUTINES ////////////

proc redraw_vs()
{

  setgwob(lri_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lri_wo,UL,mapi)

  setgwob(lri_wo,@clear,@border,@showpixmap,@drawon)

//  setgwob(lrrb_wo,@BORDER,@drawoff,@clearpixmap)

//  plotPixRect(lrrb_wo,UBS,mapi)
 
//  setgwob(lrrb_wo,@clear,@border,@showpixmap,@drawon)

  setgwob(lrbpj_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lrbpj_wo,DCL,mapi)
 
  setgwob(lrbpj_wo,@clear,@border,@showpixmap,@drawon)


}




///////////////////////////////////////////////////////////////////////////////////