#/* -*- c -*- */


proc drawFPGraph()
{
        
  //    setGwob(fpwo,@clearpixmap)
    setgwob(fpwo,@gridhue,BLUE)

    setgwob(fpwo,@scales,xmin,altmin,xmax+xpad,altmax,@savescales,1)
    setGline(gpsgl,@usescales,1)
      //    setGline(gpsgl,@draw)
      drawGline(gpsgl)
      drawGline(bagl)

axnum(fpwo,4) 

    axnum(fpwo,1, 0, xmax, 60)

setgwob(fpwo,@drawon,@scales,0,fpymin,xmax+xpad,fpymax,@savescales,0)
    axnum(fpwo,2,-1.2,1.2,0.2) 
    setGline(fpgl,@usescales,0)
    setGline(rfpgl,@draw)
    setGline(fpgl,@draw)


    text(fpwo,"Flight Phase", -0.05,0.8,2,-90,0,"black")
      //text(fpwo,"Altitude", 1.05,0.8,2,-90,0,"black")
      //setGwob(fpwo,@showpixmap)
    setGwob(fpwo,@clipborder,@border)
}


comment = ""

   na = Caz(_clarg)

  if (na > 1) {
  comment = _clarg[1]
<<"%V$comment \n"
  }


// default pipe records to script
// choose  Y cols


A = 0  // read on stdio



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

// first line is comment

  comment = readline(A)
<<"%V$comment \n"

  comment = ssub(comment,"#","")

  R = ReadRecord(A,@type,FLOAT,@del,',')

     sz = Caz(R)

     dmn = Cab(R)

     nrows = dmn[0]

<<"%V$nrows \n"

<<"%V$sz $dmn\n"

ncols = dmn[1]

<<"%V$ncols \n"

  // tim 



sz = Caz(R)



  //<<"\n%(4,, ,\n)$R\n"

// check # cols

  YV = R[::][6]

  Redimn(YV)

  //  GYV = R[::][7]

  //  Redimn(GYV)

<<"%V$YV[0:3]\n"

<<"%V$YV[-4:-1]\n"

  sz = Caz(YV)

  //  <<"YV\n %(10,, ,\n)$YV\n"
  Redimn(YV)

  MM= Stats(YV)

  nsz = sz -1

  //<<"%V6.4f$YV[0:nsz] \n"



<<"%6.2f$(typeof(MM)) $MM \n"

// setup scaling

//      ymin = MM[1] - 2*MM[4]
//      ymax = MM[1] + 5*MM[4]

  float altmax = MM[6] + 500

  float altmin = MM[5] 

<<"%V$MM[4] $altmin\n"

  int amin = (altmin/500)
  
       altmin = amin * 500
       altmin -= 500
<<"%V$amin $altmin\n"
 
  sz=Caz(R)
  nd=Cnd(R)
  dmn=Cab(R)

<<"%V$sz $nd $dmn\n"

 XV = R[::][1]
    

  sz=Caz(XV)
  nd=Cnd(XV)
  dmn=Cab(XV)

<<"%V$sz $nd $dmn\n"

  Redimn(XV)


  sz=Caz(XV)
  nd=Cnd(XV)
  dmn=Cab(XV)

  ftime = XV[0]

  //  FIX!  XV = XV - XV[0]

  XV = XV - ftime


<<"%V$sz $nd $dmn\n"

<<"%V$XV[0:3]\n"

<<"%V$XV[-4:-1]\n"

<<"%V$XV[sz-4:sz-1]\n"

<<"%(10,, ,\n)$XV\n"



      <<"%V$xmin $xmax \n"
  XMM = Stats(XV)

  xmin = XMM[5]

  xmax = XMM[6]


  xrange = fabs(xmax-xmin)
 
  xpad=xrange * 0.05


<<" %V$ymin $ymax \n" 
<<" %V$xmin $xmax \n" 

  CLIMB = R[::][9]

  Redimn(CLIMB)

  FP = R[::][10]
  // LPDB = R[::][4]

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

	//  RFP = R[::][11]


  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }




  aslw = asl_w("PLOT_FP")

// Window
    aw= CreateGwindow(@title,"FLIGHT_PHASE",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.01,0.01,0.98,0.98,0)
    SetGwindow(aw,@clip,0.01,0.01,0.98,0.98)

  //  fpwo=createGWOB(aw,@GRAPH,@resize,0.10,0.15,0.97,0.95,@name,"PFP",@color,"white",@pixmapon,@save,@store)
   fpwo=createGWOB(aw,@GRAPH,@resize,0.01,0.01,0.97,0.98,@name,"PFP",@color,"white",@save,@store)

   setgwob(fpwo,@scales,xmin,altmin,xmax+xpad,altmax,@savescales,1)
   setgwob(fpwo,@drawon,@pixmapoff,@clip,0.1,0.1,0.95,0.95,@scales,0,fpymin,xmax+xpad,fpymax,@savescales,0)



  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)

  //<<" ${YV[0:3]} \n"


  //gpsgl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@ycopy, R[::][7], @color, "orange",@ltype,"symbols",@usescales,1)
    gpsgl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@ycopy, R[::][7], @color, "orange",@usescales,1)
    bagl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@ycopy, R[::][6], @color, "green",@usescales,1)

  //SetGline(gpsgl,@symbol,"diamond",10, @fill_symbol,1,@ltype,"lsymbol")
  

  //fpgl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@yvec, FP, @color, GREEN, @usescales,0)
  fpgl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@ycopy, R[::][10], @color, GREEN, @usescales,0)
  // setGline(fpgl,@symbol,"diamond",2, @fill_symbol,1,@ltype,"lsymbol")
  //setGline(fpgl,@draw)

  //  rfpgl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@ycopy, RFP, @color, "blue",@usescales,0)
  rfpgl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@ycopy, R[::][11], @color, "blue",@usescales,0)
  setGline(rfpgl,@ltype,"line")
  //setGline(rfpgl,@symbol,"diamond",2, @fill_symbol,1,@ltype,"lsymbol")
  //setGline(rfpgl,@draw)


      // redraw
      // if not gwm -exit


  plw = aw

  pfname ="ypic"


    xsc = 1/360.0
    ysc = 1.0

  //    RedrawGraph(aw)

  //  DrawAxis(aw, -1, -1, xsc,ysc)


drawFPGraph()

include "lib/event"   // adds event class

Event E

 print_screen = 0

  while (1) {


    E->waitForMsg()
    redraw_screen = 0

    if (E->keyw @= "RESIZE")
        redraw_screen = 1 
    if (E->keyw @= "REDRAW")
        redraw_screen = 1 
    if (E->keyw @= "MOVE")
        redraw_screen = 1 

    if (E->keyw @= "PRINT") {
        redraw_screen = 1 
        print_screen = 1

	//<<"PRINTING SCREEN \n"

	//OpenLaser("flightphase.ps",12,0)
	OpenLaser("flightphase.ps",24,1)
        ScrLaser(aw)
    }



    if (redraw_screen) {
      drawFPGraph()
    }

    if (print_screen) {
     
      drawFPGraph()
      CloseLaser()
      LaserScr(aw)
<<"PRINTING DONE \n"
      print_screen = 0
    }
   

  }



STOP!
