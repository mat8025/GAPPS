//
//setdebug(1)

     Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

    vp = cWi(@title,"PLOT_OBJECTS",@resize,0.1,0.1,0.4,0.4)

    //SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(vp,@pixmapon,@drawoff,@save,@bhue,"white")



    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

//    vp2 = cWi(@title,"PLOT_OBJECTS",@resize,0.1,0.1,0.4,0.4)

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily

    daname = "PLOT_SCREEN"

    gwo= cWo(vp,@GRAPH,@resize,0.15,0.15,0.95,0.95,@name,"GL",@color,"white")

    setgwob(gwo,@clip,cx,cy,cX,cY)

    // scales 
    sx = -4
    sX = 4.0
    sy = -3
    sY = 3.0

    //setgwob(gwo,@scales, sx, sy, sX, sY, @save,@redraw,@drawon,@pixmapon)

    sWo(gwo,@scales, sx, sy, sX, sY,@save, @savepixmap,@redraw,@pixmapon,@drawoff)

    sWo(gwo,@savepixmap,@showpixmap)

    fx = 1.0
    fy = 1.0

//////////////////////////////////////////////////////////////////////////////////
ang = 0.0
len = 2.0
  RandSeed()
int r = Rand()


 clockwise = 0

 if ( (r/2 * 2) == r) {
  clockwise = 1
 } 

<<"%V$r $clockwise \n"

proc redraw_po()
{
    sWo(gwo,@drawon)

    sWo(gwo,@clearpixmap,@pixmapoff)

    sWo(gwo,@clear,@border,BLUE,@clipborder,RED)

    axtext(gwo,1,"TIME's",0.5,2)
 
    axlabel(gwo,1,"ARROW",0.7,2)

    sWo(gwo,@drawoff,@pixmapon)

   // plot(gwo,@arrow,-2,-1,2,1,5,YELLOW,1.0)

    plot(gwo,@arrow,0,0,fx,fy,5,RED,1.0)

    plot(gwo,@arrow,0,0,-fx,-fy,5,BLUE,1.0)

   // plot(gwo,@arrow,-1,2,0,-2.1,5,BLUE,1.0)

    fx = cos (d2r(ang)) * len
    fy = sin (d2r(ang)) * len
 
    if ( clockwise) {
      ang += 10
      ang = (ang % 360)
    }
    else {
       ang -= 10
       if (ang < -360) {
         ang = 0
       }
    }

    if (fy != 0)
      at = atan(fx/fy)
    else
      at = _PI/2.0

//<<"%V4.2f$ang $fx $fy $at\n"

    plot(gwo,@arrow,-3,fy,-2,fy,5,GREEN,1.0)
    plot(gwo,@arrow,4,fy,2,fy,5,BLACK,1.0)
    plot(gwo,@arrow,fx,-3,fx,-1.9,5,BLACK,1.0)
    plot(gwo,@arrow,fx,3,fx,2.1,5,BLACK,1.0)

    sWo(gwo,@showpixmap)

    sWo(gwo,@border,BLUE,@clipborder,RED)

}

//////////////////////////////////////////////////////////////////////


///////////////////////////////// EVENT HANDLE ////////////////////////////////////////

include "event"

Event E     // use asl event class to process any messages



  while (1) {

          E->readMsg()

          if (! (E->keyw @= "NO_MSG")) {

           if (E->button == LEFT) {
           //  panwo(gwo,"left",5)
           }
           else if (E->button == RIGHT) {
            // panwo(gwo,"right",5)
           }

            if (E->button == 2) {
           //  zoomwo(gwo,"out",5)
           }

            if (E->button == 4) {
             zoomwo(gwo,"in",5)
           }

           else if (E->button == 5) {
             zoomwo(gwo,"out",5)
           }

           
/{
           setgwob(gwo,@scales, sx, sy, sX, sY)
           sx += 0.1
           sX -= 0.1
/}
     }

      for (j = 0 ; j < 4; j++) {
          redraw_po();
          si_pause(0.1)
      }

  }



  stop!
