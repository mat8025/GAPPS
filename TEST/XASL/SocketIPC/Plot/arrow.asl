//%*********************************************** 
//*  @script arrow.asl 
//* 
//*  @comment test sockets 
//*  @release CARBON 
//*  @vers 1.6 C Carbon                                                   
//*  @date Sat Feb 23 12:45:28 2019 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///

/// launch
/// with xgs already running port set at 4779 (default)
///   asl -S 127.0.0.1 -p 4779 arrow.asl
///    default port is 4779
///  coms are via sockets

// OR
// asl -X arrow
// wil start (spawn) xgs and then establish coms/shared memory


include "debug.asl"
include "gevent.asl"
include "hv.asl"
include "tbqrd";

proc redraw_po()
{
   // sWo(gwo,@drawon)

    sWo(gwo,@clearpixmap,@pixmapoff)

 //   sWo(gwo,@border,BLUE,@clipborder,RED)

    axtext(gwo,1,"TIME's",0.5,2)
 
    axlabel(gwo,1,"ARROW",0.7,2)

    sWo(gwo,@drawoff,@pixmapon)

   // plot(gwo,@arrow,-2,-1,2,1,5,YELLOW,1.0)

    plot(gwo,@arrow,0,0,fx,fy,5,RED_,1.0)

    plot(gwo,@arrow,0,0,-fx,-fy,5,BLUE_,1.0)

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

    plot(gwo,@arrow,-3,fy,-2,fy,5,GREEN_,1.0)
    plot(gwo,@arrow,4,fy,2,fy,5,BLACK_,1.0)
    plot(gwo,@arrow,fx,-3,fx,-1.9,5,BLACK_,1.0)
    plot(gwo,@arrow,fx,3,fx,2.1,5,BLACK_,1.0)

    sWo(gwo,@showpixmap)

 //   sWo(gwo,@border,BLUE,@clipborder,RED_)

}



//  need to handshake on connection

    vp = cWi(@title,"ARROWS",@resize,0.1,0.1,0.4,0.4)

    sWi(vp,@pixmapon,@drawon,@save,@bhue,WHITE_)

    sWi(vp,@pixmapon,@drawoff,@save,@bhue,WHITE_)

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily

    daname = "PLOT_SCREEN"

    gwo= cWo(vp,@GRAPH,@resize,0.15,0.15,0.95,0.95,@name,"GL",@color,WHITE_)

    sWo(gwo,@clip,cx,cy,cX,cY)

    // scales 
    sx = -4
    sX = 4.0
    sy = -3
    sY = 3.0


  titleButtonsQRD(vp);
   titleVers();
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

//////////////////////////////////////////////////////////////////////
  redraw_po();

 for (j = 0 ; j < 4000; j++) {
          redraw_po();
          si_pause(0.01)
      }


exit()

///////////////////////////////// EVENT HANDLE ////////////////////////////////////////



  int k_loops = 0

  while (1) {

<<"$k_loops \n"

          readMsg()

          if (! (_ekeyw @= "NO_MSG")) {

           if (_ebutton == LEFT) {
           //  panwo(gwo,"left",5)
           }
           else if (_ebutton == RIGHT) {
            // panwo(gwo,"right",5)
           }

            if (_ebutton == 2) {
           //  zoomwo(gwo,"out",5)
           }

            if (_ebutton == 4) {
             zoomwo(gwo,"in",5)
           }

           else if (_ebutton == 5) {
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
          si_pause(0.01)
      }

      k_loops++

      if (k_loops > 3) {
     //   break
     }

  }

  wdelete(vp)
  //sWi(vp,@delete)


<<"$k_loops \n"

