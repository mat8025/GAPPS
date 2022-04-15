/* 
 *  @script pline.asl 
 * 
 *  @comment test graph 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.4.8 C-Be-O]                                  
 *  @date 04/13/2022 08:55:07 
 *  @cdate 04/13/2022 08:55:07 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//


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
#include "graphic"
#include "hv.asl"
#include "gevent"
//pi = 4.0 * atan(1.0)
// PLINE DEMO 
/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

  vp = cWi("title","XYPLOT",_resize,0.05,0.01,0.99,0.95,0);

  sWi(vp,_pixmapff,_drawon,_save,_bhue,WHITE_);

  cx = 0.1;

  cX = 0.9;

  cy = 0.2;

  cY = 0.95;

  gwo=cWo(vp,"GRAPH",_resize,0.15,0.1,0.95,0.95,_name,"LP",_color,"white");

  sWo(gwo,_wclip,cx,cy,cX,cY,_wflush);

  sWo(gwo,_wscales,0,-1.2,4,1.2, _save,_drawon,_pixmapoff,_wflush);

  sWo(gwo,_wrhtscales,-4,-2.2,4,2.2);

  titleButtonsQRD(vp);
////////////////////////////// PLINE ////////////////////////////////////////

  void Pline()
  {

  sWo(gwo,_wusescales,0,_whue,RED_,_wline,0,0,1,1,GREEN_,_WEO);

  sWo(gwo,_whue,"red",_wline,0.2,0,1,0.9,ORANGE_,_WEO);

  sWo(gwo,_wclipborder,BLACK_,_wline,0,1,1,0,BLUE_,_WEO);

  plot(gwo,_wline,0,0.5,1,0.5,BLUE_,_WEO);

  plot(gwo,_wsymbol,0.5,0.5,"star5",_WEO);

  plot(gwo,_wcircle,0.5,0.5,0.5,GREEN_,_WEO);

  plot(gwo,_wbox,0.5,0.5,0.7,0.7,BLACK_,_WEO);
  //plotgw(vp,_symbol,0.5,0.5,"triangle",_WEO);
  //sWo(gwo,_showpixmap,_WEO);

  sWo(gwo,_usescales,1,_clipborder,BLUE_,_border,BLACK_,_WEO);

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
//  sWo(gwo,_showpixmap)


  axnum(gwo,1);

  axnum(gwo,2);

  axnum(gwo,3);

  axnum(gwo,4);


//  sWo(gwo,_gridhue,BLUE_)
//  grid(gwo)

  }

  Pline();
 // test  postscript print

  do_laser = 1;

  ans=query("replot to postscript?","n");

  if (ans != "y") {

    do_laser = 0;

  }


  if (do_laser) {

  OpenLaser("pline.ps",1) ; //landscape 1 0 portrait;

  ScrLaser(vp);
// ScrLaser(gwo)  //  not required the window scrlaser operates on all wobs

  Pline();

  CloseLaser();

  <<" did we produce a postscript ?\n";

  }
//

;//==============\_(^-^)_/==================//;
