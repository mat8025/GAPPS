#/* -*- c -*- */

// plotxy

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

  //<<"%V$nrows \n"

  //<<"%V$sz $dmn\n"

ncols = dmn[1]

  //<<"%V$ncols \n"

  // tim 




sz = Caz(R)

// check # cols

  YV = R[::][1]

  Redimn(YV)

  sz = Caz(YV)
  //<<"ysz $sz \n"

  // if want to exclude neg and 0
  MM= Stats(YV,">",0)
  // but we don't
  MM= Stats(YV)

  nsz = sz -1

  //<<"%V6.4f${YV[0:nsz]} \n"

<<"%6.2f$(typeof(MM)) $MM \n"

// setup scaling

      ymin = MM[1] - 2*MM[4]

      ymax = MM[1] + 5*MM[4]

	//      ymax = MM[6]





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


  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

  aslw = asl_w("PLOT_Y")

// Window
    aw= CreateGwindow(@title,"TIME_ALT",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.1,0.02,0.9,0.3,0)
    SetGwindow(aw,@drawon)
    SetGwindow(aw,@clip,0.1,0.1,0.8,0.9)

    crw= CreateGwindow(@title,"CLIMB_LPDB",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

    SetGwindow(crw,@resize,0.1,0.32,0.9,0.62,0)
    SetGwindow(crw,@drawon)
    SetGwindow(crw,@clip,0.1,0.1,0.8,0.9)


    fpw= CreateGwindow(@title,"FLIGHT_PHASE",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

    SetGwindow(fpw,@resize,0.1,0.65,0.9,0.95,0)
    SetGwindow(fpw,@drawon)
    SetGwindow(fpw,@clip,0.1,0.1,0.8,0.9)


  // GraphWo


   grwo=createGWOB(aw,@GRAPH,@resize,0.12,0.1,0.95,0.95,@name,"PXY",@color,"white")

   setgwob(grwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)


   crwo=createGWOB(crw,@GRAPH,@resize,0.12,0.1,0.95,0.95,@name,"PFP",@color,"white")

   setgwob(crwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,xmin,-3000,xmax+xpad,3000,@savescales,0)


   fpwo=createGWOB(fpw,@GRAPH,@resize,0.12,0.1,0.95,0.95,@name,"PFP",@color,"white")

   setgwob(fpwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,xmin,-3,xmax+xpad,3,@savescales,0)

  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)

  //<<" ${YV[0:3]} \n"

  refgl=CreateGline(@woid,grwo,@type,"XY",@xvec,XV,@yvec, YV, @color, "blue",@usescales,0)

  setGline(refgl,@draw)

  climbgl=CreateGline(@woid,crwo,@type,"XY",@xvec,XV,@yvec, CLIMB, @color, "blue",@usescales,0)

  setGline(climbgl,@draw)

  lpdbgl=CreateGline(@woid,crwo,@type,"XY",@xvec,XV,@yvec, LPDB, @color, "red",@usescales,0)

  setGline(lpdbgl,@draw)

  fpgl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@yvec, FP, @color, "green",@usescales,0)

  setGline(fpgl,@draw)




      // redraw
      // if not gwm -exit


  plw = aw

  pfname ="ypic"


    xsc = 1/360.0
    ysc = 1.0

  //    RedrawGraph(aw)

  //  DrawAxis(aw, -1, -1, xsc,ysc)

include "event"

Event E

    setGwob(grwo,@clipborder)
    axnum(grwo,2)
    axnum(grwo,1)
    grid(grwo)
    setGline(refgl,@draw)

    setGwob(crwo,@clipborder)
    axnum(crwo,2)
    axnum(fpwo,2)
    axnum(crwo,1)
    grid(crwo)

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

  while (1) {


    E->waitForMsg()

    if ((E->keyw @= "REDRAW") || (E->keyw @= "RESIZE")) {
      //    <<"REDRAW \n"
    setGwob(grwo,@clipborder,@border)
    setGwob(fpwo,@clipborder,@border)
    setGwob(crwo,@clipborder,@border)

    axnum(grwo,2)
    axnum(fpwo,2)
    axnum(fpwo,4)
    axnum(grwo,1)
    axnum(crwo,2)

    setGline(refgl,@draw)
    setGline(climbgl,@draw)
    setGline(lpdbgl,@draw)
    setGline(fpgl,@draw)

    //setGwob(grwo,@textr,"Time", 0.5,0.1)
    //    setGwob(grwo,@textr,"Y-label", 0.05,0.2,0,-90,"blue")
    //text(grwo,"Y-label-above-axis", 0.5,0.05,1,0,0,"green")

    //    text(grwo,"Time", 0.7,-3,3,0,0,"blue")
    text(grwo,"Time", 0.2,-2,3,0,0,"black")
    text(grwo,"Altitude", -5,0.9,4,-90,0,"black")
    //text(grwo,"Y-label-left-of-axis", -1.5,0.2,4,-90,0,"orange")
      text(fpwo,"Flight Phase", -4.5,0.9,4,-90,0,"black")
    text(crwo,"Climb Rate", -5,0.9,4,-90,0,"black")
    }



  }








STOP!
