//%*********************************************** 
//*  @script gline.asl 
//* 
//*  @comment test gline draw funcs 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                 
//*  @date Sat Mar  2 12:55:33 2019 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
  include "debug.asl";
  include "hv.asl";
  include "tbqrd";
 // include "gevent.asl";
  
  debugON();
  
  
  Graphic = CheckGwm();
  
  if (!Graphic) {
    X=spawngwm();
    if (X <= 0) {
      <<"spawn failed !\n";
      exit();
      }
    <<"asl pid $X ?\n";
    }
  
  pi = 4.0 * atan(1.0); 
  
/////////////////////////////  SCREEN --- WOB ///////////////
  
  str vptitle = "WAVES"; 
  
// main window on screen
//
//    CreateGwindow      cWi
  
  vp = cWi(_title,"WAVES",_resize,0.05,0.01,0.99,0.9,0);
  
  sWi(vp,_pixmapon,_drawon,_save,_savepixmap,_bhue,RED_,_flush);
  
  titleButtonsQRD(vp);
  titleVers();
  
  cx = 0.1;
  cX = 0.9;
  cy = 0.2;
  cY = 0.95;
  
    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily
  
  daname = "RADAR_SCREEN";
  
  gwo= cWo(vp,_GRAPH,_name,"GL",_COLOR,RED_,_FLUSH);
  
  sWo(gwo,_clip,cx,cy,cX,cY, _resize,0.05,0.1,0.99,0.95,0,_FLUSH);
  
    // scales 
  sx = 0.0;
  sX = 6*pi;
  sy = -2;
  sY = 2.1;
    // units  - radians
  <<"scales $sx $sX $sy $sY \n";
  
  
  sWo(gwo,_scales, sx, sy, sX, sY,  _save,_redraw,_drawon,_pixmapon,_clipbhue,GREEN_,_EO);

sWo(gwo,_WSAVEPIXMAP,_WFLUSH);
    sWo(gwo,_WAXNUM,2,_WFLUSH);
   sWo(gwo,_WAXNUM,1,_WFLUSH);
  



  sWo(gwo,_WSHOWPIXMAP);



  
////////////////////////////// GLINE ////////////////////////////////////////
  
  
  N = 200;
  
  float Xvec[];
  
  Xvec = Frange(N,0,6*pi);
  
  
  Float Rnvec[];
  
  
  Rnvec = Grand(N);
  
  pi2 = pi * 0.5;
  
  <<" $(Caz(Xvec)) \n";
  <<" $Xvec[0:10] \n";
  <<"%V $Rnvec[0:10] \n";
  <<"$(typeof(Rnvec)) \n";
  
// 
//float Svec = Sin(Xvec)
  
  Svec = Sin(Xvec);
  
  <<" $(typeof(Svec)) \n";
  
  Zvec = Rnvec + Svec;
  
  // CreateGline   cGl
  
//  xn_gl = cGl(_wid,gwo,@type,"XY",@xvec,Xvec,@yvec,Rnvec,@color,"red")
  
  xn_gl = cGl(gwo)
  
  sGl(xn_gl,_GLTXY,Xvec,Rnvec,_GLHUE,RED_,_flush);
  
  xs_gl = cGl(gwo)

  sGl(xs_gl,_GLTXY,Xvec,Svec,_GLHUE,BLUE_,_flush);
  
  xz_gl = cGl(gwo);

  sGl(xz_gl,_GLTXY,Xvec,Zvec,_GLHUE,YELLOW_,_eo);
  
  sWo(gwo,_hue,GREEN_,_update,_FLUSH);
  
  sWo(gwo,_showpixmap,_eo);
  
  f = 0.5;
  
  <<"%V $xn_gl $xs_gl $xz_gl  \n"
  <<"%V $Xvec[0:20] \n";
  
  Wvec = Xvec * f;
  
  <<"%V $Wvec[0:20] \n";
  
  
  Svec = Sin(Wvec);
  
  <<"%V $Svec[0:20] \n";
  
  //go_on= iread("--->");
  
  //<<"you typed $go_on $(typeof(goon))\n"
  
//===================================//
  
// lets make this 
// signal
// noise
// signal + noise
// filtered (signal + noise)
// recovered signal
  
  M = 200;
  
  int i = 0;
  
  
  sGl(xn_gl,_GLHUE,RED_,_GLEO);
  
  sWo(gwo,_clearpixmap,_clipborder);
  //ans=query("listo?:");
  
  while (1) {
    
    Rnvec  = Grand(N)  * 0.1;
    
//<<"$Rnvec[0:10]\n"
//<<"$Svec[0:10]\n"
    
    Wvec = Xvec * f;
    OVEC = Wvec + pi2;
    
    Svec = Sin(Wvec);
    CVEC = Cos(OVEC);
    
    //Svec = Sin(Xvec * f)
    
    Zvec = Rnvec + (CVEC * 0.5);
    
    
   sWo(gwo,_clearpixmap,_clipborder,BLACK_,_flush);
    
    //sWo(gwo,_line,0.1,0.1,3.0,2.0 ,RED_,_flush);

    //plot(gwo,_line,0.1,0.1,18.0,2 ,RED_);
    
    sWo(gwo,_line,0.1,0.1,15,f ,BLUE_,_flush);
	
    sGl(xn_gl,_GLDRAW);  // DrawGline; 
    
    sGl(xs_gl,_GLDRAW); // if error should  warn and remove/skip  this line on next loop?
    
    sGl(xz_gl,_GLDRAW);
    
    sWo(gwo,_showpixmap,_clipborder,ORANGE_,_flush);
    
    if (i < M/2) {
      f += 0.005;
      }
    else {
      f -= 0.004;
      }
    
    
    i++;
    if (i > 200) {
      i = 0;
      break;
      }
    
  //  getMouseClick()

//ans=query("again?",ans)
//if (ans == "n") {
//    break
//}
    <<"loop $i\n"
    
    }
//=====================================//

   sWi(vp,_WCLEAR,ORANGE_,_WSAVEPIXMAP,_WEO);
  sWi(vp,_WSHOWPIXMAP,_WEO);

quit=query("quit");

   sWo(gwo,_WCLEARCLIP,WHITE_,_WSAVEPIXMAP,_WFLUSH);
   sWo(gwo,_WAXNUM,2,_WFLUSH);
   sWo(gwo,_WAXNUM,1,_WFLUSH);
  



  sWo(gwo,_WSHOWPIXMAP);

<<"out of loop - trying to quit!\n"


//exitgs();
quit=query("quit");

exit();
