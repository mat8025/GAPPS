/* 
 *  @script test_xgs.asl  
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
void
Uac::xgsWorld(Svarg * sarg)  
{
   cout << "hello testing xgs ops " << endl;
#endif
float f= 88.0;
int i= 4;
printf("float f = %f\n",f);
char c;
char cv[32] = "hi char str";

 Str s = "hello Str";
cout << "s= " << s << endl;
#if ASL
<<"%V $s %s $cv\n";
#endif

/// launch xgs
#include "graphic.asl"


Str ans;

    rainbow();



  //  vp = cWi(@title,"PLOT_OBJECTS",@resize,0.05,0.01,0.99,0.95)
/// create a window
  int vp = cWi(0);
    //SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")
cout << "vp " << vp << endl;
     float x0= 0.1;
     float y0 =0.1;
     float x1 = 0.5;
     float y1 = 0.7;


     float rvec[4] = {0.1,0.1,0.5,0.6};
     int ws = 0; //which screen 0,7 -1 is current

//   int vok= sWi(vp,WRESIZE,0.1,0.2,0.5,0.5,-1,WHUE,YELLOW_,WPIXMAPDRAWON,WDRAWON,WREDRAW);

   int vok= sWi(vp,WTITLE,"PLOT_OBJECTS",WRESIZE,rvec,ws,WHUE,YELLOW,WBHUE,WHITE_,
                   WPIXMAPON,WDRAWON,WCLEAR,WREDRAW,EO);

cout << "vok " << vok << endl;



ans=query("see window?");


      vok =sWi(vp,WHUE,MAGENTA_,WREDRAW,EO);


ans=query("see window?");

/// create a window obj

      int wo1 = cWo(vp);

cout << "wo1 " << wo1 << endl;
      rvec[3] 0.7;
      int wok = sWo(wo1,WRESIZE,rvec,WHUE,YELLOW,WBHUE,WHITE_,WCLIPBORDER,RED,WDRAWON,WCLEAR,WREDRAW,EO);

///  draw some lines

ans=query("see wob?");
///






 exitXGS();

#if CPP
printf("str s = %s\n",s.cptr());
}
//==============================//

 extern "C" int test_xgs(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 
    //openDll("plot");
    o_uac->xgsWorld(sarg);

  }
#endif  


//================================//






