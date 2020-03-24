//%*********************************************** 
//*  @script plot.asl 
//* 
//*  @comment show plottable objects 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                    
//*  @date Sun Mar 22 15:55:33 2020 
//*  @cdate Sun Mar 22 15:55:33 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
//


include "debug"
include "hv.asl"
include "graphic"
include "gevent"


    rainbow();



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

    gwo= cWo(vp,@GRAPH,@resize,0.15,0.15,0.45,0.95,@name,"GLines",@color,"white")

    sWo(gwo,@clip,cx,cy,cX,cY)

    // scales 
    sx = -3
    sX = 3.0
    sy = -3
    sY = 3.0

    g2wo= cWo(vp,@GRAPH,@resize,0.55,0.15,0.95,0.95,@name,"GLines",@color,"white")

    sWo(g2wo,@clip,cx,cy,cX,cY)

    int gwos[] = {gwo,g2wo};
    //setgwob(gwo,@scales, sx, sy, sX, sY, @save,@redraw,@drawon,@pixmapon)

    sWo(gwo,@scales, sx, sy, sX, sY,@save, @savepixmap,@redraw,@pixmapon,@drawon)
    sWo(g2wo,@scales, sx, sy, sX, sY,@save, @savepixmap,@redraw,@pixmapon,@drawon)


/{
    plot(gwo,@line,-2,-2,2,2,"blue",@line,-2,2,2,-2,"red")
    //plot(gwo,@line,-2,2,2,-2,"red")
    plot(gwo,@box,-1,-1,1,1,"red",1.0)
    plot(gwo,@circle,0,0,1)
    plot(gwo,@ellipse,0,0,0.7,0.3)
    plot(gwo,@triangle,0.1,0.1,0.2,0.9,0.4,0.5,"green",1)
/}



    sWo(gwos,@savepixmap,@showpixmap)
    titleVers()
    titleButtonsQRD(vp);

//////////////////////////////////////////////////////////////////////////////////
ang = 0.0

proc redraw_po()
{

    sWo(gwo,@drawon)

    sWo(gwos,@clearpixmap,@pixmapon,@savepixmap)

    sWo(gwo,@clear,@border,BLUE_,@clipborder,RED_)


    sWo(g2wo,@drawon)

    sWo(g2wo,@clearpixmap,@pixmapon,@savepixmap)

    sWo(g2wo,@clear,@border,BLUE_,@clipborder,GREEN_)

    axnum(gwo,1)
    axnum(gwo,2)

    axnum(g2wo,2)

    axtext(gwo,1,"TIME",0.5,3)
 
    axlabel(g2wo,1,"TIDE",0.7,3)

    sWo(gwos,@drawon,@pixmapon)

    ticks(gwo,1)
    ticks(gwo,2)

/{
    plot(gwo,@line,-2,-1,0,-1,ORANGE_,@lineto,0,1,RED_)

   plot(gwo,@lineto,-2,1,"blue",@lineto,-2,-1,RED_)

    plot(gwo,@lineto,0,0,"blue",@lineto,-1,1,"red")

    plot(gwo,@box,-0.5,-0.9,1,0.8,LILAC_,1.0)

    plot(gwo,@arrow,-2,-1,2,1,5,YELLOW_,1.0)

    plot(gwo,@arrow,-1,-2,3,3,5,RED_,1.0)

    plot(gwo,@polarline,0,0,2,ang,"blue");
/}

    plot(gwo,@poly,PV,BLUE_,1);

   // plot(gwo,@polyreg,5,3);



/{
    plot(g2wo,@line,-2,-1,0,-1,ORANGE_,@lineto,0,1,RED_)

    plot(g2wo,@lineto,-2,1,"blue",@lineto,-2,-1,RED_)

    plot(g2wo,@lineto,0,0,"blue",@lineto,-1,1,"red")

    plot(g2wo,@box,-0.5,-0.9,1,0.8,LILAC_,1.0)

    plot(g2wo,@arrow,-2,-1,2,1,5,YELLOW_,1.0)

    plot(g2wo,@arrow,-1,-2,3,3,5,RED_,1.0)

    plot(g2wo,@polarline,0,0,2,ang,"blue");
/}
        plot(g2wo,@poly,PV2,MAGENTA_,1);
 //       plot(g2wo,@polyreg,6,1);

/{
    ang += 5;

    plot(gwo,@circle,0,0,1)

    plot(gwo,@ellipse,0,0,0.7,0.3)

    plot(gwo,@triangle,0.1,0.1,0.2,0.9,0.4,0.5,"green",1)


    plot(g2wo,@circle,0,0,1)

    plot(g2wo,@ellipse,0,0,0.7,0.3)

    plot(g2wo,@triangle,0.1,0.1,0.2,0.9,0.4,0.5,BLUE_,1)


    plot(gwo,@symbols,Spts,INVTRI_,2,RED_,1,10)
    plot(gwo,@symbols,Spts,CIRCLE_,2,ORANGE_,1,10)

    plot(g2wo,@symbols,Spts,TRI_,2,RED_,1,10)
    plot(g2wo,@symbols,Spts,CIRCLE_,2,ORANGE_,1,10)
/}

    sWo(gwos,@showpixmap)
    sWo(gwos,@border,BLUE_,@clipborder,RED_)


}

//////////////////////////////////////////////////////////////////////



float Pts[128]
float Spts[128]
float Dpts[128]

       x = -3
       y = -3.0

       sx = -3
       sy = -3
       for (i =0 ; i < 128; i += 2) {

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

float PV[8]


         kv =0;
         PV[kv++] = 0.
	 PV[kv++] = -1.0
         PV[kv++] = 0.0
	 PV[kv++] = 2.0
         PV[kv++] = 2.0
	 PV[kv++] = 2.0
         PV[kv++] = 2.0
	 PV[kv++] = -1.0

float PV2[12]


         kv =0;
         PV2[kv++] = 0.0
	 PV2[kv++] = -1.0
	 
         PV2[kv++] = 1.5
	 PV2[kv++] = -1.0
	 
         PV2[kv++] = 2.0
	 PV2[kv++] = 1.3
	 
         PV2[kv++] = 0
	 PV2[kv++] = 2.0

         PV2[kv++] = -1.0
	 PV2[kv++] = 1.8

         PV2[kv++] = -1.5
	 PV2[kv++] = 1.4	 	 	 



  while (1) {

           eventWait();

         if (checkTerm()) {
          <<"we have TERM SIGNAL\n";
	  break;
         }

     titleMsg("%V $_ekeyw  $_ebutton $_eloop")

  if (! (_ekeyw @= "NO_MSG")) {

           if (_ebutton == LEFT_) {
             panwo(gwos,"left",5)
            // panwo(g2wo,"left",5)	     
           }
           else if (_ebutton == RIGHT_) {
             panwo(gwos,"right",5)
             //panwo(g2wo,"right",5)	     
	     
           }

           else if (_ebutton == 2) {
             zoomwo(gwos,"out",5)
           }

           else if (_ebutton == 4) {
             zoomwo(gwo,"in",5)
             zoomwo(g2wo,"in",5)	     
           }

           else if (_ebutton == 5) {
             zoomwo(gwos,"out",5)
           }

           

         if (_ekeyw @= "RESCALE") {
       <<"doing rescale !\n"
          RS = wgetrscales(gwo)
       <<"doing rescale ! $RS\n"
         }



         if (_ekeyw @= "EXIT") {
         <<"got SIG TERM to EXIT\n"
         <<"cleanup?\n"	 
	  break;
         }

         //PV *= 1.01;
         redraw_po();

       }
  }

<<"at the end of program!\n"
  exit();

