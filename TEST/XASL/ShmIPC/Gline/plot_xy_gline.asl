//%*********************************************** 
//*  @script plot_xy_gline.asl 
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


//  read XY data as record - rows first col x succeding cols y's
//  plot as glines
//  pick symbols


#include "wevent.asl" 

 openDLL("image")
  debugON();

//  sdb(1,"step")
  pi = 4.0 * atan(1.0); 

  
  N = 10;
  float Xvec[];

  Xvec.pinfo();

  Xvec = Frange(N,0,5);

  Xvec.pinfo();


 <<"%V $Xvec \n"


  float Yvec[];


  Yvec = Frange(N,10,30);

  Yvec.pinfo();

  Yvec[4] = 8.0;

  Yvec[6] = 4.0;


 <<"%V $Yvec \n"

  float Yvec2[];


  Yvec2 = Frange(N,30,45);

  Yvec2.pinfo();

  Yvec2[4] = 35.0;

  Yvec2[6] = 17.0;

 <<"%V $Yvec2 \n"



ok=Ask(" Vecs OK ?",0)



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
  
  Str vptitle = "XYPLOT"; 
  
// main window on screen
//
//    CreateGwindow      cWi

//  sdb(1,"step")
  vp = cWi(vptitle)


  sWi(_woid,vp,_wresize,wbox(0.01,0.05,0.90,0.95,0)  ); 
 
  sWi(_woid,vp,_wpixmap,ON_,_wclear,WHITE_,_wdraw,ON_,_wsave,ON_,_wsavepixmap,OFF_,_wbhue,RED_);
  
  titleButtonsQRD(vp);
  titleVers();
  
  cx = 0.1;
  cX = 0.9;
  cy = 0.2;
  cY = 0.95;
  
    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily
  
  daname = "XYDATA";
  
  gwo= cWo(vp,WO_GRAPH_);

  sWo(_woid,gwo,_WNAME,"GL",_WCOLOR,RED_);
  
  sWo(_woid,gwo,_wclip,wbox(cx,cy,cX,cY), _wresize,wbox(0.05,0.1,0.99,0.95,0),_wclearclip,WHITE_);
  
    // scales 
  sx = 0.0;
  sX = 5;
  sy = 0;
  sY = 60;

  <<"scales $sx $sX $sy $sY \n";
  
  
   sWo(_woid,gwo,_wscales,wbox( sx, sy, sX, sY),  _wsave,ON_,_wredraw,ON_,_wdraw,ON_,_wpixmap,OFF_,_wclipbhue,GREEN_);

   sWi(_woid,vp,_wscales,wbox( sx, sy, sX, sY));

   sWo(_woid,gwo,_WSAVEPIXMAP,OFF_);

   //sWo(_woid,gwo,_WAXNUM,2);
   //sWo(_woid,gwo,_WAXNUM,1);

   sWo(_woid,gwo,_WSHOWPIXMAP,OFF_);

////////////////////////////// GLINE ////////////////////////////////////////
    
  //xy_gl = cGl(gwo)

//  sGl(_GLID,xy_gl,_GLXVEC,Xvec,_GLYVEC,Yvec,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE,BLUE_,_GLHUE,LILAC_)

//  sGl(_GLID,xy_gl,_GLXVEC,Xvec,_GLYVEC,Yvec,_GLHUE,LILAC_)

  Symsz = 1.0;

  //sGl(_GLID,xy_gl,_GLSYMSIZE, Symsz,_GLSYMHUE,BLUE_,_GLSYMFILL,ON_);


  xy2_gl = cGl(gwo)

  sGl(_GLID,xy2_gl,_GLXVEC,Xvec,_GLYVEC,Yvec2,_GLHUE,GREEN_)








  sWo(_woid,gwo,_whue,GREEN_,_wupdate,ON_);
  
  sWo(_woid,gwo,_wshowpixmap,OFF_);
  
  f = 0.5;
  
  <<"%V $xn_gl $xs_gl $xz_gl  \n"
  <<"%V $Xvec \n";

  Symsz = 3.0;
          msymx = sX/10.0;
	  msymy = 40.0;

   msize = 2.0;

   sWo(_woid,gwo,_wscales,wbox( sx, sy, sX, sY,0),_wclearclip,hue+1)
  hue = BLUE_;
  fill =1
  sym_show =1;
  sym =1
  if (sym_show) {
kloop = 0
while (1) {

   eventWait()

   sWo(_woid,gwo,_wclearclip,WHITE_)

   huename = getColorName(hue)
   symname = symbolName(sym)
//   sGl(_GLID,xy_gl,_GLSYMBOL,sym,_GLSYMSIZE,Symsz,_GLDRAW,ON_ ); // DrawGline;
   
 //  plotsymbol(gwo,sym,msymx,msymy,hue,Symsz,fill);

   if ((kloop % 2) == 0) {
   vvdraw(gwo,Xvec,Yvec)
   }
   
   	kloop++;
   Yvec2 += 0.5;
   
   if ((kloop % 2) == 0) {
   sGl(_GLID,xy2_gl,_GLWIDTH,3,_GLSYMBOL,sym,_GLSYMSIZE,Symsz,_GLDRAW,ON_ ); // DrawGline;
   //sGl(_GLID,xy2_gl,_GLHUE,hue++,_GLDRAW,ON_ ); // DrawGline;
   }
   if (Yvec2[6] > 40) {
       Yvec2 -= 20
   }
   
   


//  gline no symbols

ok=Ask("See $sym $symname ?",0)

   Textr(gwo,"$sym $symname $huename %6.2f $Symsz",2,5,BLACK_)
   
   msymx += 0.5
   if (msymx > 6) {
       msymx = 1
   }

   if ((kloop % 3) ==0) 
   sym++;
   
   if (sym >20)
       sym = 1
 
    Symsz += 0.25;

   if (Symsz > 10)
       Symsz = 1.0;

	 if (ebutton_ == 3) {
             exitgs()
	     exit()
         }

  }

 }

 quit=Ask("quit",1);

exitgs();
exit();
