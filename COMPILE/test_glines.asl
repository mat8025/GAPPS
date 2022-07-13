/* 
 *  @script test_glines.asl                                             
 * 
 *  @comment test cpp interface to xgs directives                       
 *  @release CARBON                                                     
 *  @vers 1.5 B Boron [asl 6.4.31 C-Be-Ga]                              
 *  @date 06/17/2022 07:56:17                                           
 *  @cdate 01/16/2022 10:43:41                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  


 int run_asl = 0;

#define ASL 1
#define CPP 0

#if ASL
// the include  when cpp compiling will re-define ASL 0 and CPP 1
#include "compile.asl"

//  printf("ASL %d CPP %d\n",ASL,CPP);
#endif



#if ASL
<<"ASL   $(ASL) CPP $(CPP)\n"
#endif


#if ASL
#define COUT //
 run_asl = runASL();
printf("run_asl %d\n",run_asl);

printf("CPP %d\n",CPP);

#endif
//#define cdbp //


#include "tbqrd.asl"

#if CPP
//#error CPP
 //opendll("plot");
#include <stdio.h>
#include "vec.h"
#include "gline.h"
#include "glargs.h"
#include "winargs.h"
#include "woargs.h"
#include "gevent.h"


void
Uac::glineWorld(Svarg * sarg)  
{
 cout <<"CPP?   \n";

 cout <<"CPP  " << CPP << " ASL?  " << run_asl << endl;

 cout << "Hello testing gline ops " << endl;


#endif



#if ASL
<<"%V running as ASL $run_asl\n";
#include "debug"
#endif

/// launch xgs

#include "graphic.asl"

Gevent gev;

Str ans = "y";

printf("run_asl %d\n",run_asl);

//ans.strPrintf("run_asl %d",run_asl);
//COUT(ans);

Str prompt = "ASL/CPP?";
ans=query(prompt,ans);





    rainbow();
    ignoreErrors();


  //  vp = cWi(@title,"PLOT_OBJECTS",@resize,0.05,0.01,0.99,0.95)
/// create a window
  int vp = cWi("PLOT_STUFF");
    //SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

//cout << "vp " << vp << endl;
     
     float x0= 0.1;
     float y0 =0.1;
     float x1 = 0.5;
     float y1 = 0.7;

      float rsz[5] = {0.1,0.1,0.8,0.8,0.0};

     int ws = 0; //which screen 0,7 -1 is current


     sWi(_WOID,vp,_WTITLE,"PLOT_OBJECTS",_WRESIZE,rsz,_WHUE,YELLOW_,_WBHUE,WHITE_, _WPIXMAP,ON_,_WDRAW,ON_,_WCLEAR,ON_,_WREDRAW,ON_);

//cout << "vok " << vok << endl;
//ans=query("see window?");

      rsz[3] = 0.8;
      sWi(_WOID,vp,_WHUE,MAGENTA_,_WRESIZE,rsz,_WREDRAW,ON_);

  titleButtonsQRD(vp);
  

  int gwo= cWo(vp,WO_GRAPH_);
  float worsz[6] = {0.1,0.1,0.9,0.9,0.0};
  
  sWo(_WOID,gwo,_WRESIZE,worsz);


  double pi = 4.0 * atan(1.0); 
    // scales 
  float sx = 0.0;
  float sX = 6*pi;
  float sy = -2;
  float sY = 2.1;
    // units  - radians
  //<<"scales $sx $sX $sy $sY \n";
  float vscale[5] = {sx,sy,sX,sY,0.0};


 // sWo(gwo,_scales, sx, sy, sX, sY,  _save,_redraw,_drawon,_pixmapon,_clipbhue,GREEN_,_EO);
  sWo(_WOID,gwo,_WSAVE,1,_WREDRAW,1,_WDRAW,0,_WPIXMAP,1,_WCLIPBHUE,GREEN_);


  sWo(_WOID,gwo,_WSCALES,vscale,_WSAVEPIXMAP,1,_WAXNUM,2,_WAXNUM,1);
  


////////////////////////////// GLINE ////////////////////////////////////////
  
  int N = 200;
  
  Vec<float> Xvec(N,0.0, (6.0*pi/(1.0*N)));

COUT(Xvec)

//ans=query("Xvec?");

  //Xvec = Frange(N,0,6*pi);
  
  
  Vec<float> Rnvec(N);
  
  Rnvec.setName("Rnvec");

    if (Rnvec.getType() != FLOAT_) {
    cout<<"Rnvec wrong type " << Rnvec.getName()  << " " << Rnvec.Dtype() << endl;
    }


    COUT(Rnvec)

 //ans=query("see Rnvec?");
  
  
  Rnvec.addGrand(0); // fill with gaussian random numbers
    if (Rnvec.getType() != FLOAT_) {
    cout<<"Rnvec wrong type " << Rnvec.getName()  << " " << Rnvec.Dtype() << endl;
    }

//ans=query("see Rnvec?");
//cout << "Rnvec " << Rnvec << endl;

//ans=query("see Rnvec?");

  double pi2 = pi * 0.5;
  
  // <<" $(Caz(Xvec)) \n";
  // <<" $Xvec[0:10] \n";
  // <<"%V $Rnvec[0:10] \n";
  // <<"$(typeof(Rnvec)) \n";

    Vec<float> Svec(N);

    COUT(Svec);

//ans=query("see Svec?");

      Vec<float> Tvec(N);

      Vec<float> Wvec(N);

      Vec<float> Cvec(N);

Svec.pinfo();

Wvec.pinfo();

Cvec.pinfo();
// 
//float Svec = Sin(Xvec)  //Svec.Sin(); // apply Sin function to all elements
  
  //Svec = Sin(Xvec);

COUT(Xvec)

  Svec = Xvec;

COUT(Svec)

//ans=query("copy Xvec to Svec?");

Svec.pinfo();


  Svec.Cos();

  COUT(Svec)

  Svec.pinfo();
//  ans=query("see Cos Svec?");

  
  Vec<float> Zvec(N);

    if (Zvec.getType() != FLOAT_) {
    cout<<"Zvec wrong type " << Zvec.getName()  << " " << Zvec.Dtype() << endl;
    }


  Zvec = Rnvec ;


    if (Zvec.getType() != FLOAT_) {
    cout<<"Zvec wrong type " << Zvec.getName()  << " " << Zvec.Dtype() << endl;
    }

COUT(Zvec)

 // Zvec += Svec;

//COUT(Zvec)

  // CreateGline   cGl
  
//  xn_gl = cGl(_wid,gwo,@type,"XY",@xvec,Xvec,@yvec,Rnvec,@color,"red")
  
  int xn_gl = cGl(gwo);



//ans=query("see xn_gl?");
 Xvec.pinfo();
 Rnvec.pinfo();
 
// make these ref args?
  //sGl(xn_gl,_GLTXY,&Xvec,&Rnvec,_GLHUE,RED_,_GLEO);

  sGl(_GLID,xn_gl, _GLHUE, RED_, _GLXVEC, Xvec, _GLYVEC, Rnvec);
VCOUT(xn_gl, RED_)
//ans=query("set xn_gl");

  int xs_gl = cGl(gwo);

  COUT(Xvec);
  COUT(Svec);

 // sGl(xs_gl,_GLTXY,&Xvec,&Svec,_GLHUE,BLUE_,_GLEO);

  sGl(_GLID,xs_gl, _GLHUE, RED_, _GLXVEC, Xvec, _GLYVEC, Svec);

VCOUT(xs_gl, _GLHUE)
//ans=query("set xs_gl");
  int xz_gl = cGl(gwo);

 // sGl(xz_gl,_GLTXY,&Xvec,&Zvec,_GLHUE,YELLOW_,_GLEO);

sGl(_GLID,xz_gl, _GLHUE, YELLOW_, _GLXVEC, Xvec, _GLYVEC, Zvec);
VCOUT(xz_gl, _GLXVEC, _GLYVEC)
//ans=query("see xz_gl");


    sWo(_WOID,gwo,_WSHOWPIXMAP,1);
//  ans=query("see sWo?");  
  double f = 0.5;
  float ff =f;

  
  Wvec = Xvec * f;

  Wvec.pinfo();

  Svec = Wvec.Sin();

  Svec.pinfo();

//ans=query("see Sin");

//cout << "Svec " << Svec << endl;

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
  int hue = 1;
  
  sGl(_GLID,xn_gl,_GLHUE,RED_);
  
   sWo(_WOID,gwo,_WCLEARPIXMAP,1,_WCLIPBORDER,BLACK_);

  int kk = 0;

  float lvec[5] = {0.1,0.1,15,f,RED_};

#if CPP
  Siv** sv = vbox(Xvec,Rnvec);

   sv[0]->pinfo();

   sv[1]->pinfo();
#endif

    if (Xvec.getType() != FLOAT_) {
cout<<"Xvec wrong type !\n";
ans=query("check vecs");
    }



    if (Rnvec.getType() != FLOAT_) {
        cout<<"wrong type " << Rnvec.getName()  << endl;
        Rnvec.pinfo();
        Rnvec.setType(FLOAT_);
//ans=query("check vecs");
}

//

//ans=query("looking for events ?");



int nevent = 0;
while (1) {
//   gev.eventWait();

    if ((kk % 100)  == 0) {
         gev.eventRead();
	 }
   nevent++;
 //  printf("nevent %d button %d\n",nevent,gev.ebutton);
    
    Rnvec.addGrand(0) ;
    Rnvec *= 0.1;
    
//<<"$Rnvec[0:10]\n"
//<<"$Svec[0:10]\n"

    if (Rnvec.getType() != FLOAT_) {
    cout<<"Rnvec wrong type " << Rnvec.getName()  << endl;
    }
    

    
    Wvec = Xvec * f;

    if (Wvec.getType() != FLOAT_) {
cout<<"Wvec wrong type !\n";
    }

     Tvec = Wvec + pi2;

    if (Tvec.getType() != FLOAT_) {
cout<<"Tvec wrong type !\n";

    }

//ans=query("see Tvec");

//cout << "Tvec " << Tvec << endl;

 //   Svec = Sin(Wvec);


    Svec = Wvec;
    Svec.Sin();

   Cvec= Tvec.Cos();
   
//Tvec.pinfo();

    if (Tvec.getType() != FLOAT_) {
cout<<"wrong type !\n";
    }

   // Cvec= Tvec;


//Cvec.pinfo();

    if (Cvec.getType() != FLOAT_) {
cout<<"Cvec wrong type !\n";
    }

    //ans=query("see Cvec?");
  //  Tvec.Cos();
    //Tvec *= 0.5;
    //Svec = Sin(Xvec * f)
    
   // Zvec = Rnvec + (Cvec * 0.5);
    Zvec = Cvec * 0.5;
   // Zvec = Rnvec + Tvec;

    if (Zvec.getType() != FLOAT_) {
cout<<"Zvec wrong type !\n";
        Zvec.setType(FLOAT_);
ans=query("see Zvec");
  }


   

//cout << "Zvec " << Zvec << endl;

    
   sWo(_WOID, gwo,_WCLEARPIXMAP,1,_WCLIPBORDER,BLACK_);
    
    //sWo(gwo,_line,0.1,0.1,3.0,2.0 ,RED_,_flush);

    //plot(gwo,_line,0.1,0.1,18.0,2 ,RED_);
    ff= f;
    lvec[3]= f;
   sWo(_WOID,gwo,_WLINE,lvec);
	
    sGl(_GLID,xn_gl,_GLDRAW,BLUE_);  // DrawGline; 
    
     sGl(_GLID,xs_gl,_GLDRAW, hue);  

  if ((kk % 100) == 0) {  
     if (++hue > 8) hue = 1;
  }
  
     sGl(_GLID,xz_gl,_GLDRAW, MAGENTA_);  


//ans=query("did DrawLINES");

    sWo(_WOID,gwo,_WSHOWPIXMAP,1,_WCLIPBORDER,ORANGE_);

//ans=query("see LINES");

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
    
    //getMouseClick()
//   ans=query("again? y");
//  if (ans == "n") {
//      break;
//    }
    if (kk++ > 2000)
       break;
   // xsleep(0.1);
}


   sWo(_WOID,gwo,_WAXNUM,2,_WAXNUM,1,_WSHOWPIXMAP,1);  
//ans=query("see window?");

/// create a window obj

//ans=query("did we see wob -CSV  button?");

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
    return 1;
  }
#endif  


//================================//


