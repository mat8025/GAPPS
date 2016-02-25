////////////////////////////////////////////   Graphic routines for StormTop display //////////////////////////////////////////////
<<" including our graphic for squishy \n"

  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }




msg = "XX"

last_msg = ""

//  always read in LIB/src version 

include "event.asl"

Event E

proc CheckMsg()
{

  tid = GthreadGetId()

  int nl = 0

  while (1) {


    E->readMsg()

    msg = E->keyw

    dcont = 0

<<". "
    if ((nl % 10) == 0) {
<<". +\n"
    }

    if ( ! (msg @= "NO_MSG") ) {



        c_option = E->woname

<<"got command $c_option \n"

        zmn = msg 

//       dcont = Controls()


      last_msg = msg


   <<"$nl <<$msg>> \n"
        nl++


        if (msg @= "EXIT") {
      <<" got EXIT \n"
           break
        }

        if (c_option @= "QUIT") {
      <<" got QUIT \n"
           break
        }

    }    



    sleep(0.5)

   }

<<"exit thread\n"
  GthreadExit(tid)

  stop!
}




proc redraw()
{
  
  setgwob({lri_wo,lrip_wo},@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lri_wo,UL,mapi)
 
  plotPixRect(lrip_wo,N_UL,mapi)

  setgwob(lri_wo,@clear,@border,@showpixmap,@drawon)

  setgwob(lrip_wo,@clear,@border,@showpixmap,@drawon)

  plotsymbol(lri_wo,range_nm,60,"diamond",1.2,RED,0)


  plotWosymbol(lri_wo,start_r,-5,"diamond",1.2,GREEN,0)
  
  plotWosymbol(lri_wo,end_r,-5,"diamond",1.2,BLUE,0)

  plotWosymbol(lri_wo,range_nm,-5,"diamond",1.2,RED,0)

  plotWosymbol(lrip_wo,rangec_nm,-5,"diamond",1.2,GREEN,0)

  ky = -5

/{
  setgwob(sri_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(sri_wo,U,mapi)

  setgwob(sri_wo,@clear,@border,@showpixmap,@drawon)

  plotsymbol(sri_wo,range_nm,60,"triangle",5,RED,0)

  plotWosymbol(sri_wo,start_r,-5,"diamond",10,GREEN,0)

  plotWosymbol(sri_wo,end_r,-5,"diamond",10,BLUE,0)

  plotWosymbol(sri_wo,range_nm,-5,"diamond",10,RED,0)
  axnum(sri_wo,1,0,40,5,1)
/}

  axnum(lri_wo,1,0,110,20,1)
  axnum(lrip_wo,1,0,110,20,1)

  ac_raz = ac_alt / 500.0

  tilt_top = ((40 * 6076) * tan(d2r(20)) / 500.0) + ac_raz
  cloud_top = 35000/500
  cloud_bin = (25* 6076) * 0.3048 / 300 


  plotLine(lri_wo,0,ac_raz,185,ac_raz,"white")
  plotLine(lri_wo,0,ac_raz,185,tilt_top,"blue")
  plotLine(lri_wo,0,ac_raz,cloud_bin,cloud_top,"green")
  Text(aw,cloud_title,0.05,0.02,1)
  setgwob({lri_wo,lrip_wo},@save)

  DrawGline(mp_gl)
  setgwindwo(aw,@save)


}



proc plotAltDBZ()
{

  //setgwob(adbz_wo,@BORDER,@drawoff,@clearpixmap)
setgwob(adbz_wo,@BORDER,@drawon,@clearpixmap)
//b = Cab(LRADBZ)
//<<"$b \n"
//<<"$LRADBZ\n"

  DrawGline(adbz_gl)
  DrawGline(ndbz_gl)
  //DrawGline(xdbz_gl)


  plotWosymbol(adbz_wo,18,stAlt,"diamond",1.2,GREEN,0)

  plotWosymbol(adbz_wo,18,stSQAlt,"diamond",1.2,RED,0)

  setgwob(adbz_wo,@clear,@border,@showpixmap,@drawon)
 

        alt_feet = 60000 - (Alt * 500)
        setgwob(alt_wo,@VALUE,alt_feet,@redraw)
        axnum(adbz_wo,1,-5,75,20,1)

 setgwob(adbz_wo,@scales,-5,0,90,60,@savescales,0)

        axnum(adbz_wo,4,0,60,10,-2)

 setgwob(adbz_wo,@scales,-5,120,90,0,@savescales,0)
 

}




proc showRange()
{
// should use a WO SYMBOL TYPE

   xrange = (Lrange_xbin * 120/185.0) 

// plotWosymbol(lri_wo,-2,(120-Lalt),"diamond",10,WHITE,0)

  plotWosymbol(lri_wo,last_xrange,-3,"diamond",1.2,WHITE,0)
  plotWosymbol(lri_wo,xrange,-3,"diamond",1.2,"cyan",0)

  last_xrange = xrange

}

proc plotCompDBZ()
{

  setgwob(cdbz_wo,@BORDER,@drawoff,@clearpixmap)
  setgwob(lrdbz_wo,@BORDER,@drawoff,@clearpixmap)

  DrawGline(lrmdbz_gl)
  DrawGline(lrtopdbz_gl)
  DrawGline(strmtop_gl)
  DrawGline(strmtopSQ_gl)
  DrawGline(strmmidSQ_gl)
  DrawGline(strmcbaseSQ_gl)



  plotWosymbol(sri_wo,-2,(120-Lalt),"diamond",1.2,WHITE,0)
  plotWosymbol(sri_wo,-2,(120-Alt),"diamond",1.2,GREEN,0)

  setgwob(cdbz_wo,@clear,@border,@showpixmap,@drawon)
  setgwob(lrdbz_wo,@clear,@border,@showpixmap,@drawon)
  alt_feet = 60000 - (Alt * 500)
  setgwob(alt_wo,@VALUE,alt_feet,@redraw)
}



proc plotCCV()
{
<<"cloud peak DBZ vec\n"
//<<"%V$CCV\n"
//<<"%V$CCRV\n"

 setgwob(pkdbzr_wo,@BORDER,@drawon,@clearpixmap)

 DrawGline(pkdbzr_gl)

 setgwob(pkdbzr_wo,@BORDER,@drawon,@showpixmap)
      axnum(pkdbzr_wo,1,0,120,20,0.5)
 setgwob(pkdbzr_wo,@scales,-5,0,90,60,@savescales,0)
        axnum(pkdbzr_wo,4,0,60,10,-2)
 setgwob(pkdbzr_wo,@scales,0,0,120,120,@savescales,0)

}


proc  plotRab()
{
// range and bearing

   float x1
   float y1
   //float ang = ((bearing + ac_hdg) % 360)


   x1 = range_nm * sin(deg2rad(bearing))
   y1 = range_nm * cos(deg2rad(bearing))

   setgwob(rab_wo,@CLEAR,@BORDER)

   plotLine(rab_wo,0,0,x1,y1,RED)
   //<<"$x1 $y1 "

}

proc showVSFE()
{
      redraw()
      getRangeDBZ()
      plotAltDBZ()
      plotCompDBZ()

      getPeakDBZAlt(Lrange_nbin, Lrange_fbin)
      plotRab()
      plotCCV()
}





/////////////////////////////// Color Map ------- Cloud dbZ ///////////////////////////////
///////////////////////////////

mapi = 100

mapki = mapi
// black



 rgb_v = getRGB("BLACK")
<<"$rgb_v BLACK\n"

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
<<"$rgb_v SKYBLUE\n"

<<"%V$pi  Skyblue\n"


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


// GREEN  20 -  30

    pi = getColorIndexFromName("green")

 for (i = 20; i < 30; i++) {
  setrgbfromIndex(mapki,pi)
  mapki++
 }


//  YELLOW  30 - 40

 for (i = 30; i < 40; i++) {
  setrgbfromIndex(mapki,YELLOW)
  mapki++
 }

// red

 pi = getColorIndexFromName("red")
<<"%V$pi 40-50  RED\n"

 for (i = 40; i < 50; i++) {
    setrgbfromIndex(mapki,RED)
    mapki++
 }



// white

// 45 ->>

  pi = getColorIndexFromName("purple")
//<<"%V$pi\n"

 for (i = 50; i < 65; i++) {
    setrgbfromIndex(mapki,pi)
    mapki++
 }

  pi = getColorIndexFromName("white")
//<<"%V$pi white\n"

 for (i = 65; i < 200; i++) {
    setrgbfromIndex(mapki,WHITE)
    mapki++
 }

/////////////////////////////////////////////////////////////////


/////////////////////// BUTTONS ////////////////////////////////////////////////////
//  use  a control window
//

    fstem = sele("$fn",0,-4)


<<"%V$fstem\n"
// these are too long for title

    cloud_title = fstem

    stmp = spat(fstem,"/",">",-1)

    if ( !(stmp @= "")) {
      cloud_title = stmp
    }


<<"%V$cloud_title  $stmp\n"

    cw= CreateGwindow(@title,"Passing_Clouds")

    SetGwindow(cw,@resize,0.01,0.01,0.95,0.14,0)
    SetGwindow(cw,@drawon,@pixmapon,@save,@sticky,1,@fname,"Passing_Clouds")
    
    SetGwindow(cw,@clip,0.1,0.12,0.95,0.9,@redraw)


   cell_wo=createGWOB(cw,"BV",@name,"CELL_ID",@color,"green",@clipbhue,"blue")

   find_wo=createGWOB(cw,"BV",@name,"FIND",@color,"cyan")

   ts_wo=createGWOB(cw,"BV",@name,"TIME",@color,"green",@clipbhue,"green")

   rng_wo=createGWOB(cw,"BV",@name,"RANGE_NM",@color,"white",@clipbhue,"red")

   stormtop_wo=createGWOB(cw,"BV",@name,"TOP_FEET",@color,"white",@clipbhue,"skyblue")

   alt_wo=createGWOB(cw,"BV",@name,"ALT_INC",@VALUE,80,@color,"orange")


   setgwob({cell_wo,ts_wo,rng_wo,stormtop_wo,alt_wo,find_wo},@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@VALUE,0,@STYLE,"SVB")
   setgwob(find_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@VALUE,1,@Func,"inputValue")


   nxt_wo=createGWOB(cw,"BN",@name,"NEXT",@VALUE,"ON",@color,"orange")
   setgwob(nxt_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK)

   prev_wo=createGWOB(cw,"BN",@name,"PREV",@VALUE,"ON",@color,"pink")
   setgwob(prev_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK)

   track_wo=createGWOB(cw,"BN",@name,"TRACK",@VALUE,"ON",@color,"pink")
   setgwob(track_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK)

   wvs_wo=createGWOB(cw,"BN",@name,"WRITE_VS",@VALUE,"ON",@color,"orange")
   setgwob(w_vs_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK)


   quit_wo=createGWOB(cw,"BN",@name,"QUIT",@VALUE,"QUIT",@color,"red")
   setgwob(quit_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK)

   wo_htile({cell_wo,ts_wo,rng_wo,alt_wo,stormtop_wo,nxt_wo,prev_wo, find_wo, track_wo, wvs_wo, quit_wo},0.02,0.15,0.9,0.85,0.02)

   int buttons[] = {cell_wo,ts_wo,rng_wo,nxt_wo,prev_wo,alt_wo,track_wo, wvs_wo, quit_wo, find_wo, stormtop_wo}

   setGwob(buttons,@redraw)

/////////////////////////////////////////////////////////////////////////////////////

// Window
int sri_nxp
int sri_nyp

int CI[]


    aw= CreateGwindow(@title,"CLOUD_SWEEP")

    top_alt_feet = 60000.0

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.01,0.15,0.95,0.95,0)
    SetGwindow(aw,@drawon,@pixmapon,@save)
    SetGwindow(aw,@clip,0.1,0.1,0.95,0.9)

   fr_y0 = 0.56;     fr_y1 = 0.98

  // GraphWo

   cdbz_wo=createGWOB(aw,@GRAPH,@resize,0.1,fr_y0,0.45,fr_y1,@name,"CBDZ",@color,"white")
   setgwob(cdbz_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.98,0.9,@scales,0,-5,185,100,@savescales,0)


   lrdbz_wo=createGWOB(aw,@GRAPH,@resize,0.5,fr_y0,0.85,fr_y1,@name,"LRDBZ",@color,"white")
   setgwob(lrdbz_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.98,0.9,@scales,0,-5,185,top_alt_feet,@savescales,0)

   adbz_wo=createGWOB(aw,@GRAPH,@resize,0.86,fr_y0,0.95,fr_y1,@name,"PY",@color,"white")
   setgwob(adbz_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.9,0.9,@scales,-5,120,90,0,@savescales,0)

