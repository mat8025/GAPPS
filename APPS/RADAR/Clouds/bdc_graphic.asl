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
 setrgbsection(mapki,mapki+4,pi)
 mapki += 5

// 5-15

  pi = getColorIndexFromName("skyblue")
  rgb_v = getRGB("skyblue")

  setrgbsection(mapki,mapki+4,pi)
  mapki += 5


// 15 -20  BLUE
  setrgbsection(mapki,mapki+5,BLUE)
  mapki += 5

// 20-30
  pi = getColorIndexFromName("green")
  setrgbsection(mapki,mapki+9,pi)
  mapki += 10

 
  setrgbsection(mapki,mapki+9,YELLOW)
  mapki += 10

// RED
  setrgbsection(mapki,mapki+9,RED)
  mapki += 10

// 45 ->

  pi = getColorIndexFromName("purple")
  setrgbsection(mapki,mapki+9,pi)
  mapki += 10


  pi = getColorIndexFromName("white")

  setrgbsection(mapki,mapki+29,pi)
  mapki += 30

///////////////////// WO SETUP  ///////////
// Window creation and gline setup

int sri_nxp
int sri_nyp

int CI[]

    aw= CreateGwindow(@title,"CLOUD_BDC")

    SetGwindow(aw,@resize,0.01,0.15,0.99,0.95,0)
    SetGwindow(aw,@drawon,@pixmapon,@save)
    SetGwindow(aw,@clip,0.1,0.1,0.95,0.9)

    lri_wo=createGWOB(aw,@GRAPH,@resize,0.05,0.4,0.35,0.95,@name,"IPY",@color,"white")
    // radar-beam paint
    lrrb_wo=createGWOB(aw,@GRAPH,@resize,0.36,0.4,0.66,0.95,@name,"RBY",@color,"white")
    // despread wo
    lrds_wo=createGWOB(aw,@GRAPH,@resize,0.67,0.4,0.97,0.95,@name,"DSY",@color,"white")


       // lri image 185 units of 1200 meters  --- range is 120 nmiles
   setgwob(lri_wo,@drawon,@pixmapon,@save,@clip,0.01,0.1,0.98,0.98,@scales,0,0,120,120,@savescales,0)
   setgwob(lrrb_wo,@drawon,@pixmapon,@save,@clip,0.01,0.1,0.98,0.98,@scales,0,0,120,120,@savescales,0)
   setgwob(lrds_wo,@drawon,@pixmapon,@save,@clip,0.01,0.1,0.98,0.98,@scales,0,0,120,120,@savescales,0)


   sigi_wo=createGWOB(aw,@GRAPH,@resize,0.05,0.1,0.35,0.35,@name,"PY",@color,"white")
   setgwob(sigi_wo,@drawon,@pixmapon,@save,@clip,0.01,0.1,0.98,0.9,@scales,0,0,240,1000,@savescales,0)
   setgwob(sigi_wo,@redraw)
   sigs_wo=createGWOB(aw,@GRAPH,@resize,0.36,0.1,0.66,0.35,@name,"PY",@color,"white")
   setgwob(sigs_wo,@drawoff,@pixmapon,@save,@clip,0.01,0.1,0.98,0.9,@scales,0,0,240,2000,@savescales,0)

//   sigs_gl=CreateGline(@woid,sigs_wo,@type,"XY",@xvec, XV, @yvec, Spat, @color, "red" ,@usescales,0)
//   sigs_gl=CreateGline(@woid,sigs_wo,@color, "red" ,@usescales,0)



   sigd_wo=createGWOB(aw,@GRAPH,@resize,0.67,0.1,0.97,0.35,@name,"PY",@color,"white")
   setgwob(sigd_wo,@drawoff,@pixmapon,@save,@clip,0.01,0.1,0.98,0.9,@scales,0,0,240,1000,@savescales,0)
   setgwob(sigd_wo,@redraw)

   CI =getWoClip(lri_wo)

   nxp = CI[3] - CI[1]
   nyp = CI[4] - CI[2]

<<"%V$nxp $CI[3] $CI[1]\n"
<<"%V$nyp $CI[4] $CI[2]\n"



////////////////////////////////  GRAPHIC ROUTINES  FOR BDC //////////////////////////////////////////////


///////////////////     GRAPHIC  ROUTINES ////////////

proc redraw_vs()
{

  setgwob(lri_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lri_wo,UL,mapi)

  setgwob(lri_wo,@clear,@border,@showpixmap,@drawon)

  setgwob(lrrb_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lrrb_wo,UBS,mapi)
 
  setgwob(lrrb_wo,@clear,@border,@showpixmap,@drawon)

  setgwob(lrds_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lrds_wo,DCL,mapi)
 
  setgwob(lrds_wo,@clear,@border,@showpixmap,@drawon)


}




///////////////////////////////////////////////////////////////////////////////////