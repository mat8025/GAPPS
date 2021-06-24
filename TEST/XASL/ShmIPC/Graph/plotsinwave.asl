
//

<|Use_=
  draw a sin
|>


    //opendll("math")

proc drawFPGraph()
{
        

    sWo(fpwo,@gridhue,BLUE_)
    sWo(fpwo,@scales,xmin,ymin,xmax,ymax)

    dGl(sin_gl)

    axnum(fpwo,1)
    axnum(fpwo,2)

    sWo(fpwo,@clipborder,@border)
}



  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

    pi = 4.0 * atan(1.0)

    dx = 4*pi/300.0

  XV = vgen(FLOAT_,300,0,dx);
  YV = sin(XV);

  aslw = asl_w("PLOT_SIN")

// Window
    xmin = 0
    xmax = 4 * pi
    ymin = -1.5
    ymax = 1.5
    
    aw= cWi(@title,"SIN",@scales,xmin,ymin,xmax,ymax,@savescales,0)

//<<" CGW $aw \n"

    sWi(aw,@resize,0.01,0.01,0.98,0.98,0)
    sWi(aw,@clip,0.01,0.01,0.98,0.98)

   fpwo=cWo(aw,@GRAPH,@resize,0.01,0.01,0.97,0.98,@name,"PFP",@color,WHITE_,@save,@store)
   sWo(fpwo,@drawon,@pixmapoff,@clip,0.1,0.1,0.95,0.95,@scales,xmin,ymin,xmax,ymax,@savescales,0)



  //////////////////////////////////////////////////////////////////////////////////
include "tbqrd";

titleButtonsQRD(aw);
 
    dmn = Cab(YV)

    sin_gl=cGl(fpwo,@TXY,XV, YV, @color, ORANGE_)

      sWi(aw,@redraw)
      
      drawFPGraph()

#include "gevent"   // adds event class



 print_screen = 0

  while (1) {


    eventWait()
    redraw_screen = 0

    if (_ekeyw @= "RESIZE")
        redraw_screen = 1
	  
    if (_ekeyw @= "REDRAW")
        redraw_screen = 1
	  

    if (_ekeyw @= "PRINT") {
        redraw_screen = 1 
        print_screen = 1

	//<<"PRINTING SCREEN \n"

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




