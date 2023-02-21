/* 
 *  @script plot_panel.asl 
 * 
 *  @comment design instrument panel 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.4.76 C-Be-Os]                                
 *  @date 02/18/2023 16:03:50 
 *  @cdate 02/18/2023 16:03:50 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2023
 * 
 */ 
;//-----------------<v_&_v>------------------------//;

Str Use_= " Demo  of design instrument panel ";


#include "debug"

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 

  chkIn(_dblevel)

  chkT(1);

//

#define ASL 1
#define CPP 0

#define DBI   0


#include "hv.asl"
#include "graphic"

#include "tbqrd.asl"
#include "gevent.asl"

float sx;

    rainbow();



    vp = cWi("PLOT_OBJECTS");
  
    //SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(_WOID,vp,_WPIXMAP,ON_,_WRESIZE,wbox(0.05,0.01,0.69,0.95)));

//@drawoff,@save,@bhue,YELLOW_,@redraw)

    cx = 0.0
    cX = 0.99
    cy = 0.0
    cY = 0.99


     //ans=query("See window?");

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily

    daname = "PLOT_SCREEN"

    //gwo= cWo(vp,@GRAPH,@resize,0.15,0.15,0.45,0.95,@name,"GLines",@color,"white")
    gwo= cWo(vp,WO_GRAPH_);



//@name,"GLines",@color,"white")

    sWo(_WOID,gwo,_WNAME, "Panel",_WRESIZE,wbox(0.15,0.15,0.95,0.95), _WCLIP,wbox(cx,cy,cX,cY),_WDRAW,ON_,_WSAVEPIXMAP,ON_)

    // scales 
    sx = -30.0;
    sX = 30;
    sy = -5;
    sY = 45;

    sWo(_WOID,gwo,_WSCALES, wbox(sx, sy, sX, sY),_WPIXMAP,ON_,_WDRAW,ON_,_WREDRAW,ON_)



    vario1_wo= cWo(gwo,WO_GRAPH_);

    sWo(_WOID,vario1_wo,,_WNAME,"Vario1",_WRESIZE,wbox(-8.0,23,-6.0,25,2),_WCOLOR,WHITE_,_WSAVEPIXMAP,ON_);

    sWo(_WOID,vario1_wo,_WCLIP,wbox(cx,cy,cX,cY));


    airspeed_wo= cWo(gwo,WO_GRAPH_);

    sWo(_WOID,airspeed_wo,_WNAME,"Airspeed",_WRESIZE,wbox(-8.0,31.5,-0.5,38.5,2),_WCOLOR,GREEN__,_WSAVEPIXMAP,ON_);

    sWo(_WOID,airspeed_wo,_WCLIP,wbox(cx,cy,cX,cY));

    alt_wo= cWo(gwo,WO_GRAPH_);

    sWo(_WOID,alt_wo,_WNAME,"Altimeter",_WRESIZE,wbox(0.5,31.5,8,38,2),_WCOLOR,RED__,_WSAVEPIXMAP,ON_);

    sWo(_WOID,alt_wo,_WCLIP,wbox(cx,cy,cX,cY));


    sage_wo= cWo(gwo,WO_GRAPH_);

    sWo(_WOID,sage_wo,_WNAME,"Sage",_WRESIZE,wbox(10.5,25.5,18,32.5,2),_WCOLOR,PINK__,_WSAVEPIXMAP,ON_);

    sWo(_WOID,sage_wo,_WCLIP,wbox(cx,cy,cX,cY));




    int gwos[] = {gwo,vario1_wo,alt_wo,airspeed_wo};
    //setgwob(gwo,@scales, sx, sy, sX, sY, @save,@redraw,@drawon,@pixmapon)

   
        sWo(_WOID,vario1_wo,_WSCALES, wbox(-1.0, -1.0, 1.0, 1.0),_WPIXMAP,ON_,_WDRAW,ON_,_WREDRAW,ON_)

        sWo(_WOID,airspeed_wo,_WSCALES, wbox(-1.0, -1.0, 1.0, 1.0),_WPIXMAP,ON_,_WDRAW,ON_,_WREDRAW,ON_)

        sWo(_WOID,alt_wo,_WSCALES, wbox(-1.0, -1.0, 1.0, 1.0),_WPIXMAP,ON_,_WDRAW,ON_,_WREDRAW,ON_)

        sWo(_WOID,sage_wo,_WSCALES, wbox(-1.0, -1.0, 1.0, 1.0),_WPIXMAP,ON_,_WDRAW,ON_,_WREDRAW,ON_)	








   // sWo(gwos,@savepixmap,@showpixmap)
   //titleVers(Hdr_vers)
   
       titleButtonsQRD(vp);

       sWi(_WOID,vp, _WREDRAW,ON_);
       sWo(_WOID,alt_wo,_WREDRAW,ON_)	;
       sWo(_WOID,airspeed_wo,_WREDRAW,ON_)	;

//////////////////////////////////////////////////////////////////////////////////
ang = 0.0

