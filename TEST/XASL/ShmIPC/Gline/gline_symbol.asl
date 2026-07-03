//%*********************************************** 
//*  @script gline_symbol.asl 
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
  
  #include "debug.asl";
  #include "hv.asl";
  #include "tbqrd";
 // include "gevent.asl";
  
  debugON();

//  sdb(1,"step")
  pi = 4.0 * atan(1.0); 


  N = 15;
  
  //   float Xvec[];

  Vec Xvec(FLOAT_,N);

  Xvec.pinfo();

  Xvec = Frange(N,10,180);

  Xvec.pinfo();


 <<"%V $Xvec \n"



ok=Ask(" Xvec ?",0)
  
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

//  sdb(1,"step")
  vp = cWi("WAVES")


  sWi(_woid,vp,_wresize,wbox(0.01,0.05,0.90,0.95,0)  ); 
 
  sWi(_woid,vp,_wpixmap,ON_,_wdraw,ON_,_wsave,ON_,_wsavepixmap,ON_,_wbhue,RED_);
  
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
  
  gwo= cWo(vp,WO_GRAPH_);

  sWo(_woid,gwo,_WNAME,"GL",_WCOLOR,RED_);
  
  sWo(_woid,gwo,_wclip,wbox(cx,cy,cX,cY), _wresize,wbox(0.05,0.1,0.99,0.95,0));
  
    // scales 
  sx = 0.0;
  //sX = 6*pi;
  sX = 200;
  sy = 0;
  sY = 50;
    // units  - radians
  <<"scales $sx $sX $sy $sY \n";
  
  
   sWo(_woid,gwo,_wscales,wbox( sx, sy, sX, sY),  _wsave,ON_,_wredraw,ON_,_wdraw,ON_,_wpixmap,OFF_,_wclipbhue,GREEN_);

sWi(_woid,vp,_wscales,wbox( sx, sy, sX, sY));
   sWo(_woid,gwo,_WSAVEPIXMAP,OFF_);
   //sWo(_woid,gwo,_WAXNUM,2);
   //sWo(_woid,gwo,_WAXNUM,1);


  sWo(_woid,gwo,_WSHOWPIXMAP,OFF_);



////////////////////////////// GLINE ////////////////////////////////////////
  

 Vec Svec(FLOAT_,N);

 Svec = Frange(N,15,15);
  
  <<" $(typeof(Svec)) \n";
  
  xs_gl = cGl(gwo)

  sGl(_GLID,xs_gl,_GLXVEC,Xvec,_GLYVEC,Svec,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE,BLUE_,_GLHUE,LILAC_)

  Symsz = 1.0;
  sGl(_GLID,xs_gl,_GLSYMSIZE, Symsz,_GLSYMHUE,BLUE_,_GLSYMFILL,ON_);

  Symsz = 0.5;
  sGl(_GLID,xs_gl,_GLSYMSIZE, Symsz,_GLSYMHUE,GREEN_);

    Str quit;

   sGl(_GLID,xs_gl,_GLSYMSIZE, Symsz,_GLSYMHUE,ORANGE_ );  // DrawGline; 

  
  Vec Rnvec(FLOAT_,N);
  
  
  Rnvec = Grand(N);
  
  pi2 = pi * 0.5;
  
  <<" $(Caz(Xvec)) \n";
  <<" $Xvec[0:10] \n";
  <<"%V $Rnvec[0:10] \n";
  <<"$(typeof(Rnvec)) \n";
  
