#/* -*- c -*- */
// plots   multiple y's against x
// first col is x value  all other cols are different y's  

setdebug(0)

// default pipe records to script
// choose  Y cols
y_label = "Y-LABEL"
x_label = "X-LABEL"


proc redraw_fig()
 {
    setGwob(grwo,@clipborder,@border)

    axnum(grwo,2)
    axnum(grwo,1)

    for (i = 0; i < nylines ; i++) {
      //      setGline(ygl[i],@draw)
      // FIXME
       //setGline(ygl[i],@yvec,R[::][i+1], @draw)
       setGline(ygl[i], @draw)


    }

    //setGwob(grwo,@textr,x_label, 0.5,0.1)
    //setGwob(grwo,@textr,y_label, -0.05,0.5,0,-90,"blue")

    //text(grwo,"Y-label-above-axis", 0.5,0.05,1,0,0,"green")

    //    text(grwo,"X-label-below-axis", 0.7,-3,3,0,0,"blue")
    // text(grwo,x_label, 0.7,-3,3,0,0,"blue")

    //    text(grwo,"X-label-below-axis", 0.2,-1,3,0,0,"black")
    // text(grwo,"Y-label-left-of-axis", 0.1,0.5,4,90,0,"red")
    //text(grwo,"Y-label-left-of-axis", -0.2,0.2,2,-90,0,"orange")


    // Axtext(grwo,4,y_label,0.5,2,"green")
    // Axtext(grwo,3,x_label,0.5,2,"red")
    Axtext(grwo,1,x_label,0.5,2,"orange")
    Axtext(grwo,2,y_label,0.5,2,"cyan",90)
 }




A = 0  // read on stdio

ncols = 2

int YCOL[10+]

 YCOL[0] = 0
 int ac =2
 int i = 0

i = 1
ncols = i
pars = i
ycol = 1

  ///////////////////////////////////   CL_args //////////////////////////////////////


  na = argc()  // how many command line args

  ka = 1


  while ( ka < na ) {
  
    key = _clarg[ka] ; ka++
    val = _clarg[ka] ; ka++
<<"$ka $key $val\n" 

    if (key @= "ylabel") {
        y_label = val
    }
    if (key @= "xlabel") {
        x_label = val
    }

  }

<<"DONE ARGS $na $ka \n"


  ////////////////////////////////////////////////////////////////////////////////////

float ymin = 0
float ymax = 1

  //R = ReadRecord(A,@type,FLOAT,@NCOLS,ncols)
   R = ReadRecord(A,@type,FLOAT)


     sz = Caz(R)

     dmn = Cab(R)

nrows = dmn[0]

<<"%V$nrows \n"

ncols = dmn[1]
nylines = ncols -1
<<"%V$ncols \n"

<<"%V$sz $dmn\n"

sz = Caz(R)

// check # cols
// for each col - we want a different gline

  YV1 = R[::][1]

  Redimn(YV1)

  YV2 = R[::][2]

  Redimn(YV2)

  
  for (i = 0; i < nylines; i++) {

  YV = R[::][i+1]

  Redimn(YV)

  sz = Caz(YV)
<<"ysz $sz \n"

  // if want to exclude neg and 0
  MM= Stats(YV,">",0)
  // but we don't
  MM= Stats(YV)

  nsz = sz -1

<<"%V6.4f${YV[0:nsz]} \n"

<<"%6.2f$(typeof(MM)) $MM \n"

// setup scaling

      yval = MM[1] - 2*MM[4]
  if (yval < ymin) {
        ymin = yval
  }

      yval = MM[1] + 5*MM[4]

	//      ymax = MM[6]
  if (yval > ymax) {
        ymax = yval
  }

  }



  XV = R[::][0]
    
      <<"%V$xmin $xmax \n"
  XMM = Stats(XV)

  xmin = XMM[5]

  xmax = XMM[6]


  xrange = fabs(xmax-xmin)
 
  xpad=xrange * 0.05


<<" %V$ymin $ymax \n" 
<<" %V$xmin $xmax \n" 







  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

  aslw = asl_w("PLOT_Y")

