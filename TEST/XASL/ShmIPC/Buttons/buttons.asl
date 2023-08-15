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



Str Use_= "  test the buttons";

#define _CPP_ 0

#if _CPP_
#include <iostream>
#include <ostream>

using namespace std;
#include "vargs.h"
#include "cpp_head.h" 
#include "consts.h"
#define PXS  cout<<
#endif


Graphic = checkGWM()

#if _ASL_
  if (!Graphic) {
    Xgm_pid = spawnGWM()
<<"xgs pid ? $Xgm_pid \n"
  }
  Graphic = checkGWM()
#endif


#include "tbqrd.asl"

#include "screen_buttons.asl"




void processKeys()
{

int key

      key = Gev.getEventKey()
      
<<" key $key \n"

       switch (key) {

       case 'R':
       {
       sWo(_WOID,symwo,_WMOVE,wpt(0,2),_WREDRAW)
       sWo(_WOID,two,_WTEXTR,"R RMOVE 2 ",0.1,0.2)
       }
       break;

       case 'T':
       {
       sWo(_WOID,symwo,_WMOVE,wpt(0,-2),_WREDRAW)
       sWo(_WOID,two,_WTEXTR,"T RMOVE -2 ",0.1,0.2)
       }
       break;

       case 'Q':
       {
       sWo(_WOID,symwo,_WMOVE,wpt(-2,0),_WREDRAW)
       sWo(_WOID,two,_WTEXTR,"Q RMOVE -2 ",0.1,0.2)
       }
       break;

       case 'S':
       {
       sWo(_WOID,symwo,_WMOVE,wpt(2,0,)_WREDRAW)
       sWo(_WOID,two,_WTEXTR,"S RMOVE 2 ",0.1,0.2)
       }
       break;

       case 'h':
       {
       sWo(_WOID,symwo,_WHIDE,ON_)
       setgwindow(vp2,_WREDRAW)
       }
       break;

       case 's':
       {
       sWo(_WOID,symwo,_WSHOW,ON_)
       setgwindow(vp2,_WREDRAW)
       }
       break;

      }
}
//---------------------------------------------------------------------



void do_sketch()
{
   sWo(_WOID,bsketchwo,_WCLEAR,ON_,_WPLOTLINE,wbox(0.1,0.1,0.8,yp,RED_))
   sWo(_WOID,bsketchwo,_WPLOTLINE,wbox(0.1,yp,0.8,0.1,BLUE_))
   axnum(bsketchwo,1)
   axnum(bsketchwo,2)

   sWo(_WOID,grwo,_WCLEARCLIP,ON_,_WCLIPBORDER,ON_,_WPLOTLINE,wbox(xp,0.1,0.5,0.5,GREEN_))
   sWo(_WOID,grwo,_WPLOTLINE,wbox(xp,0.5,0.5,0.1,BLACK_))

   xp += 0.05
   yp += 0.05

   zp = xp + yp

   if (xp > 0.7) { 
       xp = 0.1
   }

   if (yp > 0.9) {
      yp = 0.1
   }
 } 
//-------------------------------------------------------

int FRUIT(int val)
{

  <<"want a fruit? $val\n"

}


int BOATS(int val)
{
  if (val == 1)   <<"want to sail a boat? $val\n"

   if (val == 3)   <<"want to buy a boat? $val\n"

}





int  QUIT(int val)
{
 //exitgs();
 <<"$val kill xgs now exit!\n";
  exit(-1)

}

void tb_q()
{
<<"expecting sig1 signal\n";
}


#if _CPP_

int main( int argc, char *argv[] ) { // main start
///
#endif               


    rsig=checkTerm();
    <<"%V$rsig \n";


////////////////////////////////////


// TBF Gev; name instead of Gev  Gevent Gev; // event type - can inspect for all event attributes

  Gevent Gev

  Gev.pinfo();


//#include "gevent.asl"
// our Gevent variable - holds last message
                            // could use another or an array to compare events

//sWi( allwins ,_WREDRAW,ON_)

   while (Graphic) {

      Gev.eventWait();

   // <<"%V $GEV__name $GEV__button $GEV__keyw $GEV__woname $GEV__keyc \n"

  

/*
      if (GEV__ekeyw= "EXIT_ON_WIN_INTRP") {
<<"have win interup -- exiting!\n"
      break;
      }
*/
      sWo(_WOID,two,_WTEXTHUE,BLACK_,_WCLEAR,ON_)

     

      b= Gev.getEventButton();
     
      woname = Gev.getEventName();
      Textr(two, "$b ",-0.9,0.5);

       Textr(two, " $woname $b ",-0.9,0);


      processKeys()


/*
     if (GEV__name == "PRESS") {

       <<"trying $GEV__woname $GEV__button \n"

          rcb=runproc(GEV__woname,GEV__button)
     }
*/ 

 }




// exitgs();
// <<"kill xgs now exit!\n";
 exit(0);
 
#if _CPP_              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

 






////////////////////   TBD -- FIX //////////////////////
