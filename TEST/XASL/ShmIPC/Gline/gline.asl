/* 
 *  @script gline.asl                                                         
 * 
 *  @comment test gline draw funcs  
 *  @release Carbon                                                           
 *  @vers 1.4 Be Beryllium [asl 6.69 : C Tm]                                  
 *  @date 06/28/2026 09:14:10                                                 
 *  @cdate 1/1/2003        
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2026 -->                                     
 * 
 */ 

  
  #include "debug.asl";
 // #include "hv.asl";
//  #include "tbqrd";
 // include "gevent.asl";
  
  debugON();



  pi = 4.0 * atan(1.0); 


  N = 200;
  
  //   float Xvec[];

  Vec Xvec(FLOAT_,N);

  Xvec.pinfo();

  Xvec = Frange(N,0,6*pi);


  Xvec.pinfo();


 <<"%V$Xvec \n"




  
  Graphic = CheckGwm();
  
  if (!Graphic) {
    X=spawngwm();
    if (X <= 0) {
      <<"spawn failed !\n";
      exit();
      }
    <<"asl pid $X ?\n";
    }
  



/////////////////////////////  SCREEN --- WOB ///////////////
  
  Str vptitle = "WAVES"; 
  
// main window on screen
//
//    CreateGwindow      cWi
  
  vp = cWi("WAVES")
  vp =  cWi(vptitle); 

  sWi(_woid,vp,_wresize,wbox(0.01,0.05,0.90,0.95,0)  ); 
 
  sWi(_woid,vp,_wpixmap,ON_,_wdraw,ON_,_wsave,ON_,_wsavepixmap,ON_,_wbhue,RED_);
  
 // titleButtonsQRD(vp);
//  titleVers();
  
  cx = 0.1;
  cX = 0.9;
  cy = 0.2;
  cY = 0.95;
  
    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily
  
  daname = "RADAR_SCREEN";
  
  gwo= cWo(vp,WO_GRAPH_);

  sWo(_woid,gwo,_WNAME,"GL",_WCOLOR,RED_);
  
  sWo(_woid,gwo,_wclip,wbox(cx,cy,cX,cY), _wresize,wbox(0.05,0.1,0.99,0.95,0));
  
    // scales 
  sx = 0.0;
  sX = 6*pi;
  sy = -2;
  sY = 2.1;
    // units  - radians
  <<"scales $sx $sX $sy $sY \n";
  
  
   sWo(_woid,gwo,_wscales,wbox( sx, sy, sX, sY),  _wsave,ON_,_wredraw,ON_,_wdraw,ON_,_wpixmap,ON_,_wclipbhue,GREEN_);

   sWo(_woid,gwo,_WSAVEPIXMAP,ON_);
   sWo(_woid,gwo,_WAXNUM,2);
   sWo(_woid,gwo,_WAXNUM,1);


  sWo(_woid,gwo,_WSHOWPIXMAP,ON_);

  
////////////////////////////// GLINE ////////////////////////////////////////
  
  


  
  Vec Rnvec(FLOAT_,N);
  
  
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
  

  
  xn_gl = cGl(gwo)
  
  sGl(_GLID,xn_gl,_GLXVEC,Xvec,_GLYVEC,Rnvec,_GLHUE,RED_);
  
  xs_gl = cGl(gwo)

  sGl(_GLID,xs_gl,_GLXVEC,Xvec,_GLYVEC,Svec,_GLHUE,BLUE_)
  
  xz_gl = cGl(gwo);

  sGl(xz_gl,_GLXVEC,Xvec,_GLYVEC,Zvec,_GLHUE,YELLOW_);
  
  sWo(_woid,gwo,_whue,GREEN_,_wupdate,ON_);
  
  sWo(_woid,gwo,_wshowpixmap,ON_);
  
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
  
  
  sGl(_GLID,xn_gl,_GLHUE,RED_);
  
  sWo(_woid,gwo,_wclearpixmap,ON_,_wclipborder,PINK_);
  //ans=query("listo?:");
  hue_line = 1;
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
    
    
  //  sWo(_woid,gwo,_wclearpixmap,ON_,_wclipborder,BLACK_);
   if ( (i % 10) == 0) { 
  sWo(_woid,gwo,_wclearclip,ON_,_wclipborder,BLACK_);
    }

    <<" wline %V $f $hue_line\n"
    sWo(_woid,gwo,_wline,wbox(0.1,0.1,15,f,hue_line) );


	hue_line++
	
	if (hue_line > 12)
	 hue_line =1;
	 
  //  sGl(_GLID,xn_gl,_GLDRAW,ON_);  // DrawGline; 
    

    if (i == 15) {
    sGl(_GLID,xs_gl,_GLDRAW,ON_); // if error should  warn and remove/skip  this line on next loop?
    }
//    sGl(_GLID,xz_gl,_GLDRAW,ON_);
    
 //   sWo(_woid,gwo,_wshowpixmap,ON_,_wclipborder,ORANGE_);
    
    if (i < M/2) {
      f += 0.005;
      }
    else {
      f -= 0.004;
      }
    
    
    i++;


   if (i > 100) {
      i = 0;
      break;
      }
    
  //  getMouseClick()

ans= Ask("again? loop $i",1)
if (ans == "n") {
    break
}
   
    
    }
//=====================================//

  sWi(vp,_WCLEAR,ORANGE_,_WSAVEPIXMAP,_WEO);
  sWi(vp,_WSHOWPIXMAP,_WEO);



   sWo(_woid,gwo,_WCLEARCLIP,WHITE_,_WSAVEPIXMAP,ON_);
  // sWo(_woid,gwo,_WAXNUM,2);
  // sWo(_woid,gwo,_WAXNUM,1);
  



  sWo(_woid,gwo,_WSHOWPIXMAP,ON_);

<<"out of loop - trying to quit!\n"


exitgs();
 quit=query("quit");

exit();