/////////////////////////////////////////////////////////////////////////////////////////////////

   sr_y1 = 0.55 ; sr_y0 = 0.05 ;

   lri_wo=createGWOB(aw,@GRAPH,@resize,0.1,sr_y0,0.45,sr_y1,@name,"RAW",@color,"white")
   // lri image 185 units of 1200 meters  --- range is 120 nmiles
   //setgwob(lri_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.98,0.98,@scales,0,0,185,120,@savescales,0)
     setgwob(lri_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.98,0.98,@scales,0,0,120,120,@savescales,0)

   // processed 'squished; image
   lrip_wo=createGWOB(aw,@GRAPH,@resize,0.5,sr_y0,0.85,sr_y1,@name,"SQUISY",@color,"white")
   // save the pixmap so it can be draw into   
   setgwob(lrip_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.98,0.98,@scales,0,0,120,120,@savescales,0)



   pkdbzr_wo=createGWOB(aw,@GRAPH,@resize,0.87,0.1,0.95,0.39,@name,"PY",@color,"white")
   setgwob(pkdbzr_wo,@drawon,@pixmapon,@save,@clip,0.05,0.1,0.98,0.9,@scales,0,0,120,120,@savescales,0)


   CI =getWoClip(lri_wo)

   nxp = CI[3] - CI[1]
   nyp = CI[4] - CI[2]

