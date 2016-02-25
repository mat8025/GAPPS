//
setdebug(1)
Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

    vp = cWi(@title,"PLOT_OBJECTS",@resize,0.05,0.01,0.99,0.95)
    //SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(vp,@pixmapon,@drawoff,@save,@bhue,"white")

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily

    daname = "PLOT_SCREEN"

    gwo= cWo(vp,@GRAPH,@resize,0.15,0.15,0.95,0.95,@name,"GLines",@color,"white")

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

    sWo(gwo,@drawon)

    sWo(gwo,@clearpixmap,@pixmapoff)

    sWo(gwo,@clear,@border,BLUE,@clipborder,RED)

    axnum(gwo,1)
    axnum(gwo,2)


    axtext(gwo,1,"TIME",0.5,3)
 
    axlabel(gwo,1,"TIDE",0.7,3)

    sWo(gwo,@drawon,@pixmapon)

    ticks(gwo,1)
    ticks(gwo,2)


    plot(gwo,@line,-2,-1,0,-1,ORANGE,@lineto,0,1,RED)

    plot(gwo,@lineto,-2,1,"blue",@lineto,-2,-1,"red")

    plot(gwo,@lineto,0,0,"blue",@lineto,-1,1,"red")

    plot(gwo,@box,-0.5,-0.9,1,0.8,LILAC,1.0)

    plot(gwo,@arrow,-2,-1,2,1,5,YELLOW,1.0)

    plot(gwo,@arrow,-1,-2,3,3,5,RED,1.0)

    plot(gwo,@polarline,0,0,2,ang,"blue")

    ang += 5;

    plot(gwo,@circle,0,0,1)

    plot(gwo,@ellipse,0,0,0.7,0.3)

    plot(gwo,@triangle,0.1,0.1,0.2,0.9,0.4,0.5,"green",1)

/{
    plot(gwo,@polyreg,-0.5,-0.5,8,5,"blue",0,0)

    plot(gwo,@polyreg,-0.1,-0.2,5,4,"green",0,0)

    plot(gwo,@polyreg,-3.1,-0.2,10,4,CYAN,1,0)

    plot(gwo,@polyreg,-5.1,-1.2,3,20,VIOLET,1,0)

    plot(gwo,@polyreg,-5.1,-1.2,4,10,RED,0,0)

    plot(gwo,@symbol,0,0,"circle",5,"yellow",1)

    plot(gwo,@symbol,-2.5,0,"diamond",5,"green",1)

    plot(gwo,@symbol,-2,2,"triangle",5,"blue",1)

    plot(gwo,@points,Pts,LILAC)

    plot(gwo,@symbols,Dpts,"diamond",2,BLUE,1,10)

    plot(gwo,@symbols,Spts,"circle",5,GREEN,0,10)
    
/}


    plot(gwo,@symbols,Spts,"triangle",2,RED,1,10)
    plot(gwo,@symbols,Spts,"circle",2,ORANGE,1,10)

    sWo(gwo,@showpixmap)
    sWo(gwo,@border,BLUE,@clipborder,RED)

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

///////////////////////////////// EVENT HANDLE ////////////////////////////////////////

include "event"

Event E     // use asl event class to process any messages

  while (1) {

      E->waitForMsg()

       if (! (E->keyw @= "NO_MSG")) {

           if (E->button == LEFT) {
             panwo(gwo,"left",5)
           }
           else if (E->button == RIGHT) {
             panwo(gwo,"right",5)
           }

           else if (E->button == 2) {
             zoomwo(gwo,"out",5)
           }

           else if (E->button == 4) {
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

         if (E->keyw @= "RESCALE") {
       <<"doing rescale !\n"
          RS = wgetrscales(gwo)
       <<"doing rescale ! $RS\n"
          
         }

         redraw_po();

       }
  }



  stop!
