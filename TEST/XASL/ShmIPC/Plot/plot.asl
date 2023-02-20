/* 
 *  @script plot.asl                                                    
 * 
 *  @comment show plot objects                                     
 *  @release Beryllium                                               
 *  @vers 1.4 Be Beryllium [asl 6.4.76 C-Be-Os]                         
 *  @date 02/17/2023 21:04:32                                           
 *  @cdate Sun Mar 22 15:55:33 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  

//

#define ASL 1
#define CPP 0

#define DBI   0

#include "debug"
#include "hv.asl"
#include "graphic"

#include "tbqrd.asl"
#include "gevent.asl"



    rainbow();



    vp = cWi("PLOT_OBJECTS");
  
    //SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(_WOID,vp,_WPIXMAP,ON_,_WRESIZE,wbox(0.05,0.01,0.69,0.95)));

//@drawoff,@save,@bhue,YELLOW_,@redraw)

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.9


     //ans=query("See window?");

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily

    daname = "PLOT_SCREEN"

    //gwo= cWo(vp,@GRAPH,@resize,0.15,0.15,0.45,0.95,@name,"GLines",@color,"white")
    gwo= cWo(vp,WO_GRAPH_);



//@name,"GLines",@color,"white")

    sWo(_WOID,gwo,_WNAME, "Glines",_WRESIZE,wbox(0.15,0.15,0.35,0.95_, _WCLIP,wbox(cx,cy,cX,cY),_WDRAW,ON_)

    // scales 
    sx = -25;
    sX = 25;
    sy = -5;
    sY = 40;

   // g2wo= cWo(vp,@GRAPH,@resize,0.55,0.15,0.95,0.95,@name,"GLines",@color,"white")

    g2wo= cWo(vp,WO_GRAPH_)

    sWo(_WOID,g2wo,_WRESIZE,wbox(0.55,0.15,0.95,0.95),_WNAME,"GLines",_WCOLOR,WHITE_)

    sWo(_WOID,g2wo,_WCLIP,wbox(cx,cy,cX,cY));

    int gwos[] = {gwo,g2wo};
    //setgwob(gwo,@scales, sx, sy, sX, sY, @save,@redraw,@drawon,@pixmapon)

    sWo(_WOID,gwo,_WSCALES, wbox(sx, sy, sX, sY),_WPIXMAP,ON_,_WDRAW,ON_,_WREDRAW,ON_)
    sWo(_WOID,g2wo,_WSCALES, wbox(sx, sy, sX, sY),_WPIXMAP,ON_,_WDRAW,ON_,_WREDRAW,ON_)

   //sWo(g2wo,@scales, sx, sy, sX, sY,@save, @savepixmap,@redraw,@pixmapon,@drawon)


/*
    plot(gwo,@line,-2,-2,2,2,"blue",@line,-2,2,2,-2,"red")
    //plot(gwo,@line,-2,2,2,-2,"red")
    plot(gwo,@box,-1,-1,1,1,"red",1.0)
    plot(gwo,@circle,0,0,1)
    plot(gwo,@ellipse,0,0,0.7,0.3)
    plot(gwo,@triangle,0.1,0.1,0.2,0.9,0.4,0.5,"green",1)
*/



   // sWo(gwos,@savepixmap,@showpixmap)
   //titleVers(Hdr_vers)
   
   titleButtonsQRD(vp);
   
<<"%V $Hdr_vers \n"
//////////////////////////////////////////////////////////////////////////////////
ang = 0.0

