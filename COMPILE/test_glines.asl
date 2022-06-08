/* 
 *  @script test_glines.asl 
 * 
 *  @comment test cpp interface to xgs directives 
 *  @release CARBON
 *  @vers 1.4 Be 6.4.10 C-Be-Ne 
 *  @date 04/21/2022 13:34:50          
 *  @cdate 01/16/2022 10:43:41
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;



#define ASL 1
#define CPP 0

#if ASL
// the include  when cpp compiling will re-define ASL 0 and CPP 1
#include "/home/mark/gasp-CARBON/include/compile.h"
#endif



#if ASL
<<"ASL   $(ASL) CPP $(CPP)\n"
#endif


#if ASL
#define COUT //
#endif
//#define cdbp //

 int run_asl = runASL();

#if CPP

 //opendll("plot");
#include "vec.h"
#include "gevent.h"




void
Uac::glineWorld(Svarg * sarg)  
{
 cout <<"CPP   \n";

 cout <<"CPP  ASL?  " << run_asl << endl;

 cout << "hello testing gline ops " << endl;


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

ans.strPrintf("run_asl %d",run_asl);
COUT(ans);

//Str prompt = "ASL/CPP?";
//ans=query(prompt,ans);



if (ans == "q") {
    exit(-1);
}


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

//   int vok= sWi(vp,WRESIZE,0.1,0.2,0.5,0.5,-1,WHUE,YELLOW_,WPIXMAPDRAWON,WDRAWON,WREDRAW);

  int vok= sWi(vp,_WTITLE,"PLOT_OBJECTS",_WRESIZE,rsz,_WHUE,YELLOW_,_WBHUE,WHITE_, _WPIXMAPON,_WDRAWON,_WCLEAR,_WREDRAW,_WEO);

//cout << "vok " << vok << endl;
//ans=query("see window?");

      rsz[3] = 0.8;
      vok =sWi(vp,_WHUE,MAGENTA_,_WRESIZE,rsz,_WREDRAW,_WEO);


  int gwo= cWo(vp,WO_GRAPH_);
  float worsz[6] = {0.1,0.1,0.9,0.9,0.0};
  
  sWo(gwo,_WRESIZE,worsz,_WFLUSH);


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
  sWo(gwo,_WSAVE,_WREDRAW,_WDRAWOFF,_WPIXMAPON,_WCLIPBHUE,GREEN_,_WFLUSH);
  sWo(gwo,_WSCALES,vscale,_WFLUSH);
  sWo(gwo,_WSAVEPIXMAP,_WFLUSH);
    sWo(gwo,_WAXNUM,2,_WFLUSH);
   sWo(gwo,_WAXNUM,1,_WFLUSH);
  


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

//   ans=query("see Rnvec?");
  
  
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

COUT(xn_gl)

//ans=query("see xn_gl?");
 Xvec.pinfo();
 Rnvec.pinfo();
 
// make these ref args?
  sGl(xn_gl,_GLTXY,&Xvec,&Rnvec,_GLHUE,RED_,_GLEO);

//ans=query("set xn_gl");

  int xs_gl = cGl(gwo);

  COUT(Xvec);
  COUT(Svec);

  sGl(xs_gl,_GLTXY,&Xvec,&Svec,_GLHUE,BLUE_,_GLEO);




//ans=query("set xs_gl");
  int xz_gl = cGl(gwo);

  sGl(xz_gl,_GLTXY,&Xvec,&Zvec,_GLHUE,YELLOW_,_GLEO);

//ans=query("see xz_gl");

//  sWo(gwo,_WHUE,GREEN_,_WREFRESH,_WFLUSH);
  
  sWo(gwo,_WSHOWPIXMAP,_WFLUSH);
  
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
  
  
  sGl(xn_gl,_GLHUE,RED_,_GLEO);
  
   sWo(gwo,_WCLEARPIXMAP,_WCLIPBORDER,_WFLUSH);
// ans=query("listo?:");
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
ans=query("check vecs");
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
    
    Zvec = Rnvec + (Cvec * 0.5);
   // Zvec = Rnvec + Tvec;

    if (Zvec.getType() != FLOAT_) {
cout<<"Zvec wrong type !\n";
        Zvec.setType(FLOAT_);
ans=query("see Zvec");
  }


   

//cout << "Zvec " << Zvec << endl;

    
   sWo(gwo,_WCLEARPIXMAP,_WCLIPBORDER,BLACK_,_WFLUSH);
    
    //sWo(gwo,_line,0.1,0.1,3.0,2.0 ,RED_,_flush);

    //plot(gwo,_line,0.1,0.1,18.0,2 ,RED_);
    ff= f;
    lvec[3]= f;
   sWo(gwo,_WLINE,lvec,_WFLUSH);
	
    sGl(xn_gl,_GLDRAW);  // DrawGline; 
    
    sGl(xs_gl,_GLDRAW);  
    
    sGl(xz_gl,_GLDRAW);  

//ans=query("did DrawLINES");

    sWo(gwo,_WSHOWPIXMAP,_WCLIPBORDER,ORANGE_,_WFLUSH);

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
    if (kk++ > 1000)
       break;
   // xsleep(0.1);
}


   sWo(gwo,_WAXNUM,2,_WFLUSH);
   sWo(gwo,_WAXNUM,1,_WFLUSH);
   sWo(gwo,_WSHOWPIXMAP,_WFLUSH);  
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

  }
#endif  


//================================//


