#/* -*- c -*- */

opendll("math")

proc drawFPGraph()
{
        

    setgwob(fpwo,@gridhue,BLUE)
    setgwob(fpwo,@scales,xmin,ymin,xmax,ymax)

    drawGline(sin_gl)

    axnum(fpwo,1)
    axnum(fpwo,2)

    setGwob(fpwo,@clipborder,@border)
}



  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

    pi = 4.0 * atan(1.0)

    dx = 4*pi/300.0

  XV = vgen(FLOAT,300,0,dx);
  YV = sin(XV);

  aslw = asl_w("PLOT_SIN")

// Window
    xmin = 0
    xmax = 4 * pi
    ymin = -1500
    ymax = 1500
    aw= CreateGwindow(@title,"SIN",@scales,xmin,ymin,xmax+xpad,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.01,0.01,0.98,0.98,0)
    SetGwindow(aw,@clip,0.01,0.01,0.98,0.98)

   fpwo=createGWOB(aw,@GRAPH,@resize,0.01,0.01,0.97,0.98,@name,"PFP",@color,"white",@save,@store)
   setgwob(fpwo,@drawon,@pixmapoff,@clip,0.1,0.1,0.95,0.95,@scales,xmin,ymin,xmax,ymax,@savescales,0)



  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)

    sin_gl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@yvec, YV, @color, "orange")


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
	OpenLaser("sin.ps",24,1)
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
