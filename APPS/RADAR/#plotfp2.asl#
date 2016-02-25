#/* -*- c -*- */


proc drawFPGraph()
{
    setGwob(grwo,@clipborder)
        
    setgwob(fpwo,@gridhue,BLUE)
    setgwob(grwo,@gridhue,BLUE)
    grid(fpwo,60,0.2,0,-1)
      //   grid(grwo,60,500,60,0)
    grid(grwo,60,500,0,0)
    
    setGline(refgl,@draw)

    setgwob(grwo,@gridhue,BLUE)
    // setGwob(crwo,@clipborder)
    //axnum(crwo,2)

    axnum(fpwo,2,-1.2,1.2,0.2)
    // axnum(crwo,1)

    axnum(fpwo,1, 0, xmax, 60)
  //grid(crwo)

    axnum(grwo,2)
    axnum(grwo,1, 0, xmax, 60)

    setGline(fpgl,@draw)

    setGwob(grwo,@clipborder,@border)

    setGwob(fpwo,@clipborder,@border)
    

    text(grwo,"Time", 0.2,-2,3,0,0,"black")

    text(grwo,"Altitude", -5,0.9,4,-90,0,"black")
    
    text(fpwo,"Flight Phase", -4.5,0.9,4,-90,0,"black")

    text(fpwo,comment, 0.1,-3.5,3,0,0,"black")
    text(grwo,profile, 0.0,0,5,0,0,"black")
    text(fpwo,intent, 0.1,0,5,0,0,"red")

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

// first line is comment

  comment = readline(A)
<<"%V$comment \n"

  comment = ssub(comment,"#","")
// second line is intent
  intent = readline(A)
  intent = ssub(intent,"#","")
<<"%V$intent \n"
// third line is profile
  profile = readline(A)
  profile = ssub(profile,"#","")


  R = ReadRecord(A,@type,FLOAT)

     sz = Caz(R)

     dmn = Cab(R)

     nrows = dmn[0]

<<"%V$nrows \n"

<<"%V$sz $dmn\n"

ncols = dmn[1]

<<"%V$ncols \n"

  // tim 

<<"\n%(4,, ,\n)$R\n"



sz = Caz(R)

// check # cols

  YV = R[::][1]

  Redimn(YV)

<<"%V$YV[0:3]\n"

<<"%V$YV[-4:-1]\n"

  sz = Caz(YV)
  //<<"ysz $sz \n"

  // if want to exclude neg and 0
  //MM= Stats(YV,">",0)

  // but we don't

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

 XV = R[::][0]
    

  sz=Caz(XV)
  nd=Cnd(XV)
  dmn=Cab(XV)

<<"%V$sz $nd $dmn\n"

  Redimn(XV)


  sz=Caz(XV)
  nd=Cnd(XV)
  dmn=Cab(XV)

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

  CLIMB = R[::][2]

  Redimn(CLIMB)

  FP = R[::][3]
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




  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }




  aslw = asl_w("PLOT_FP")

// Window
    aw= CreateGwindow(@title,"FLIGHT_PHASE",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.1,0.02,0.9,0.9,0)
    SetGwindow(aw,@drawon)
    SetGwindow(aw,@clip,0.1,0.12,0.8,0.9)

   grwo=createGWOB(aw,@GRAPH,@resize,0.12,0.1,0.95,0.5,@name,"PXY",@color,"white")

   setgwob(grwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,xmin,altmin,xmax+xpad,altmax,@savescales,0)

   fpwo=createGWOB(aw,@GRAPH,@resize,0.12,0.55,0.95,0.95,@name,"PFP",@color,"white")

   setgwob(fpwo,@drawon,@pixmapon,@clip,0.1,0.2,0.9,0.9,@scales,0,fpymin,xmax+xpad,fpymax,@savescales,0)

  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)

  //<<" ${YV[0:3]} \n"

  refgl=CreateGline(@woid,grwo,@type,"XY",@xvec,XV,@yvec, YV, @color, "red",@usescales,0)

  setGline(refgl,@draw)

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

<<"PRINTING SCREEN \n"

	OpenLaser("flightphase.ps",12,0)
	//OpenLaser("flightphase.ps")
      ScrLaser(aw)
    }
    //if ((E->keyw @= "REDRAW") || (E->keyw @= "RESIZE")) {
	  //if ((E->keyw @= "RESIZE") || (E->keyw @= "REDRAW")) {
      //    <<"REDRAW \n"


   if (redraw_screen) {

      drawFPGraph()


    if (print_screen) {
      LaserScr(aw)
      CloseLaser()

<<"PRINTING DONE \n"

      print_screen = 0
    }

   }

  }



STOP!