//<<"%V$nxp $CI[3] $CI[1]\n"

//<<"%V$nyp $CI[4] $CI[2]\n"


   rab_wo=createGWOB(aw,@GRAPH,@resize,0.01,0.85,0.09,0.99,@name,"RAB",@color,"white")
   setgwob(rab_wo,@drawon,@pixmapon,@clip,0.05,0.1,0.9,0.9,@scales,-120,0,120,120,@savescales,0)




//  pixel size ? 

///////////////////////////////////  Glines  /////////////////////////////////////////////////////

   // FIX --- X & Y have to float ?? - no inline conversion??


   lrmdbz_gl = CreateGline(@wid,cdbz_wo,@type,"Y",@yvec,LRmdbz,@color,"red")
   lrtopdbz_gl = CreateGline(@wid,cdbz_wo,@type,"Y",@yvec,LRtopdbz,@color,"green")
   lrdbz_gl = CreateGline(@wid,lrdbz_wo,@type,"Y",@yvec,LRVEC,@color,"cyan")
   strmtop_gl = CreateGline(@wid,lrdbz_wo,@type,"XY",@yvec,Strm_t,@xvec,Strm_r,@color,"green",@ltype,"points","triangle",@symsize,1.5)
   strmtopSQ_gl = CreateGline(@wid,lrdbz_wo,@type,"XY",@yvec,StrmSQ_t,@xvec,Strm_r)

   mp_gl = CreateGline(@wid,lri_wo,@type,"XY",@yvec,mc_alt,@xvec,mc_rng,@color,"pink")
   setGline( mp_gl,@ltype,"symbol","diamond",@symsize,1.5,@symhue,RED)


   setGline( strmtopSQ_gl,@color,"red",@ltype,"points","diamond",@symsize,1.5,@symhue,RED)

   strmmidSQ_gl = CreateGline(@wid,lrdbz_wo,@type,"XY",@yvec,StrmSQ_m,@xvec,Strm_r)
   setGline( strmmidSQ_gl,@color,"red",@ltype,"points","cross",@symsize,1.5,@symhue,YELLOW)

   strmcbaseSQ_gl = CreateGline(@wid,lrdbz_wo,@type,"XY",@yvec,StrmSQ_cbase,@xvec,Strm_r)
   setGline( strmcbaseSQ_gl,@color,"red",@ltype,"points","star",@symsize,1.5,@symhue,GREEN)



   adbz_gl = CreateGline(@wid,adbz_wo,@type,"XY",@yvec,ALTVEC,@xvec,LRADBZ,@color,"red")
   ndbz_gl = CreateGline(@wid,adbz_wo,@type,"XY",@yvec,ALTVEC,@xvec,SQ_LRADBZ,@color,"green")
   xdbz_gl = CreateGline(@wid,adbz_wo,@type,"XY",@yvec,ALTVEC,@xvec,LRXADBZ,@color,"blue")

   pkdbzr_gl = CreateGline(@wid,pkdbzr_wo,@type,"XY",@yvec,ALTVEC,@xvec,CCRV,@color,"red")

   CI =getWoClip(lri_wo)

<<"%V$CI \n"


  //plotPixRect(lri_wo,N_UL,mapi)
  //plotPixRect(sri_wo,U,mapi)
  //plotsymbol(lri_wo,120,60,"triangle",5)


//  axis warping ?

//  image transforms


    //Text(aw,fn,0.1,0.1,1)
//////////////////////////////// CLOUD SWEEP SCREEN 2 //////////////////////////////////////

    aw2= CreateGwindow(@title,"CLOUD_SWEEP2")

    SetGwindow(aw2,@resize,0.01,0.15,0.95,0.95,1)
    SetGwindow(aw2,@drawon,@pixmapon,@save)
    SetGwindow(aw2,@clip,0.1,0.1,0.95,0.9)

   sri_wo=createGWOB(aw2,@GRAPH,@resize,0.1,0.1,0.49,0.65,@name,"PY",@color,"white")

   CI =getWoClip(sri_wo)

   sri_nxp = CI[3] - CI[1]
   sri_nyp = CI[4] - CI[2]

   setgwob(sri_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.9,0.9,@scales,0,0,256,120,@savescales,0)
   // for pixmap on --- need to first save image


///////////////////////////////////////////////////////////////////////////////
