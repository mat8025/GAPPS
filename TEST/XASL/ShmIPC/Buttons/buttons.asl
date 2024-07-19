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
 
   
  Gevent Gev ; 
 
  Gev.pinfo(); 
 
  setScreen() 
 
 
// our Gevent variable - holds last message 
                            // could use another or an array to compare events 
 
//sWi( allwins ,_wredraw,ON_) 
int b 
 
   int fhue =1; 
   int bhue = 3; 
 
   while (Graphic) { 
 
      Gev.eventWait(); 
 
   // <<"%V $GEV__name $GEV__button $GEV__keyw $GEV__woname $GEV__keyc \n" 
 
   
  
/* 
      if (GEV__ekeyw= "EXIT_ON_WIN_INTRP") { 
<<"have win interup -- exiting!\n" 
      break; 
      } 
*/ 
    //  sWo(_woid,two,_wtexthue,BLACK_,_wclear,ON_) 
 
      
 
      b= Gev.getEventButton(); 
      
      woname = Gev.getEventName(); 
     // Textr(two, "$b ",-0.9,0.5);  // TBF no cpp 
 
     //  Textr(two, " $woname $b ",-0.9,0); 
 
 
     // processKeys(Gev.getEventKey()) 
      sWo(_woid,lwo,_wborder, bhue+1,_wfhue,fhue,_wclipbhue,bhue,_wredraw,ON_) 
 
      fhue += 1 
      bhue +=2 
      if (fhue > 30)  fhue = 1 
       
      if (bhue > 30) 
          bhue = 1 
       
/* 
     if (GEV__name == "PRESS") { 
 
       <<"trying $GEV__woname $GEV__button \n" 
 
          rcb=runproc(GEV__woname,GEV__button) 
     } 
*/  
 
 } 
 
 
 
 
 exitGS(); 
// <<"kill xgs now exit!\n"; 
 exit(0); 
  
#if _CPP_               
  ////////////////////////////////// 
  exit(-1); 
 }  /// end of C++ main    
#endif                
 
  
 
 
 
 
 
 
////////////////////   TBD -- FIX ////////////////////// 
