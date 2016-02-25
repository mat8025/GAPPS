#/* -*- c -*- */
# "$Id: plotxy,v 1.1 2003/06/25 07:08:30 mark Exp mark $"

// default pipe records to script
// choose  Y cols
    //
    // want this to also accept include "plotlib"  or "$dir/plotlib"
    // this should be an alias to lib location

tools = "/usr/local/GASP/GASP-3.2.0/TOOLS/"
include "$tools/PLOT/plotlib"

A = 0

      // get num of cols

ncols = 1

int YCOL[10+]
YCOL[0] = 0
 int ac =2
 int i = 0

#{
 while (1) {

 if ($ac @= "")
 break 

 YCOL[i]=  $ac
 <<" %v $ac $YCOL[i] \n"
 ac++
 i++
 }
 #}

i = 1
ncols = i
pars = i

<<" $YCOL \n"

ycol = 1


 R = ReadRecord(A,"type","float")

     sz = Caz(R)

     dmn = Cab(R)

nrows = dmn[0]

<<" %v $nrows \n"

<<" %V $sz $dmn \n"

    <<" ${R[0:5000][0]} \n"

// check # cols



  YV = R[*][YCOL[0]]
    
//      yi = YCOL[0]
//      YV = R[*][yi]

      // if want to exclude
    MM= Stats(YV,">",0)


  Redimn(YV)
  sz = Caz(YV)

<<" %6.2f $(typeof(MM)) $MM \n"

// setup scaling

      ymin = MM[1] - 2*MM[4]

      ymax = MM[1] + 5*MM[4]

	//      ymax = MM[6]


	// GOP
      ymax = 130

      xmin = 0
      xmax = sz-1

  XV = Fgen(sz,0,1)
    
      <<" %V $xmin $xmax \n"

 Graphic = CheckGwm()

<<" %v $Graphic \n"

if (! Graphic) STOP!

  xrange = fabs(xmax-xmin)
  xpad=xrange * 0.1

aw= CreateGwindow("title","PLOTY","scales",xmin,ymin,xmax+xpad,ymax,"savescales",0))

//<<" CGW $aw \n"

    SetGwindow(aw,"resize",0.1,0.1,0.9,0.7,0)
    SetGwindow(aw,"drawon")
    //SetGwindow(aw,"scales",xmin,ymin,xmax,ymax,"savescales",0)

    SetGwindow(aw,"resize",0.1,0.1,0.9,0.90,0)
    SetGwindow(aw,"clip",0.1,0.1,0.8,0.9)

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

  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)

<<" $dmn \n"

<<" $YV[0:3] \n"

    // filter out values



   refgl=CreateGline("wid",aw,"type","XY","xvec",XV,"yvec",YV,"color", "blue","usescales",0)

    //  DrawGline(refgl)
    //  compare another YV

    k = 1
    clr = 2
    while (k < ncols) {
      NYV = R[*][YCOL[k++]]
      prgl=CreateGline("wid",aw,"type","XY","xvec",XV,"yvec",NYV,"color", clr++,"usescales",0)
    }


      // redraw
      // if not gwm -exit


 plw = aw

pfname ="ypic"

   RedrawGraph(aw)

   while (1) {

    WoRedraw(plw)

    zoomit = 0

    w_activate(plw)

    msg = MessageWait(Minfo)


   if ( ! (msg @= "NO_MSG")) {

    zmn = msg 
    winid = Minfo[2]

    if ( (msg @= "PRINT") ) {
     open_laser(pfname)
     scr_laser(plw)
     gsync()
    }


    if (msg @= "PANR") {
      PanRight(aw)
      zoomit = 1
    }
    if (msg @= "PANL") {
      PanLeft(aw)
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
      RedrawGraph(aw)
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






STOP!
