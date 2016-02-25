#/* -*- c -*- */
# "$Id: plotxy,v 1.1 2003/06/25 07:08:30 mark Exp mark $"

// default pipe records to script
// choose X  & Y cols
    //
    // want this to also accept include "plotlib"  or "$dir/plotlib"

    // want this to also accept include "plotlib"  or "$dir/plotlib"
    // this should be an alias to lib location
    // include should look in tools/PLOT/plotlib or LIB/plotlib

include tools/PLOT/plotlib

    //include plotlib


    SetDebug(0)


proc ReadXY()
{

 fname = $ac++
   // ac++

   A= ofr(fname)
    //<<" %V $A $fname \n"

  xcol = $ac++

  ycol = $ac++

<<" $xcol $ycol \n"

      if (do_labels)
        l_label = $ac++


 R = ReadRecord(A,"type","float")
     cf(A)

     sz = Caz(R)

     dmn = Cab(R)

    nrows = dmn[0]

<<" %v $nrows \n"

<<" $sz $dmn \n"

    //<<" $R[0;nrows-1][*] \n"

// check # cols

	  NXV = R[*][xcol]
	  NYV = R[*][ycol]

  }



#defaults

 do_labels = 0

      // filename  xcol ycol  , file2 xcol ycol , ....

      //<<" $0 $1 $2 $3 \n"
 na= argc()

 set_ymin = 0
 set_ymax = 0

 ymin_arg = 0.0
 ymax_arg = 1.0


   ac = 2
  

       move_on = 0

      while (1) {
       move_on = 1
         fa = $ac
      if (fa @= "ymin") {
         ac++
        ymin_arg = $ac++
       set_ymin = 1
        move_on = 0
      }

      if (fa @= "ymax") {
         ac++
        ymax_arg = $ac++
       set_ymax = 1
        move_on = 0
      }

      if (fa @= "labels") {
         ac++
         do_labels = 1
      }

       if (move_on) break
       
      }


     int   nxyp = (na -ac) /3

   // next
   // file and col args
 fname = $ac++

<<" $na $nxyp $ac \n"
   A= ofr(fname)
<<" %V $A $fname \n"

     l_label = "L1"
xcol = $ac++

ycol = $ac++

      if (do_labels)
        l_label = $ac++




<<" $xcol $ycol \n"

pars = 1
nyxp = 1

 R = ReadRecord(A,"type","float")

     cf(A)
     sz = Caz(R)

     dmn = Cab(R)

nrows = dmn[0]

<<" %v $nrows \n"

<<" $sz $dmn \n"

    //<<" $R[0;nrows-1][*] \n"

// check # cols

XV = R[*][xcol]
YV = R[*][ycol]


  //XV -= XV[0]

   MM= Stats(YV)

  Redimn(XV)
  Redimn(YV)
  sz = Caz(YV)

<<" %6.2f $(typeof(MM)) $MM \n"

// setup scaling
  

      ymin = MM[5]
      ymax = MM[6]

      xmin = XV[0]
      xmax = XV[sz-1]
    
  // ymin - anchor

      if (set_ymin) {
       ymin  = ymin_arg
      }

      if (set_ymax) {
       ymax  = ymax_arg
      }

      //<<" %V $xmin $xmax \n"

 Graphic = CheckGwm()

<<" %v $Graphic \n"

if (! Graphic) STOP!

  xrange = fabs(xmax-xmin)
  xpad=xrange * 0.1


   aw= CreateGwindow("title","Y","scales",xmin,ymin,xmax+xpad,ymax,"savescales",0))

//<<" CGW $aw \n"

    SetGwindow(aw,"resize",0.1,0.1,0.9,0.7,0)
    SetGwindow(aw,"drawon")


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

<<" $YV[0;3] \n"

    // filter out values

    //  SZ=Sel(PAR2,"<",0)
    //  PAR2[SZ] = 0
  clr = 1




										 

  refgl=CreateGline("wid",aw,"type","XY","xvec",XV,"yvec",YV,"color", "blue","name",l_label,"usescales",0)
  clr = 2
    // compare another YV

  exyp = 2

  float NXV[]
  float NYV[]

  while (exyp <= nxyp) {


     l_label = "L$exyp"

     ReadXY()

     aprgl=CreateGline("wid",aw,"type","XY","xvec",NXV,"yvec",NYV,"color",clr++,"name",l_label, "usescales",0)

     exyp++
   }
      // redraw
      // if not gwm -exit


    pfname ="ypic"

  //      RedrawGraph(aw)

      WoRedraw(aw)
      RedrawGraph(aw)

    zoomit = 1

   while (1) {

    WoRedraw(aw)

    w_activate(aw)

    msg = MessageWait(Minfo)
    //<<" $msg $Minfo \n"

    if ( ! (msg @= "NO_MSG") ) {

    zmn = msg 
    winid = Minfo[2]

    if ( (msg @= "PRINT") ) {
     open_laser(pfname)
     scr_laser(aw)
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
      ZoomOutYaxis(aw)
      zoomit = 1
    }

    if (msg @= "ZOX") {
      ZoomOutXaxis(aw)
      zoomit = 1
    }

    if (msg @= "ZIY") {
      ZoomInYaxis(aw)
      zoomit = 1
    }

    if (msg @= "ZIX") {
      ZoomInXaxis(aw)
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


  if ( (msg @= "RESCALE") || (msg @= "REDRAW") || (msg @= "RESIZE") ||  zoomit || (msg @= "PRINT")) {


      RedrawGraph(aw)

      ShowFileN(aw, fname)
      
      if (do_labels) {
	// dig out gline names

	LabelGline(refgl, 0.9,0.7)      
	LabelGline(aprgl ,0.9,0.9)      

      }
    }


    if ( (msg @= "PRINT") ) {
          CloseLaser()
          laser_scr(aw)
          gsync()
              <<" cat $pfname | lpr "
              si_pause(5)
              <" cat $pfname | lpr "

    }

   }

    zoomit = 0

   }




STOP!
