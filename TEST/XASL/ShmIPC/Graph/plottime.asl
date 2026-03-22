/* 
 *  @script plottime.asl 
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
//-----------------<v_&_v>------------------------//

Str Use_= " Demo  of plot sin ";


#include "debug" 
  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 
  int qa =0
  chkIn(_dblevel)

  chkT(1);

   void drawFPGraph()
   {
   <<" $_proc \n"
   sWo(_woid,fpwo,_wgridhue,BLUE_);

   sWo(_woid,fpwo,_wscales,wbox(xmin,ymin,xmax,ymax));

   sGl(_glid,sin_gl,_GLDRAW);

   axnum(fpwo,1);

   axnum(fpwo,2);

   sWo(_woid,fpwo,_wclipborder,eloop,_wborder,GREEN_);

   }
   
  sdb(1,"~step")

  ft1=finetime()
  ft1.pinfo()

  wt1 = gettime()

  wt1.pinfo();

  gspause(2.1)

  fdt= finetimesince(ft1)

  fdt.pinfo()

ans=ask("%V $fdt", qa)

  wt2 = gettime()

  wt2.pinfo();


  hl= wt2-wt1;

<<"%V $wt1 $wt2 $hl \n"

  d1= time2date(wt1)

<<"$wt1 --> $d1\n"

//  exit(-1)




  Graphic = CheckGwm();

  if (!Graphic) {

   Xgm = spawnGwm();

   }

  Pi = 4.0 * atan(1.0);

  dx = 4*Pi/500.0;

  XV = vgen(FLOAT_,500,0,dx);

  YV = sin(XV);



  
  aslw = asl_w("PLOT_SIN");
// Window

  xmin = 0;

  xmax = 4 * Pi;

  ymin = -1.5;

  ymax = 1.5;

  aw= cWi(_wtitle,"SIN")
  sWi(_woid,aw,_wscales,wbox(xmin,ymin,xmax,ymax),_wsavescales,0);
//<<" CGW $aw \n"

  sWi(_woid,aw,_wresize,wbox(0.01,0.01,0.98,0.98,0));

  sWi(_woid,aw,_wclip,wbox(0.01,0.01,0.98,0.98));

  fpwo=cWo(aw,_GRAPH)
  
  sWo(_woid,fpwo,_wresize,wbox(0.1,0.1,0.9,0.9),_wname,"PFP",_wcolor,WHITE_,_wsave,ON_,_wstore,ON_);

  sWo(_woid,fpwo,_wdraw,ON_,_wpixmap,OFF_,_wclip,wbox(0.1,0.1,0.9,0.9),_wscales,wbox(xmin,ymin,xmax,ymax),_wsavescales,0);

//////////////////////////////////////////////////////////////////////////////////
  
#include "wevent.asl" 
#include "tbqrd.asl"
 

  titleButtonsQRD(aw);

  dmn = Cab(YV);

  sin_gl=cGl(fpwo);

  sGl(_glid,sin_gl,_GLTXY,XV, YV, _GLHUE, ORANGE_,_GLEO);

  sWi(_woid,aw,_wredraw);

  drawFPGraph();
  


  f = 1.0;

  g = 1.0;

  print_screen = 0;

  hue = 1;

  while (1) {


  // sleep(0.1)
  //  <<"Done sleeping ! $_eloop $_ekeyw $f $g\n"
  // eventRead();  // reads whatever is in queue
  
     eventWait() ; // eventWait() -- wait forever else value set
     // how long did I wait
 <<"%V $etime_ \n"
<<"Done waiting ! $eloop_ $ekeyw_  $etime_ \n"




   redraw_screen = 1;

   XV2 = XV * f;

   YV = sin(XV2) * g;

   sGl(_glid,sin_gl,_GLTXY,XV, YV, _GLHUE, hue++);

   drawFPGraph();

   f += 0.005;

   g -= 0.05;

   if (ekeyw_ == "RESIZE")
     redraw_screen = 1;

   if (ekeyw_ == "REDRAW")
   redraw_screen = 1;

   if (ekeyw_ == "PRINT") {

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

     if (hue > 20) {
         hue = 0
     }

   }

//==============\_(^-^)_/==================//
