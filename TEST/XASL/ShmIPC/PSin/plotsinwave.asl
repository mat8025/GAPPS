#/* -*- c -*- */

opendll("math")

proc drawFPGraph()
{
        

    setgwob(fpwo,@gridhue,BLUE)
    setgwob(fpwo,@scales,xmin,ymin,xmax,ymax)
    setGline(sin_gl,@symbol,"diamond", @ltype,"lsymbol",@symsize,2.0,@symfill,0,@symhue,GREEN,@draw)

      setGline(cos_gl,@symbol,"cross", @ltype,"lsymbol",@symsize,2.0,@symfill,0,@symang,45,@symhue,RED,@draw)

      setGline(tri_gl,@hue,"yellow",@ltype,"lsymbol",@symbol,"circle",@symsize,2.0,@symfill,0,@symhue,BLUE,@draw)


    axnum(fpwo,1)
    axnum(fpwo,2)

    setGwob(fpwo,@clipborder,@border)
}



  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

  aslw = asl_w("PLOT_SIN")

    pi = 4.0 * atan(1.0)


// Window
    xmin = 0
    xmax = 4 * pi
    ymin = -3
    ymax = 3
    aw= CreateGwindow(@title,"SIN",@scales,xmin,ymin,xmax,ymax,@savescales,0)

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.01,0.01,0.98,0.98,0)
    SetGwindow(aw,@clip,0.01,0.01,0.98,0.98)

   fpwo=createGWOB(aw,@GRAPH,@resize,0.01,0.01,0.97,0.98,@name,"PFP",@color,"white",@save,@store)
   setgwob(fpwo,@drawon,@pixmapoff,@clip,0.1,0.1,0.95,0.95,@scales,xmin,ymin,xmax,ymax,@savescales,0)



  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)

    dx = 4*pi/50.0

    XV = vgen(FLOAT,50,0,dx);
  
 
    YV = sin(XV);

    CV = cos(XV);

    TV = saw(XV);






    sin_gl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@yvec, YV, @color, "orange")
    cos_gl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@yvec, CV, @color, "red")
    tri_gl=CreateGline(@woid,fpwo,@type,"XY",@xvec,XV,@yvec, TV, @color, BLUE)


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
        print_screen = 1

	//<<"PRINTING SCREEN \n"

	
	OpenLaser("sin.ps",48,0)
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
      // close this after all SHM draw has happened!
      

    }
   

  }



STOP!
