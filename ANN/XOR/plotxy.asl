#/* -*- c -*- */
// plotxy

setdebug(0)

// default pipe records to script
// choose  Y cols



<<" xy data should be comma delimited!\n"

y_label = "Y-LABEL";
x_label = "X-LABEL";
ln_label = "";



proc redraw_fig()
 {
   sWo(grwo,@clipborder,@border);
    axnum(grwo,2);
    axnum(grwo,1);

     setGline(refgl,@draw);

     sWo(grwo,@textr,ln_label, 0.5,0.1);
   
   //  sWo(grwo,@textr,y_label, 1,0.5,0,-90,"blue");

   //  sWo(grwo,@textr,y_label, 3,0.6,0,90,"red");

     //text(grwo,"Y-label-above-axis", 0.5,0.05,1,0,0,"green")

      text(grwo,"X-label-above-axis", 0.7,-3,3,0,0,"blue")
    // text(grwo,x_label, 0.7,-3,3,0,0,"blue")

     text(grwo,"X-label-below-axis", 0.2,1,3,0,0,"black");

     
    // text(grwo,"Y-label-left-of-axis", 0.1,0.5,4,90,0,"red")
    // text(grwo,"Y-label-left-of-axis", -0.2,0.2,2,-90,0,"orange")


      //     Axtext(grwo,4,y_label,0.5,4,"green");
    //Axtext(grwo,3,x_label,0.5,2,"red");
      Axtext(grwo,1,x_label,2,0.5,"orange");
      Axtext(grwo,2,y_label,0.5,2,"cyan");
 }

//====================================================


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
    else if (key @= "xlabel") {
        x_label = val
    }
    else if (key @= "label") {
        ln_label = val
    }    

  }

<<"DONE ARGS $na $ka \n"


  ////////////////////////////////////////////////////////////////////////////////////


     R = ReadRecord(A,@type,FLOAT_,@NCOLS,ncols,@del,',')

  sz = Caz(R);

dmn = Cab(R);

nrows = dmn[0]

<<"%V$nrows \n"

<<"%V$sz $dmn\n"

sz = Caz(R)

// check # cols

  YV = R[::][1]

  Redimn(YV)

  sz = Caz(YV)
<<"ysz $sz \n"

  // if want to exclude neg and 0
  MM= Stats(YV,">",0)
  // but we don't
  MM= Stats(YV)

  nsz = sz -1

<<"%V9.6f${YV[0:10]} \n"

  //<<"%V6.4f${YV[0:nsz]} \n"

<<"%6.2f$(typeof(MM)) $MM \n"




// setup scaling

      ymin = MM[5] - MM[4]

      ymax = MM[6] + MM[4]

	//      ymax = MM[6]



  
  XV = R[::][0]
    
  Redimn(XV)

  sz = Caz(XV)
<<"xsz $sz \n"



<<"%V9.6f${XV[0:10]} \n"

  XMM = Stats(XV)

  xmin = XMM[5]

  xmax = XMM[6]

      <<"%V$xmin $xmax \n"

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
    aw= cWi(@title,"PLOTXY",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    sWi(aw,@resize,0.1,0.1,0.9,0.7,0)
    sWi(aw,@drawon)
    sWi(aw,@clip,0.1,0.1,0.8,0.9)

  // GraphWo


   grwo=createGWOB(aw,@GRAPH,@resize,0.15,0.1,0.95,0.95,@name,"PlotXY",@color,"white")

   sWo(grwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)

<<" ${YV[0:3]} \n"
   refgl=cGL(grwo, @TXY,XV, YV, @color, "blue",@usescales,0)

   setGline(refgl,@draw)

  // redraw
  // if not gwm -exit


  plw = aw

  pfname ="ypic"


    xsc = 1/360.0
    ysc = 1.0


include "gevent.asl";


sWo(grwo,@clipborder);
axnum(grwo,2);
axnum(grwo,1);

  sGl(refgl,@draw);


  redraw_fig();

  while (1) {


    eventWait()

    if ((ev_keyw @= "REDRAW") || (ev_keyw @= "RESIZE")) {
      redraw_fig()
    }

  }


////////////////////////////////////////////////////////

 /{

    woysp = 0.03
    woht = 0.07

    woy = 0.8
    woY = woy + woht

    woxwd = 0.09

    wox = 0.9
    woX = wox + woxwd

    zoywo=w_CreateWO(aw,"ONOFF","ZOY",1,wox,woy,woX,woY,2,"red","medium","white")

    woset(zoywo,"help","Zoom out Y axis")

    woY = woy - woysp
    woy = woY - woht

    ziywo=w_CreateWO(aw,"ONOFF","ZIY",1,wox,woy,woX,woY,2,"blue","medium","white")

    woset(ziywo,"help","Zoom in Y axis")

    woY = woy - woysp
    woy = woY - woht

    zoxwo=w_CreateWO(aw,"ONOFF","ZOX",1,wox,woy,woX,woY,2,"red","medium","white")

    woset(zoxwo,"help","Zoom out X axis")

    woY = woy - woysp
    woy = woY - woht

    zixwo=w_CreateWO(aw,"ONOFF","ZIX",1,wox,woy,woX,woY,2,"blue","medium","white")

    woset(zixwo,"help","Zoom in X axis")

    woY = woy - woysp
    woy = woY - woht

    puywo=w_CreateWO(aw,"ONOFF","PUY",1,wox,woy,woX,woY,2,"blue","medium","white")
    woset(puwwo,"help","Pan up Y axis")

    woY = woy - woysp
    woy = woY - woht

    pdywo=w_CreateWO(aw,"ONOFF","PDY",1,wox,woy,woX,woY,2,"blue","medium","white")
    woset(pdywo,"help","Pan down ")

    woY = woy - woysp
    woy = woY - woht

    plwo=w_CreateWO(aw,"ONOFF","PANL",1,wox,woy,woX,woY,2,"blue","medium","white")
    woset(plwo,"help","Pan left ")

    woY = woy - woysp
    woy = woY - woht

    prwo=w_CreateWO(aw,"ONOFF","PANR",1,wox,woy,woX,woY,2,"red","medium","white")
    woset(prwo,"help","Pan right ")
 
/}





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
      sWi(aw,"usescales",0)
      PanUp(aw)
      zoomit = 1
    }

    if (msg @= "PDY") {
      PanDown(aw)
      zoomit = 1
    }


    if ( (msg @= "REDRAW") || (msg @= "RESIZE") || (msg @= "RESCALE") || zoomit || (msg @= "PRINT")) {

      //    sWi(aw,"scales",xmin,ymin,xmax+xpad,ymax,"savescales",0)
   
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
