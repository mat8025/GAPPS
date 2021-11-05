#/* -*- c -*- */



 setdebug(0)


// default pipe records to script
// choose  Y cols


A = 0  // read on stdio

ncols = 2

int YCOL[10+]

 YCOL[0] = 0
 int ac =2
 int i = 0


i = 1
ncols = i
pars = i

  //<<" $YCOL \n"

ycol = 1


  // R = ReadRecord(A,@type,FLOAT,@NCOLS,ncols)
 R = ReadRecord(A,@type,FLOAT)

     sz = Caz(R)

     dmn = Cab(R)

nrows = dmn[0]

<<"%V$nrows \n"

<<"%V$sz $dmn\n"

ncols = dmn[1]

<<"%V$ncols \n"

  // tim 




sz = Caz(R)

// check # cols

  YV = R[::][1]

  Redimn(YV)

  sz = Caz(YV)
  //<<"ysz $sz \n"

  // if want to exclude neg and 0
  //MM= Stats(YV,">",0)
  // but we don't
  MM= Stats(YV)

  nsz = sz -1

  //<<"%V6.4f${YV[0:nsz]} \n"

<<"%6.2f$(typeof(MM)) $MM \n"

// setup scaling

//      ymin = MM[1] - 2*MM[4]
//      ymax = MM[1] + 5*MM[4]

  float altmax = MM[6] + 500


  



  XV = R[::][0]
    
      <<"%V$xmin $xmax \n"
  XMM = Stats(XV)

  xmin = XMM[5]

  xmax = XMM[6]


  xrange = fabs(xmax-xmin)
 
  xpad=xrange * 0.05


<<" %V$ymin $ymax \n" 
<<" %V$xmin $xmax \n" 

  CLIMB = R[::][2]
  LPDB = R[::][3]
  FP = R[::][4]

  //<<"%V$FP \n"

  MM = Stats(FP)
   ymin = MM[5]
   ymax = MM[6] 

   fpymax = ymax * 1.5
   fpymin = ymin - 0.2
   fpymin = -1.2

  if (fpymax < 1.2)
      fpymax = 1.2

<<"%V$fpymax  $ymax \n"

  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

  aslw = asl_w("PLOT_FP")

// Window
    aw= CreateGwindow(@title,"TIME_ALT",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.1,0.02,0.9,0.3,0)
    SetGwindow(aw,@drawon)
    SetGwindow(aw,@clip,0.1,0.12,0.8,0.9)

    crw= CreateGwindow(@title,"CLIMB_LPDB",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

    SetGwindow(crw,@resize,0.1,0.32,0.9,0.62,0)
    SetGwindow(crw,@drawon)
    SetGwindow(crw,@clip,0.1,0.12,0.8,0.9)


    fpw= CreateGwindow(@title,"FLIGHT_PHASE",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

    SetGwindow(fpw,@resize,0.1,0.65,0.9,0.95,0)
    SetGwindow(fpw,@drawon)
    SetGwindow(fpw,@clip,0.1,0.12,0.8,0.9)


  // GraphWo


   grwo=createGWOB(aw,@GRAPH,@resize,0.12,0.1,0.95,0.95,@name,"PXY",@color,"white")

   setgwob(grwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,xmin,0,xmax+xpad,altmax,@savescales,0)


   crwo=createGWOB(crw,@GRAPH,@resize,0.12,0.1,0.95,0.95,@name,"PFP",@color,"white")

   setgwob(crwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,xmin,-3000,xmax+xpad,3000,@savescales,0)


   fpwo=createGWOB(fpw,@GRAPH,@resize,0.12,0.1,0.95,0.95,@name,"PFP",@color,"white")



  //setgwob(fpwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,xmin,-1.1,xmax+xpad,1.1,@savescales,0)
  setgwob(fpwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,0,fpymin,xmax+xpad,fpymax,@savescales,0)

  //////////////////////////////////////////////////////////////////////////////////

  SA = YV * (1.0/altmax)
 
    dmn = Cab(YV)

<<" ${YV[0:3]} \n"

  refgl=CreateGline(@woid,grwo,@type,"XY",@xvec,XV,@yvec, YV, @color, "blue",@usescales,0)

  setGline(refgl,@draw)

  climbgl=CreateGline(@woid,crwo,@type,"XY",@xvec,XV,@yvec, CLIMB, @color, "blue",@usescales,0)

  setGline(climbgl,@draw)

  lpdbgl=CreateGline(@woid,crwo,@type,"XY",@xvec,XV,@yvec, LPDB, @color, "red",@usescales,0)

  setGline(lpdbgl,@draw)

  fpgl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@yvec, FP, @color, "green",@usescales,0)

  setGline(fpgl,@draw)

  fpagl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@yvec, SA, @color, "red",@usescales,0)

  setGline(fpagl,@draw)




  
      // redraw
      // if not gwm -exit


  plw = aw

  pfname ="ypic"


    xsc = 1/360.0
    ysc = 1.0

  //    RedrawGraph(aw)

  //  DrawAxis(aw, -1, -1, xsc,ysc)

  do_laser = 0
  if (do_laser) {
      OpenLaser("flightphase.ps")
      ScrLaser(aw)
      ScrLaser(crw)
      ScrLaser(fpw)
    }