// Window
    aw= CreateGwindow(@title,"PLOTXY",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.1,0.1,0.9,0.7,0)
    SetGwindow(aw,@drawon)
    SetGwindow(aw,@clip,0.1,0.1,0.8,0.9)

  // GraphWo


   grwo=createGWOB(aw,@GRAPH,@resize,0.15,0.1,0.95,0.95,@name,"PXY",@color,"white")

   setgwob(grwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

  //////////////////////////////////////////////////////////////////////////////////

  int hue = RED; 
  int ygl[nylines];

// FIXME
/{
  ygl[0]=CreateGline(@woid,grwo,@type,"XY",@xvec, XV, @yvec, R[::][1], @color, "red",@usescales,0)
  ygl[1]=CreateGline(@woid,grwo,@type,"XY",@xvec, XV, @yvec, R[::][2], @color, "blue",@usescales,0)
/}

  for (i = 1; i < nylines ; i++) {
    YV3 = R[::][i+1];

  }


  ygl[0]=CreateGline(@woid,grwo,@type,"XY",@xvec, XV, @yvec, YV1, @color, "red",@usescales,0)
  ygl[1]=CreateGline(@woid,grwo,@type,"XY",@xvec, XV, @yvec, YV3, @color, "blue",@usescales,0)

    /{
  for (i = 1; i < nylines ; i++) {


  ygl[i]=CreateGline(@woid,grwo,@type,"XY",@xvec, XV, @yvec, R[::][i+1], @color, hue++ ,@usescales,0)
  setGline(ygl[i],@draw)

  }
  /}
  // redraw
  // if not gwm -exit






  plw = aw

  pfname ="ypic"


    xsc = 1/360.0
    ysc = 1.0



include "event"

Event E

    setGwob(grwo,@clipborder)
    axnum(grwo,2)
    axnum(grwo,1)

    setGline(refgl,@draw)


  redraw_fig()

  while (1) {


    E->waitForMsg()

    if ((E->keyw @= "REDRAW") || (E->keyw @= "RESIZE")) {
      //    <<"REDRAW \n"
      redraw_fig()


    }



  }




  /////////////////////////  REDO the ZOOM - PAN features ///////////////////////////////



/{
   while (1) {

    WoRedraw(plw)

    zoomit = 0


    if ( ! (msg @= "NO_MSG")) {

    zmn = msg 
    winid = Minfo[2]

    if ( (msg @= "PRINT") ) {
     open_laser(pfname)
     scr_laser(plw)
     gsync()
    }


    if (msg @= "PANR") {
   

      PanRight(plw)

   

      zoomit = 1
    }

    if (msg @= "PANL") {
      PanLeft(plw)
      zoomit = 1
    }

    if ((msg @= "ZOY")) {
      ZoomOutYaxis(plw)
      zoomit = 1
    }

    if (msg @= "ZOX") {
      ZoomOutXaxis(plw)
      zoomit = 1
    }

    if (msg @= "ZIY") {
      ZoomInYaxis(plw)
      zoomit = 1
    }

    if (msg @= "ZIX") {
      ZoomInXaxis(plw)
      zoomit = 1
    }

    if (msg @= "PUY") {
      SetGwindow(aw,"usescales",0)
      PanUp(aw)
      zoomit = 1
    }

    if (msg @= "PDY") {
      PanDown(aw)
      zoomit = 1
    }


    if ( (msg @= "REDRAW") || (msg @= "RESIZE") || (msg @= "RESCALE") || zoomit || (msg @= "PRINT")) {

      //    SetGwindow(aw,"scales",xmin,ymin,xmax+xpad,ymax,"savescales",0)
   
    RedrawGraph(aw)
   
    DrawAxis(aw, -1, -1)
    }


    if ( (msg @= "PRINT") ) {
          CloseLaser()
          laser_scr(plw)
          gsync()
              <<" cat $pfname | lpr "
              si_pause(5)
              <" cat $pfname | lpr "

    }

   }

 }

 /}




STOP!
