//%*********************************************** 
//*  @script plot.asl 
//* 
//*  @comment test plot objs 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sun Feb 24 02:55:14 2019 
//*  @cdate 1/1/2000 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%




include "debug.asl"
include "gevent.asl"
include "hv.asl"
include "tbqrd";


debugON()

Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

    vp = cWi(@title,"PLOT_OBJECTS",@resize,0.05,0.01,0.9,0.9)
    

    sWi(vp,@pixmapon,@drawoff,@save,@bhue,"white")

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily
    titleButtonsQRD(vp);
   titleVers();
    daname = "PLOT_SCREEN"

    gwo= cWo(vp,@GRAPH,@resize,0.15,0.15,0.95,0.9,@name,"GLines",@color,"white")

    setgwob(gwo,@clip,cx,cy,cX,cY)

    // scales 
    sx = -3
    sX = 3.0
    sy = -3
    sY = 3.0

    //setgwob(gwo,@scales, sx, sy, sX, sY, @save,@redraw,@drawon,@pixmapon)

   sWo(gwo,@scales, sx, sy, sX, sY,@save, @savepixmap,@redraw,@pixmapon,@drawoff)


/{
    plot(gwo,@line,-2,-2,2,2,"blue",@line,-2,2,2,-2,"red")
    //plot(gwo,@line,-2,2,2,-2,"red")
    plot(gwo,@box,-1,-1,1,1,"red",1.0)
    plot(gwo,@circle,0,0,1)
    plot(gwo,@ellipse,0,0,0.7,0.3)
    plot(gwo,@triangle,0.1,0.1,0.2,0.9,0.4,0.5,"green",1)
/}

    sWo(gwo,@savepixmap,@showpixmap)


//////////////////////////////////////////////////////////////////////////////////
ang = 0.0
proc redraw_po()
{

    sWo(gwo,@drawoff)

    sWo(gwo,@clearpixmap,@pixmapoff)

    sWo(gwo,@border,BLUE_,@clipborder,RED_)

    axnum(gwo,1)
    axnum(gwo,2)


    axtext(gwo,1,"TIME",0.5,3)
 
    axlabel(gwo,1,"TIDE",0.7,3)

    sWo(gwo,@drawoff,@pixmapon)

    ticks(gwo,1)
    ticks(gwo,2)


    plot(gwo,@line,-2,-1,0,-1,ORANGE_,@lineto,0,1,RED_)

    plot(gwo,@lineto,-2,1,BLUE_,@lineto,-2,-1,RED_)

    plot(gwo,@lineto,0,0,"blue",@lineto,-1,1,RED_)

    plot(gwo,@box,-0.5,-0.9,1,0.8,LILAC_,1.0)

    plot(gwo,@arrow,-2,-1,2,1,5,YELLOW_,1.0)

    plot(gwo,@arrow,-1,-2,3,3,5,RED_,1.0)

    plot(gwo,@polarline,0,0,2,ang,BLUE_)

    ang += 5;

    plot(gwo,@circle,0,0,1)

    plot(gwo,@ellipse,0,0,0.7,0.3)

    plot(gwo,@triangle,0.1,0.1,0.2,0.9,0.4,0.5,GREEN_,1)



    plot(gwo,@symbols,Spts,"triangle",2,RED_,1,10)
    plot(gwo,@symbols,Spts,"circle",2,ORANGE_,1,10)

    sWo(gwo,@showpixmap)
    sWo(gwo,@border,BLUE_,@clipborder,RED_)

}

//////////////////////////////////////////////////////////////////////



float Pts[128]
float Spts[128]
float Dpts[128]

       x = -3
       y = -3.0

       sx = -3
       sy = -3
       for (i =0 ; i < 128; i+= 2) {

        Pts[i] = x
        Pts[i+1] = y
         x += 0.05
         y += 0.04

        Spts[i] = sx 
        Spts[i+1] = sin(sx)

        Dpts[i] = sx 
        Dpts[i+1] = sin(sx) + 0.5

        sx += 0.1


       }
<<"$Pts \n"


//gevent Ev; // event handle type - can inspect for all event attributes
// but use gevent code

int k_loops = 0;


while (1) {

          //Ev->waitForMsg()
       eventWait();
<<"%V $_emsg $_etype $_ebutton $_ewoname $_ewoid  $(PRESS_)\n"

       if (_etype == PRESS_) {
<<"got PRESS\n"
           if (_ebutton == LEFT_) {
             panwo(gwo,"left",5)
           }
           else if (_ebutton == RIGHT_) {
             panwo(gwo,"right",5)
           }

           else if (_ebutton == 2) {
             zoomwo(gwo,"out",5)
           }

           else if (_ebutton == 4) {
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

         if (_ekeyw @= "RESCALE") {
       <<"doing rescale !\n"
          RS = wgetrscales(gwo)
       <<"doing rescale ! $RS\n"
          
         }

         redraw_po();

       }
       k_loops++;
       if (k_loops > 3) {
          //break;
      }
  }