// 
//float Svec = Sin(Xvec)
  
 // Svec = Sin(Xvec);


  
  Zvec = Rnvec + Svec;
  
  // CreateGline   cGl
  

  
  xn_gl = cGl(gwo)
  
  sGl(xn_gl,_GLXVEC,Xvec,_GLYVEC,Rnvec,_GLHUE,RED_,_GLSYMBOL,ITRI_,_GLSYMHUE,BROWN_,_GLHUE,BROWN_);
  
    
  xz_gl = cGl(gwo);

  sGl(xz_gl,_GLXVEC,Xvec,_GLYVEC,Zvec,_GLHUE,YELLOW_);
  
  sWo(_woid,gwo,_whue,GREEN_,_wupdate,ON_);
  
  sWo(_woid,gwo,_wshowpixmap,OFF_);
  
  f = 0.5;
  
  <<"%V $xn_gl $xs_gl $xz_gl  \n"
  <<"%V $Xvec \n";
  
  Wvec = Xvec * f;
  
  <<"%V $Wvec \n";
  
  
 // Svec = Sin(Wvec);
  
  <<"%V $Svec \n";
  
  
  
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

  sym = 9

  hue = BLACK_;

  Symsz = 0.1;
          msymx = sX/10.0;
	  msymy = sY/10.0;

   msize = 2.0;

   sWo(_woid,gwo,_wscales,wbox( sx, sy, sX, sY,0),_wclearclip,hue+1)
  fill =1
  sym_show =1;
  if (sym_show) {
   for (sym = 1; sym <20 ; sym++) {
   plotsymbol(gwo,sym,msymx,msymy,hue,msize,fill);

   symname = symbolName(sym)
   ok=Ask("See $sym $symname ?",1)
   msymx += 4
   msymy += 1
   }

 }
          msymx = sX/2;
	  msymy = sY/2;

   msize = 2.0;


  Symsz =2.0;
  sym = 9;
  hue =RED_;
while(1) {

   
   sWo(_woid,gwo,_wclearclip,WHITE_)
	  

   symname = symbolName(sym)
 <<"%V $sym $hue $Symsz $symname \n"

   plotsymbol(gwo,sym,msymx,msymy,hue,msize,fill);

   sGl(_GLID,xs_gl,_GLSYMSIZE, Symsz,_GLSYMBOL,sym,_GLSYMHUE,hue,_GLDRAW,ON_);  // DrawGline; 

  
   
//   hue++;
   quit=Ask("Quit? %V $hue $sym $symname $Symsz $msymx $msize ",1);
   if (quit == "y")
       exit()


//  msymx += 2

  if (msymx > 100.0) {
      msymx = 0.0;
  }
  
  //msize += 1.0;

  if (msize > 10.0) {
      msize  = 1.0;
  }

  sym++

  if (sym > 20) {
      sym = 1;
  }

  if (hue > 10) {
      hue = 1;
  }

  Symsz += 1;

  msize  = Symsz;
  
  if (Symsz > 20) {
    Symsz = 1.0;
  }

 if (quit == "y") {
   sGl(_GLID,xs_gl,_GLSYMSIZE, Symsz,_GLSYMHUE,ORANGE_,_GLDRAW,ON_);  // DrawGline;
    exitgs()
    exit()
 }

  }





exit()



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
    
    
    sWo(_woid,gwo,_wclearpixmap,ON_,_wclipborder,BLACK_);
    
    sWo(_woid,gwo,_wline,wbox(0.1,0.1,15,f,PINK_) ,_whue,BLUE_);
	
    sGl(_GLID,xn_gl,_GLDRAW,ON_);  // DrawGline; 
    
    sGl(_GLID,xs_gl,_GLDRAW,ON_); // if error should  warn and remove/skip  this line on next loop?
    
    sGl(_GLID,xz_gl,_GLDRAW,ON_);
    
    sWo(_woid,gwo,_wshowpixmap,ON_,_wclipborder,ORANGE_);
    
    if (i < M/2) {
      f += 0.005;
      }
    else {
      f -= 0.004;
      }
    
    
    i++;

   if ((i % 50) == 0 0) {
 <<"loop $i\n"
   }
   if (i > 1000) {
      i = 0;
      break;
      }
    
  //  getMouseClick()

//ans=query("again?",ans)
//if (ans == "n") {
//    break
//}
   
    
    }
//=====================================//

  sWi(vp,_WCLEAR,ORANGE_,_WSAVEPIXMAP,_ON);
  sWi(vp,_WSHOWPIXMAP,_ON);

quit=query("quit");

   sWo(_woid,gwo,_WCLEARCLIP,WHITE_,_WSAVEPIXMAP,ON_);
   //sWo(_woid,gwo,_WAXNUM,2);
   //sWo(_woid,gwo,_WAXNUM,1);
  



  sWo(_woid,gwo,_WSHOWPIXMAP,ON_);

<<"out of loop - trying to quit!\n"


//exitgs();
 quit=query("quit");

exit();