void redraw_po()
{

    sWo(_WOID,gwo,_WDRAW,ON_)

   // sWo(gwos,@clearpixmap,@pixmapon,@savepixmap)

    sWo(_WOID,gwo,_WCLEAR,ON_,_WBORDER,BLUE_,_WCLIPBORDER,RED_)




    axnum(gwo,1)
    axnum(gwo,2)

    

    axtext(gwo,1,"TIME",0.5,3)
 
    

   // sWo(gwos,@drawon,@pixmapon)

    ticks(gwo,1)
    ticks(gwo,2)


    plotLine(gwo,-2,-1,0,-1,ORANGE_)
    //@lineto,0,1,RED_)

   plot(gwo,"lineto",-2,1,"blue","lineto",-2,-1,RED_)


   plot(gwo,"POLY",PV,BROWN_,1);  // CPP version plot(wid, [LINE_,POLY_,...]
                                                 // or plotLine, plotPoly, ...


    plot(gwo,"POLY",CPV,RED_,1);  //

    plot(gwo,"POLY",RCPV,GREEN_,1);  //

    plotCircle(gwo,-4.0,35,3.5,WHITE_,1) ; //  airspeed
    plotCircle(airspeed_wo,0,0,1.0,RED_,1); // airspeed


    plotCircle(gwo,4.0,35,3.5,BLACK_,1) ; // altimeter
    plotCircle(alt_wo,0,0,1.0,BLUE_,1) ; //altimeter



    plotCircle(vario1_wo,0,0,0.9,YELLOW_,1) ; // ilec vario

    plotCircle(gwo,14.0,29,3.5,BLACK_,1) ; // Sage vario
    plotCircle(sage_wo,0,0,1.0,PINK_,1) ; // Sage vario


    


   // plot(gwo,@polyreg,5,3);




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

float PV[40];   


         kv =0;

	 PV[kv++] = 0. ;     // 
	 PV[kv++] = 0.0 ;   // bottom center  0

 	 PV[kv++] = -6.     // bottom left edge 1
	 PV[kv++] = 0.0

 	 PV[kv++] = -7.  ;  // bottom left leg 1
	 PV[kv++] = 8.0 ;


	 PV[kv++] = -9   ; // mid left leg 3
	 PV[kv++] = 16.0

         PV[kv++] = -18 ; // L top  leg  4
	 PV[kv++] = 19.
	 
         PV[kv++] = -22 ;  // L bottom flange 5
	 PV[kv++] = 20 ;

         PV[kv++] = -22 ;  // L top flange 6
	 PV[kv++] = 23 ;

         PV[kv++] = -21 ;  // L  inner flange 7
	 PV[kv++] = 23 ;

         PV[kv++] = -17.5 ; // L mid slope 8
	 PV[kv++] =  32;


         PV[kv++] = -7.5; //  L top  9
	 PV[kv++] = 40;

         PV[kv++] = 0;    // M top 10 
	 PV[kv++] = 40;

         PV[kv++] = 7.5 ; // right top
	 PV[kv++] = 40;

         PV[kv++] = 17.5 ; // right mid slope
	 PV[kv++] =  32;

         PV[kv++] = 21 ;  // R  inner flange 7
	 PV[kv++] = 23 ;

         PV[kv++] = 22 ;  // right top flange
	 PV[kv++] = 23 ;

         PV[kv++] = 22 ;  // R bottom flange
	 PV[kv++] = 20 ;


         PV[kv++] = 18 ; //  R top  leg
	 PV[kv++] = 19.

	 PV[kv++] = 9   ; // R mid  leg
	 PV[kv++] = 16.0

 	 PV[kv++] = 7.  ;  // R bottom  leg
	 PV[kv++] = 8.0 ;

 	 PV[kv++] = 6.     // R bottom  edge
	 PV[kv++] = 0.0 ;

	 



//  Cspline leg holes

float LXV[3]
float LYV[3]


float LXSV[10]

float LYSV[10]

float CPV[20];
float RCPV[20];


        LXV[0] =  -20.0
	LYV[0] =  20.0

        LXV[1] =  -12.0
	LYV[1] =  19.0

        LXV[2] =  -9.0
	LYV[2] =  16.0

        sx = -9.0;
	dx = (20-9)/10.0;
	
        for (i= 0; i < 10; i++) {
         LXSV[i]  = sx;
	 <<"%V $i  $sx $dx $LXSV[i] \n"
	 sx -= dx;
        }



        Cspline(LXV,LYV,3,LXSV,LYSV,10)
        k=0;
        for (i= 0; i < 10; i++) {

          CPV[k++] = LXSV[i];
          CPV[k++] = LYSV[i];	  
         <<"$i $LXSV[i]  $LYSV[i] $CPV[k-1]\n"	  
         }


        k = 0
        for (i= 0; i < 10; i++) {

          RCPV[k] = -1* CPV[k];
          RCPV[k+1] = CPV[k+1];

         <<"$i  $RCPV[k]  $RCPV[k+1]\n"	  
	  k += 2;
          }


   redraw_po();

  <<"%V $Hdr_vers \n"
int nevent = 0;

  while (1) {

           eventWait();

         if (checkTerm()) {
          <<"we have TERM SIGNAL\n";
	  break;
         }

     
  nevent++;

  if (! (Ev_keyw == "NO_MSG")) {

/*
           if (Ev_button == LEFT_) {
             panwo(gwos,"left",5)

           }
           else if (Ev_button == RIGHT_) {
             panwo(gwos,"right",5)

	     
           }

           else if (Ev_button == 2) {
             zoomwo(gwos,"out",5)
           }

           else if (Ev_button == 4) {
             zoomwo(gwo,"in",5)
             
           }

           else if (Ev_button == 5) {
             zoomwo(gwos,"out",5)
           }
*/
           
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

