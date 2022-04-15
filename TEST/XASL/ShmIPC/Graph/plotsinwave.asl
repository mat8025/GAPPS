/* 
 *  @script plotsinwave.asl 
 * 
 *  @comment plot sin 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.4.8 C-Be-O]                                  
 *  @date 04/13/2022 13:12:52 
 *  @cdate 04/13/2022 13:12:52 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//

Str Use_= " Demo  of plot sin ";


#include "debug" 
  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 

  chkIn(_dblevel)

  chkT(1);

   void drawFPGraph()
   {

   sWo(fpwo,_wgridhue,BLUE_,_WEO);

   sWo(fpwo,_wscales,xmin,ymin,xmax,ymax,_WEO);

   sGl(sin_gl,_GLDRAW);

   axnum(fpwo,1);

   axnum(fpwo,2);

   sWo(fpwo,_wclipborder,_wborder,_WEO);

   }

  Graphic = CheckGwm();

  if (!Graphic) {

   Xgm = spawnGwm();

   }

  pi = 4.0 * atan(1.0);

  dx = 4*pi/500.0;

  XV = vgen(FLOAT_,500,0,dx);

  YV = sin(XV);

  aslw = asl_w("PLOT_SIN");
// Window

  xmin = 0;

  xmax = 4 * pi;

  ymin = -1.5;

  ymax = 1.5;

  aw= cWi(_wtitle,"SIN",_wscales,xmin,ymin,xmax,ymax,_wsavescales,0);
//<<" CGW $aw \n"

  sWi(aw,_wresize,0.01,0.01,0.98,0.98,0);

  sWi(aw,_wclip,0.01,0.01,0.98,0.98);

  fpwo=cWo(aw,_GRAPH,_wresize,0.01,0.01,0.97,0.98,_wname,"PFP",_wcolor,WHITE_,_wsave,_wstore,_WEO);

  sWo(fpwo,_wdrawon,_wpixmapoff,_wclip,0.1,0.1,0.95,0.95,_wscales,xmin,ymin,xmax,ymax,_wsavescales,0,_WEO);
  //////////////////////////////////////////////////////////////////////////////////

  include "tbqrd";

  titleButtonsQRD(aw);

  dmn = Cab(YV);

  sin_gl=cGl(fpwo);

  sGl(sin_gl,_GLTXY,XV, YV, _GLHUE, ORANGE_,_GLEO);

  sWi(aw,_wredraw);

  drawFPGraph();
#include "gevent"   // adds event class

  f = 1.0;

  g = 1.0;

  print_screen = 0;

  hue = 1;

  while (1) {

   eventWait();

   redraw_screen = 0;

   XV2 = XV * f;

   YV = sin(XV2) * g;

   sGl(sin_gl,_GLTXY,XV, YV, _GLHUE, hue++,_GLEO);

   drawFPGraph();

   f += 0.005;

   g -= 0.05;

   if (_ekeyw == "RESIZE")

   redraw_screen = 1;

   if (_ekeyw == "REDRAW")

   redraw_screen = 1;

   if (_ekeyw == "PRINT") {

     redraw_screen = 1;

     print_screen = 1;
	//<<"PRINTING SCREEN \n"

     OpenLaser("sin.ps",24,1);

     ScrLaser(aw);

     }

   if (redraw_screen) {

     drawFPGraph();

     }

   if (print_screen) {

     drawFPGraph();

     CloseLaser();

     LaserScr(aw);

     <<"PRINTING DONE \n";

     print_screen = 0;

     }

   }

;//==============\_(^-^)_/==================//;