void redraw_po()
{

    sWo(_WOID,gwo,_WDRAW,ON_)

   // sWo(gwos,@clearpixmap,@pixmapon,@savepixmap)

    sWo(_WOID,gwo,_WCLEAR,ON_,_WBORDER,BLUE_,_WCLIPBORDER,RED_)


   // sWo(g2wo,@drawon)

    //sWo(g2wo,@clearpixmap,@pixmapon,@savepixmap)

    //sWo(g2wo,@clear,@border,BLUE_,@clipborder,GREEN_)

    axnum(gwo,1)
    axnum(gwo,2)

    axnum(g2wo,2)

    axtext(gwo,1,"TIME",0.5,3)
 
    axlabel(g2wo,1,"TIDE",0.7,3)

   // sWo(gwos,@drawon,@pixmapon)

    ticks(gwo,1)
    ticks(gwo,2)


    plotLine(gwo,-2,-1,0,-1,ORANGE_)
    //@lineto,0,1,RED_)

   plot(gwo,"lineto",-2,1,"blue","lineto",-2,-1,RED_)
/*
    plot(gwo,@lineto,0,0,"blue",@lineto,-1,1,"red")

    plot(gwo,@box,-0.5,-0.9,1,0.8,LILAC_,1.0)

    plot(gwo,@arrow,-2,-1,2,1,5,YELLOW_,1.0)

    plot(gwo,@arrow,-1,-2,3,3,5,RED_,1.0)

    plot(gwo,@polarline,0,0,2,ang,"blue");
*/

    plot(gwo,"POLY",PV,BLUE_,1);  // CPP version plot(wid, [LINE_,POLY_,...]
                                                 // or plotLine, plotPoly, ...

   // plot(gwo,@polyreg,5,3);



/*
    plot(g2wo,@line,-2,-1,0,-1,ORANGE_,@lineto,0,1,RED_)

    plot(g2wo,@lineto,-2,1,"blue",@lineto,-2,-1,RED_)

    plot(g2wo,@lineto,0,0,"blue",@lineto,-1,1,"red")

    plot(g2wo,@box,-0.5,-0.9,1,0.8,LILAC_,1.0)

    plot(g2wo,@arrow,-2,-1,2,1,5,YELLOW_,1.0)

    plot(g2wo,@arrow,-1,-2,3,3,5,RED_,1.0)

    plot(g2wo,@polarline,0,0,2,ang,"blue");
*/
        plot(g2wo,"POLY",PV2,MAGENTA_,1);
 //       plot(g2wo,@polyreg,6,1);

/*
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
*/

    //sWo(gwos,@showpixmap)
    //sWo(gwos,@border,BLUE_,@clipborder,RED_)


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

float PV[30]


         kv =0;

	 PV[kv++] = 0.
	 PV[kv++] = 0.0

 	 PV[kv++] = -6.
	 PV[kv++] = 0.0

 	 PV[kv++] = -9.
	 PV[kv++] = 16.0

	 PV[kv++] = -20
	 PV[kv++] = 20.0

         PV[kv++] = -21.5
	 PV[kv++] = 20.
	 
         PV[kv++] = -21.5
	 PV[kv++] = 24

         PV[kv++] = -17.5
	 PV[kv++] = 29

         PV[kv++] = -7.5
	 PV[kv++] = 36

         PV[kv++] = 7.5
	 PV[kv++] = 36

         PV[kv++] = 17.5
	 PV[kv++] = 29

         PV[kv++] = 21.5
	 PV[kv++] = 24

         PV[kv++] = 21.5
	 PV[kv++] = 20.

	 PV[kv++] = 20
	 PV[kv++] = 20.0

 	 PV[kv++] = 9.
	 PV[kv++] = 16.0

 	 PV[kv++] = 6.
	 PV[kv++] = 0.0
	 


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

   redraw_po();

int nevent = 0;

  while (1) {

           eventWait();

         if (checkTerm()) {
          <<"we have TERM SIGNAL\n";
	  break;
         }

     
  nevent++;

  if (! (Ev_keyw == "NO_MSG")) {

           if (Ev_button == LEFT_) {
             panwo(gwos,"left",5)
            // panwo(g2wo,"left",5)	     
           }
           else if (Ev_button == RIGHT_) {
             panwo(gwos,"right",5)
             //panwo(g2wo,"right",5)	     
	     
           }

           else if (Ev_button == 2) {
             zoomwo(gwos,"out",5)
           }

           else if (Ev_button == 4) {
             zoomwo(gwo,"in",5)
             zoomwo(g2wo,"in",5)	     
           }

           else if (Ev_button == 5) {
             zoomwo(gwos,"out",5)
           }

           
/*
         if (_ekeyw @= "RESCALE") {
       <<"doing rescale !\n"
          RS = wgetrscales(gwo)
       <<"doing rescale ! $RS\n"
         }
*/


       

         //PV *= 1.01;
         redraw_po();

       }
  }

<<"at the end of program!\n"
  exit();

