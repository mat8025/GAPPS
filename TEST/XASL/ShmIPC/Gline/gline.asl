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
  include "gevent.asl";
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
  
  vp = cWi(@title,"WAVES",@resize,0.05,0.01,0.99,0.9,0);
  
  sWi(vp,@pixmapon,@drawooff,@save,@bhue,WHITE_);
  
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
  
  gwo= cWo(vp,@GRAPH,@name,"GL",@color,WHITE_);
  
  sWo(gwo,@clip,cx,cy,cX,cY, @resize,0.05,0.1,0.99,0.95);
  
    // scales 
  sx = 0.0;
  sX = 6*pi;
  sy = -2;
  sY = 2.1;
    // units  - radians
  <<"$sx $sX $sy $sY \n";
  
  
  sWo(gwo,@scales, sx, sy, sX, sY,		\
  @save,@redraw,@drawoff,@pixmapon);
  
  sWo(gwo,@savepixmap);
  
  
////////////////////////////// GLINE ////////////////////////////////////////
  
  
  N = 200;
  
  float XVEC[];
  
  XVEC = Frange(N,0,6*pi);
  
  
  Float Rnvec[];
  
  
  Rnvec = Grand(N);
  
  pi2 = pi * 0.5;
  
  <<" $(Caz(XVEC)) \n";
  <<" $XVEC[0:10] \n";
  <<"%V $Rnvec[0:10] \n";
  <<"$(typeof(Rnvec)) \n";
  
// 
//float SVEC = Sin(XVEC)
  
  SVEC = Sin(XVEC);
  
  <<" $(typeof(SVEC)) \n";
  
  ZVEC = Rnvec + SVEC;
  
  // CreateGline   cGl
  
//  xn_gl = cGl(@wid,gwo,@type,"XY",@xvec,XVEC,@yvec,Rnvec,@color,"red")
  
  xn_gl = cGl(gwo,@TXY,XVEC,Rnvec,@color,RED_);
  
  xs_gl = cGl(gwo,@TXY,XVEC,SVEC,@color,BLUE_);
  
  xz_gl = cGl(gwo,@TXY,XVEC,ZVEC,@hue,GREEN_);
  
  sWo(gwo,@hue,GREEN_,@refresh);
  
  sWo(gwo,@showpixmap);
  
  f = 0.5;
  
  
  <<"%V $XVEC[0:20] \n";
  
  WVEC = XVEC * f;
  
  <<"%V $WVEC[0:20] \n";
  
  
  SVEC = Sin(WVEC);
  
  <<"%V $SVEC[0:20] \n";
  
   // go_on= iread("--->");
  
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
  
  
  sGl(xn_gl,@hue,"red");
  
  sWo(gwo,@clearpixmap,@clipborder);
  
  
  while (1) {
    
    Rnvec  = Grand(N)  * 0.1;
    
//<<"$Rnvec[0:10]\n"
    
    WVEC = XVEC * f;
    OVEC = WVEC + pi2;
    
    SVEC = Sin(WVEC);
    CVEC = Cos(OVEC);
    
    //SVEC = Sin(XVEC * f)
    
    ZVEC = Rnvec + (CVEC * 0.5);
    
    
    sWo(gwo,@clearpixmap,@clipborder);
    
    
    dGl(xn_gl);  // DrawGline; 
    
    dGl(xs_gl);
    
    dGl(xz_gl);
    
    sWo(gwo,@showpixmap,@clipborder);
    
    if (i < M/2) {
      f += 0.005;
      }
    else {
      f -= 0.004;
      }
    
    
    i++;
    if (i > 2000) {
      i = 0;
      }
    
    
    }
//=====================================//
  
  
