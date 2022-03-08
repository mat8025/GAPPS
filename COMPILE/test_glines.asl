/* 
 *  @script test_glines.asl  
 * 
 *  @comment test cpp interface to xgs directives
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.73 C-Li-Ta]                                
 *  @date 01/16/2022 10:43:41 
 *  @cdate 01/16/2022 10:43:41 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//

///
///  
///


#define ASL 0
#define CPP 1


#if CPP

 //opendll("plot");

#include "gevent.h"


void
Uac::glineWorld(Svarg * sarg)  
{
   cout << "hello testing gline ops " << endl;
#endif

#if ASL
<<"%V $s %s $cv\n";
#endif

/// launch xgs
#include "graphic.asl"

Gevent gev;


Str ans;

    rainbow();



  //  vp = cWi(@title,"PLOT_OBJECTS",@resize,0.05,0.01,0.99,0.95)
/// create a window
  int vp = cWi("PLOT_STUFF");
    //SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")
cout << "vp " << vp << endl;
     float x0= 0.1;
     float y0 =0.1;
     float x1 = 0.5;
     float y1 = 0.7;

      float rsz[5] = {0.1,0.1,0.5,0.6,0.0};

     int ws = 0; //which screen 0,7 -1 is current

//   int vok= sWi(vp,WRESIZE,0.1,0.2,0.5,0.5,-1,WHUE,YELLOW_,WPIXMAPDRAWON,WDRAWON,WREDRAW);

   int vok= sWi(vp,WTITLE,"PLOT_OBJECTS",WRESIZE,rsz,WHUE,YELLOW,WBHUE,WHITE_,
                   WPIXMAPON,WDRAWON,WCLEAR,WREDRAW,EO);

cout << "vok " << vok << endl;



//ans=query("see window?");

      rsz[3] = 0.8;
      vok =sWi(vp,WHUE,MAGENTA_,WRESIZE,rsz,WREDRAW,EO);


  int gwo= cWo(vp,WO_GRAPH);
   float worsz[6] = {0.1,0.1,0.9,0.9,0.0};
  sWo(gwo,WRESIZE,worsz,WFLUSH);


   float pi = 4.0 * atan(1.0); 
    // scales 
  float sx = 0.0;
  float sX = 6*pi;
  float sy = -2;
  float sY = 2.1;
    // units  - radians
  //<<"scales $sx $sX $sy $sY \n";
  
  
 // sWo(gwo,_scales, sx, sy, sX, sY,  _save,_redraw,_drawon,_pixmapon,_clipbhue,GREEN_,_EO);
  sWo(gwo,WSAVE,WREDRAW,WDRAWON,WPIXMAPON,WCLIPBHUE,GREEN_,WFLUSH);
  
  sWo(gwo,WSAVEPIXMAP,WFLUSH);
  


////////////////////////////// GLINE ////////////////////////////////////////

  
  int N = 200;
  
  Vec Xvec(FLOAT_,N,0.0, (6.0*pi/(1.0*N)));
  
  //Xvec = Frange(N,0,6*pi);
  
  
  Vec Rnvec(FLOAT_,N);
  
  
 // Rnvec = Grand(N);  Rnvec.Grand() // fill with gaussian random numbers
  
  float pi2 = pi * 0.5;
  
  //<<" $(Caz(Xvec)) \n";
  //<<" $Xvec[0:10] \n";
 // <<"%V $Rnvec[0:10] \n";
  //<<"$(typeof(Rnvec)) \n";

    Vec Svec(FLOAT,N);


      Vec Wvec(FLOAT,N);

      Vec Cvec(FLOAT,N);      

// 
//float Svec = Sin(Xvec)  //Svec.Sin(); // apply Sin function to all elements
  
  //Svec = Sin(Xvec);
  
  //<<" $(typeof(Svec)) \n";
  
  Vec Zvec(FLOAT_,N);


  Zvec = Rnvec + Svec;
  
  // CreateGline   cGl
  
//  xn_gl = cGl(_wid,gwo,@type,"XY",@xvec,Xvec,@yvec,Rnvec,@color,"red")
  
  int xn_gl = cGl(gwo);
  
  sGl(xn_gl,_GLTXY,Xvec,Rnvec,_GLHUE,RED_,_GLEO);
  
  int xs_gl = cGl(gwo);

  sGl(xs_gl,_GLTXY,Xvec,Svec,_GLHUE,BLUE_,_GLEO);
  
  int xz_gl = cGl(gwo);

  sGl(xz_gl,_GLTXY,Xvec,Zvec,_GLHUE,YELLOW_,_GLEO);
  
  sWo(gwo,WHUE,GREEN_,WREFRESH,WFLUSH);
  
  sWo(gwo,WSHOWPIXMAP,WFLUSH);
  
  float f = 0.5;


  
  Wvec = Xvec * f;
  
  Svec = sin(Wvec);
  
//  <<"%V $Svec[0:20] \n";
//===================================//
  
// lets make this 
// signal
// noise
// signal + noise
// filtered (signal + noise)
// recovered signal
  
  int M = 200;
  
  int i = 0;
  
  
  sGl(xn_gl,_GLHUE,RED_,_GLEO);
  
   sWo(gwo,WCLEARPIXMAP,WCLIPBORDER,WFLUSH);
  ans=query("listo?:");
  
  while (1) {
    
    Rnvec  = Grand(N)  * 0.1;
    
//<<"$Rnvec[0:10]\n"
//<<"$Svec[0:10]\n"
    
    Wvec = Xvec * f;
   Cvec = Wvec + pi2;
    
    Svec = Sin(Wvec);

    Cvec.Cos();
    
    //Svec = Sin(Xvec * f)
    
    Zvec = Rnvec + (Cvec * 0.5);
    
    
   sWo(gwo,WCLEARPIXMAP,WCLIPBORDER,BLACK_,WFLUSH);
    
    //sWo(gwo,_line,0.1,0.1,3.0,2.0 ,RED_,_flush);

    //plot(gwo,_line,0.1,0.1,18.0,2 ,RED_);
    
    sWo(gwo,WLINE,0.1,0.1,15,f ,BLUE_,WFLUSH);
	
    sGl(xn_gl,_GLDRAW);  // DrawGline; 
    
    sGl(xs_gl,_GLDRAW);  
    
    sGl(xz_gl,_GLDRAW);  // DrawGline; 
    
    sWo(gwo,WSHOWPIXMAP,WCLIPBORDER,ORANGE_,WFLUSH);
    
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
    
  //  getMouseClick()

   ans=query("again?");
   if (ans != "y") {
      break;
    }
    
  }





//ans=query("see window?");

/// create a window obj

ans=query("did we see wob -CSV  button?");



ans=query("looking for events ?");
int nevent = 0;
while (1) {
   gev.eventWait();
   nevent++;
   printf("nevent %d button %d\n",nevent,gev.ebutton);
}


 exitXGS();

#if CPP
}
//==============================//

 extern "C" int test_glines(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 

    o_uac->glineWorld(sarg);

  }
#endif  


//================================//






