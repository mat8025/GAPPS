//%*********************************************** 
//*  @script symbol.asl 
//* 
//*  @comment show symbols
//*  @release CARBON 
//*  @vers 1.14 Si Silicon                                                
//*  @date Wed Feb  6 14:53:24 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


#define _CPP_ 0

#if _CPP_
#include <iostream>
#include <ostream>

using namespace std;
#include "color.h"
#include "tagdefs.h"
#include "vargs.h"
#include "utils.h"
#include "vec.h"
#include  "textr.h"
//#include "uac.h"
#include "cppi.h"
#include "consts.h"
#define PXS  cout<<

// GRAPHICS
#include "gline.h"
#include "glargs.h"
#include "winargs.h"
#include "woargs.h"
#include "event.h"
#include "gevent.h"

#endif


Str Use_= "  test the symbols"

int Graphic = 0;
Str woname;

Str myvers ="1.10"


#include "tbqrd.asl"

#include "globals_symbol.asl"

#include "screen_symbol.asl"



#if _CPP_

int main( int argc, char *argv[] ) { // main start
        cpp_init();
init_debug ("symbol.dbg", 1, "1.1");

///
#endif               





 Gevent Gev ;

  Gev.pinfo();

  Textr tr 

 
   Str ins = "A very long piece of string can get tangled up really easily"

   tr.setTextr(ins, 0.2,0.3, txt_hue)


 if (!Graphic) {
    Xgm_pid = spawnGWM("Symbols")
<<"xgs pid ? $Xgm_pid \n"
  }

     int our_pid = getpid();
       printf("our pid %d\n",our_pid);

  Graphic = checkGWM()

<<"%V $Graphic \n"
    setScreen()
 

     tr.setTextr(ins, 0.2,0.3, txt_hue) ;
    
//tr.pinfo();

    <<" %V $ans \n"
    ins = "%V $symbol_num $symbol_name $ang  $sym_size"

  tr.setTextr(ins, 0.4, 0.5, RED_, 1, 0);
     
       ans = tr.getTxt();

 <<" %V $ans \n"
    tr.pinfo();



   while (Graphic) {

      Gev.eventWait();

      n_msg++
      evname = Gev.getEventName()
      etype = Gev.getEventType()
      ebutton = Gev.getEventButton()       

   <<"%V$evname $etype $ebutton\n";

       
   if ( etype == PRESS_   && ebutton != 2) {


       //sWo(_WOID, msgwo,_WCLEAR,ON_,_WTEXTR,_emsg,wpt(0.1,0.7))

         
     if (symbol_num > 20) {
         symbol_num = 0
     }
   
     if (symbol_num < 0) {
         symbol_num = 0;
     }

     if (ebutton == 3) {
        ang += 5;
        if (ang > 360) {
            ang = 0;
        }
     }
     else if (ebutton == 2) {
       symbol_num--
       //symbol_name = "diamond"
     }
     else if (ebutton == 4) {
       sym_size-- ;
     }
     else if (ebutton == 5) {
       sym_size++ ;
     }
     else if (ebutton == 1) {
       symbol_num++;
       if (sym_size > 99) {
           sym_size = 1;
       }

<<"%V $symbol_num\n"
  //     MFV= getMouseEvent()

//<<" %V $MFV \n"


       symbol_name = getSymbolName(symbol_num);  // need cpp vers
<<"%V $symbol_name\n"

      // titleMsg("$symbol_name");
     if (symbol_num > 20) {
         symbol_num = 1;
     }



     }
     
     for (k= 0; k < 360; k+= 45) {
     sWo(_WOID,rwo,_WDRAW,OFF_,_WCLEARPIXMAP,ON_,_WBORDER, MAGENTA_)
     sWo(_WOID,rwo,_WSYMBOL,symbol_num,_WSYMSIZE,sym_size,_WSYMANG,ang,_WREDRAW,ON_)
     sWo(_WOID,rwo,_WSHOWPIXMAP,ON_)

     sWo(_WOID,gwo,_WDRAW,OFF_,_WCLEARPIXMAP,ON_,_WBORDER,LILAC_)
     //sWo(_WOID,gwo,_WDRAW,ON_,_WCLEAR,ON_)
      sWo(_WOID,gwo,_WSYMBOL,symbol_num+1,_WSYMSIZE,sym_size,_WSYMANG,ang,_WREDRAW,ON_)
      sWo(_WOID,gwo,_WSHOWPIXMAP,ON_)
// TBF need TextR class
       ang += 45
       if (ang > 360) ang = 0

//<<" Setting textr obj with  %V $symbol_num $symbol_name $ang  $sym_size\n"

        // this needs to paramexpand
       // ans = "%V $symbol_num $symbol_name $ang  $sym_size"

      ans = vex(<<"%V  $symbol_num  $symbol_name  $ang  $sym_size") ;

 <<"vex  %V $ans \n"

    //ans = <<"%V $symbol_num $symbol_name $ang  $sym_size"


       tr.setTextr(ans, 0.05,0.3, txt_hue)
       ans = tr.getTxt();


 <<" %V $ans \n"
         tr.pinfo()
	 ans = tr.getTxt();


 <<" %V $ans \n"
        sWo(_WOID,msgwo,_WCLEARCLIP,PINK_,_WTEXTR, &tr)
	
	txt_hue++ 
	
	if (txt_hue > 16) txt_hue = 0


     }
     }
}


//exit_gs(0);
exit(0); 
#if _CPP_              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

 //==============\_(^-^)_/==================//