include "event"

Event E

    setGwob(grwo,@clipborder)
    axnum(grwo,2)
    
    grid(grwo)
    setgwob(fpwo,@gridhue,BLUE)
    grid(fpwo,60,0.2)
    
    setGline(refgl,@draw)

    setGwob(crwo,@clipborder)
    axnum(crwo,2)
    axnum(fpwo,2,-1.2,1.2,0.2)
    axnum(crwo,1)
    axnum(fpwo,1, 0, xmax, 60)
  //grid(crwo)

    axnum(grwo,1, 0, xmax, 60)

    setGline(climbgl,@draw)
    setGline(lpdbgl,@draw)
    setGline(fpgl,@draw)

    setGwob(grwo,@clipborder,@border)
    setGwob(fpwo,@clipborder,@border)
    setGwob(crwo,@clipborder,@border)

    text(grwo,"Time", 0.2,-2,3,0,0,"black")
    text(grwo,"Altitude", -5,0.9,4,-90,0,"black")
    text(crwo,"Climb Rate", -5,0.9,4,-90,0,"black")
    text(fpwo,"Flight Phase", -4.5,0.9,4,-90,0,"black")



   if (do_laser) {
      LaserScr(aw)
      LaserScr(crw)
      LaserScr(fpw)
      CloseLaser()
      stop!
    }

 
  while (1) {


    E->waitForMsg()
    redraw_screen = 0

    if (E->keyw @= "RESIZE")
        redraw_screen = 1 
    if (E->keyw @= "REDRAW")
        redraw_screen = 1 
    if (E->keyw @= "MOVE")
        redraw_screen = 1 



    //if ((E->keyw @= "REDRAW") || (E->keyw @= "RESIZE")) {
	  //if ((E->keyw @= "RESIZE") || (E->keyw @= "REDRAW")) {
      //    <<"REDRAW \n"

   if (redraw_screen) {
    setGwob(grwo,@clipborder,@border)
    setGwob(fpwo,@clipborder,@border)
    setGwob(crwo,@clipborder,@border)

    axnum(grwo,2)


    axnum(fpwo,4)

    axnum(grwo,1, 0, xmax, 60)
    grid(awo)
    axnum(fpwo,1, 0, xmax, 60)
    axnum(fpwo,2,-1.2,1.2,0.2)
    axnum(crwo,2)
    grid(fpwo,60,0.2)
    setGline(refgl,@draw)
    setGline(climbgl,@draw)
    setGline(lpdbgl,@draw)
    setGline(fpgl,@draw)
    setGline(fpagl,@draw)

    //setGwob(grwo,@textr,"Time", 0.5,0.1)
    //    setGwob(grwo,@textr,"Y-label", 0.05,0.2,0,-90,"blue")
    //text(grwo,"Y-label-above-axis", 0.5,0.05,1,0,0,"green")

    //    text(grwo,"Time", 0.7,-3,3,0,0,"blue")

    text(fpwo,"Time", 0.2,-2,3,0,0,"black")
    text(grwo,"Time", 0.2,-2,3,0,0,"black")
    text(grwo,"Altitude", -5,0.9,4,-90,0,"black")
    //text(grwo,"Y-label-left-of-axis", -1.5,0.2,4,-90,0,"orange")
    text(fpwo,"Flight Phase", -4.5,0.9,4,-90,0,"black")
    text(crwo,"Climb Rate", -5,0.9,4,-90,0,"black")
    }



  }









