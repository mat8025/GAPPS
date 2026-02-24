/*  
 *  @script buttons.asl  
 *  
 *  @comment test buttons  
 *  @release CARBON buttons  
 *  @vers 1.15 P 6.3.90 C-Li-Th  
 *  @date 03/01/2022 11:01:10           
 *  @cdate 1/1/2001 Feb 6 14:53:24 2019  
 *  @author Mark Terry 6 14:53:24 2019  
 *  @Copyright © RootMeanSquare 2022 
 *  
 */  
//----------------<v_&_v>-------------------------//;                                                    
 
 
 
 
 
#define _CPP_ 0 
 
#if _CPP_ 
#include <iostream> 
#include <ostream> 
 
using namespace std; 
#include "vargs.h" 
#include "utils.h" 
#include "vec.h" 
//#include "uac.h" 
#include "cppi.h" 
#include "consts.h" 
#define PXS  cout<< 
 
// GRAPHICS 
#include "gline.h" 
#include "glargs.h" 
#include "winargs.h" 
#include "woargs.h" 
#include "gevent.h" 
#include "event.h" 
 
 
 
 
#endif 
 
Str Use_= "  test the buttons"; 
 
//Graphic = checkGWM() 
 
 
int Graphic = 0; 
Str woname; 
 
 
 
#include "tbqrd.asl" 
 
#include "screen_buttons.asl" 
 
 
 
 
   
 
 
#if _CPP_ 
 
int main( int argc, char *argv[] ) { // main start 
        cpp_init(); 
init_debug ("cpp_debug.txt", 1, "1.7"); 
 
/// 
#endif                
 
 
  if (!Graphic) { 
    Xgm_pid = spawnGWM("Buttons") 
<<"xgs pid ? $Xgm_pid \n" 
  } 
 
       int our_pid = getpid(); 
       printf("our pid %d\n",our_pid); 
 
  Graphic = checkGWM() 
 
<<"%V $Graphic \n" 
 
 
//    rsig=checkTerm();   // TBF 
//    <<"%V$rsig \n"; 
 
 
//////////////////////////////////// 
 
 
// TBF Gev; name instead of Gev  Gevent Gev; // event type - can inspect for all event attributes 
 
#include "wevent.asl"

  //Gevent Gev ; 
 
  //Gev.pinfo(); 
 
  setScreen() 
 
 
// our Gevent variable - holds last message 
                       // could use another or an array to compare events 
 
//sWi( allwins ,_wredraw,ON_) 
int b 
 
   int fhue =1; 
   int bhue = 3;


  // sdb(1,"step")
   typos = -0.9;
   txpos = -0.9;
   while (Graphic) { 
 
      eventWait(1); 

     //eventRead()

//sleep(3)

   // <<"%V $GEV__name $GEV__button $GEV__keyw $GEV__woname $GEV__keyc \n" 
 
   
  

     sWo(_woid,two,_wtexthue,BLACK_,_wclear,ON_,_wclearclip,WHITE_) 
      // this should be @ rx,ry according to scales
      Textr(two, "%6.2f$txpos $typos %V $bhue $ewoname_  ",txpos,typos, bhue,0,0);         
  typos += 0.05;       txpos += 0.05;     
      if (typos > 0.95)
          typos = -0.9;

      if (txpos > 0.95)
          txpos = -0.9;

  
      b= ebutton_; 
      if ((bhue % 2) == 0) {
      //sWi(_woid,txtwin,_wdraw,ON_,_wbhue,PINK_,_wclearclip,ON_,_wredraw,ON_)
      <<"PINK \n"
      }
       else {
       
    //sWi(_woid,txtwin,_wdraw,ON_,_wbhue,bhue,_wclearclip,ON_,_wredraw,ON_)
      <<"LILAC \n"
     }
       
      //sWo(_woid,two,_wdraw,ON_,_wclipbhue,bhue,_wclearclip,ON_,_wupdate,ON_)
      
     // Textr(two, "$b ",-0.9,0.5);  // TBF no cpp 
     <<"%V $ewoname_ $b "
 
 
     // processKeys(Gev.getEventKey()) 
     // sWo(_woid,lwo,_wborder, bhue+1,_wfhue,fhue,_wclipbhue,bhue,_wredraw,ON_) 

      fhue += 1 
      bhue += 1

<<"%V $fhue $bhue \n"
 ans=ask("$bue ",0)

      if (fhue > 7)  {
        fhue = 1 
       }
       
     if (bhue > 12) {
          bhue = 1
     }
	  
 } 
 
 
 
 
 exitGS(); 
// <<"kill xgs now exit!\n"; 
 exit(0); 
  
#if _CPP_               
  ////////////////////////////////// 
  exit(-1); 
 }  /// end of C++ main    
#endif                
 
/* 
      if (GEV__ekeyw= "EXIT_ON_WIN_INTRP") { 
<<"have win interup -- exiting!\n" 
      break; 
      } 
*/   


/* 
     if (GEV__name == "PRESS") { 
 
       <<"trying $GEV__woname $GEV__button \n" 
 
          rcb=runproc(GEV__woname,GEV__button) 
     } 
*/    
 
 
 
 
 
 
////////////////////   TBD -- FIX ////////////////////// 
