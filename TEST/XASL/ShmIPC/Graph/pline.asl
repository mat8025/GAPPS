/* 
 *  @script pline.asl                                                   
 * 
 *  @comment test graph                                                 
 *  @release Beryllium                                                  
 *  @vers 1.6 C Carbon [asl ]                                           
 *  @date 07/12/2023 13:46:21                                           
 *  @cdate 04/13/2022 08:55:07                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare  -->                                   
 * 
 */ 

//----------------<v_&_v>-------------------------//                    



  Str Use_= " Demo  of test graph ";
  
#include "debug"

  if (_dblevel >0) {

  debugON();

  <<"$Use_ \n";

  }

  allowErrors(-1);

  chkIn(_dblevel);

  chkT(1);
///

#define ASL 1

Graphic = checkGWM()

  if (!Graphic) {
    Xgm_pid = spawnGWM()
<<"xgs pid ? $Xgm_pid \n"
  }


//#include "graphic"
//#include "hv.asl"
#include "gevent"
//pi = 4.0 * atan(1.0)
// PLINE DEMO 
/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

  vp = cWi("XYPLOT")
  

  sWi(_WOID,vp,_Wdraw,ON_,_Wsave,ON_,_Wbhue,WHITE_,_WRESIZE,wbox(0.05,0.01,0.99,0.5,0));

  cx = 0.1;

  cX = 0.9;

  cy = 0.2;

  cY = 0.95;

  gwo=cWo(vp,WO_GRAPH_)

  sWo(_WOID,gwo,_WRESIZE,wbox(0.15,0.1,0.95,0.95),_Wname,"LP",_Wcolor,WHITE_);

  sWo(_WOID,gwo,_Wclip,wbox(cx,cy,cX,cY));

  sWo(_WOID,gwo,_Wscales,wbox(0,0,1,1), _Wsave,ON_,_Wdraw,ON_);

  //sWo(_WOID,gwo,_Wrhtscales,wbox(-4,-2.2,4,2.2));

  //titleButtonsQRD(vp);
  
////////////////////////////// PLINE ////////////////////////////////////////

  void Pline()
  {



  sWo(_WOID,gwo,_WUSESCALES,0,_WHUE,RED_,_WLINE,0,0,1,1,GREEN_,_WREDRAW,ON_);

  sWo(_WOID,gwo,_WHUE,RED_,_WLINE,wbox(0.2,0.5,1,0.9,ORANGE_));

  sWo(_WOID,gwo,_WCLIPBORDER,BLACK_,_WLINE,wbox(0.2,0.2,0.4,0.4,GREEN_));

  sWo(_WOID,gwo,_WCLIPBORDER,BLACK_,_WBOX,wbox(0.31,0.2,0.5,0.4,BLUE_));

  //plot(gwo,"line",0,0.5,1,0.7,BLUE_);
  plotLine(gwo,0.2,0.5,0.9,0.7,RED_);

  plotLine(gwo,0,0.5,1,0.7,YELLOW_);

//  plot(gwo,"box",0.2,0.2,0.4,0.5,YELLOW_,0); // PS crash

  //plotCircle(gwo,0.5,0.5,0.1,YELLOW_,0); // PS crash

 // plot(gwo,"circle",0.5,0.5,0.2,BLUE_);

 // plot(gwo,_wsymbol,0.5,0.5,"star5");

 // plot(gwo,_wcircle,0.5,0.5,0.5,GREEN_);

  //plot(gwo,"line",0.5,0.5,0.7,0.7,BLACK_);
  //plotgw(vp,_symbol,0.5,0.5,"triangle",_WEO);
  //sWo(_WOID,gwo,_showpixmap,_WEO);

  sWo(_WOID,gwo,_WUSESCALES,1,_WCLIPBORDER,BLUE_,_WBORDER,BLACK_);

  x = 0.2;

  y = 0.2;

  last_x = x;

  last_y = y;

  int i;
  /*
  for (i = 0; i < 200; i++) {
    plot(gwo,_symbol,x,y,"triangle",5,RED_)
    x += 0.05
    y =  Sin(x)
    plot(gwo,_line,last_x,last_y,x,y,GREEN_)
  last_x = x
  last_y = y
  }
*/
//  sWo(_WOID,gwo,_showpixmap)


  axnum(gwo,1);

  axnum(gwo,2);

  axnum(gwo,3);

  axnum(gwo,4);


//  sWo(_WOID,gwo,_gridhue,BLUE_)
//  grid(gwo)

  }

  Pline();
 // test  postscript print

  do_laser = 1;

  ans=query("replot to postscript?","y");

  if (ans != "y") {

    do_laser = 0;

  }


  if (do_laser) {

  OpenLaser("pline.ps",1) ; //landscape 1 0 portrait;

  ScreenToLaser(vp);
// ScrLaser(gwo)  //  not required the window scrlaser operates on all wobs

  Pline();

  CloseLaser();

  <<" did we produce a postscript ?\n";

  }
//

;//==============\_(^-^)_/==================//;
