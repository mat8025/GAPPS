
/* 
 *  @script grid.asl                                                    
 * 
 *  @comment Demo of grid operations                                    
 *  @release 6.68 : C Er                                                
 *  @vers 1.1 H Hydrogen [asl 6.68 : C Er]                              
 *  @date 03/08/2026 18:34:44                                           
 *  @cdate 03/08/2026 18:34:44                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2026 -->                               
 * 
 */ 

#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo of grid operations ";

 Svar argv = _argv;  // allows asl and cpp to refer to clargs
 argc = argc();


#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); // set number of errors allowed -1 keep going 

#endif       

// CPP main statement goes after all procs
#if __CPP__
#include <iostream>
#include <ostream>
using namespace std;
#include "vargs.h"
#include "cpp_head.h"
#define PXS  cout<<

#define CPP_DB 0

  int main( int argc, char *argv[] ) {  
    init_cpp(argv[0]) ; 

#endif       


  chkIn(1) ;

  chkT(1);

 




//////// grid.asl ////////////////////
#include "wevent.asl"
#include "tbqrd.asl"


 Graphic = CheckGwm()

<<" %v $Graphic \n"
spawn_it = 1
 if (Graphic) {
   spawn_it = 0;
 }

<<" %v $spawn_it \n"

     if (spawn_it) {
       X=spawngwm()
       spawn_it  = 0;
     }

    vp = cWi("Button")

<<"%V $vp \n"

    sWi(_woid,vp,_wpixmap,ON_,_wdraw,ON_,_wsave,ON_,_wbhue,RED_,_wresize,wbox(0.1,0.1,0.9,0.9,WFRACT_),_wgridhue, INDIGO_,_wcolor,TURQUOISE_)
    
    sWi(_woid,vp,_wsetgrid,tuple(12,12),_wclear,GREEN_,_wsavepixmap,ON_)

    sWi(_woid,vp,_wclip,wbox(3,2,10,10,WGRID_),_wclipborder,YELLOW_,_wclipfhue,BLUE_,_wclipbhue,PINK_,_wredraw,ON_)


    titleButtonsQRD(vp);




 ans=ask("see clip using grid?",1)
    if (ans == "n") {
    exitgs();
    exit(-1);
   }

  sWi(_woid,vp,_wclearclip,BROWN_,_wflush,ON_)  ; // not happening


 ans=ask("see it?",1)
    if (ans == "n") {
    exitgs();
    exit(-1);
   }

//////// Wob //////////////////

 bx = 0.1
 bX = 0.3
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht


 gwo= cWo(vp,WO_BV_)

<<"%V $gwo \n"



 sWo(_woid,gwo,_woname,"B_V",_wocolor,GREEN,_woresize,wbox(0,0,2,2,WGRID_))

 sWo(_woid,gwo,_woborder,ON_,_wodraw,ON_,_woclipborder,INDIGO_,_woFONTHUE,RED_,_wovalue,"ON",_woSTYLE,SVB_,_woFUNC,"ringBell")


 sWo(_woid,gwo,_woclearclip,LILAC_,_wosetgrid,tuple(10,10), _woattr ,tuple(WOA_GRID_,ON_),_woredraw,ON_)

 ans=ask("see it?",1)
    if (ans == "n") {
    exitgs();
    exit(-1);
   }

 bx = 0.4
 bX = 0.7

 hwo=cWo(vp,WO_BV_)

// WGRID_ means use  grid specs to position
 sWo(_woid,hwo,_wname,"Hello",_wcolor,RED_,_woresize,wbox(0,9,2,11,WGRID_))

// FIXME ip_wo_value crashes

 sWo(_woid,hwo,_wborder,ON_,_wdraw,ON_,_wclipborder,BLACK_,_wfonthue,GREEN_,_wvalue,"Red",_wstyle,SVB_,_wfunc,"cycleHue",_wredraw,ON_)

 ans=ask("see it?",1)
    if (ans == "n") {
    exitgs();
    exit(-1);
   }


 bx = 0.8
 bX = 0.9

 qwo=cWo(vp,WO_BV_)
 
 sWo(_woid,qwo,_wname,"QUIT",_wcolor,BLUE,_woresize,wbox(10,9,12 ,11,WGRID_))

 sWo(_woid,qwo,_wBORDER,RED_,_wDRAW,ON_,_wCLIPBORDER,BROWN_,_wFONTHUE,BLACK,_wVALUE,"ON",_wSTYLE,SVB_,_wredraw,ON_)


 bwo=cWo(vp,WO_BV_)
 
 sWo(_woid,bwo,_wname,"BELL",_wcolor,BLUE,_woresize,wbox(9,0,12 ,3,WOGRID_),_woFUNC,"ringBell")

 sWo(_woid,bwo,_wBORDER,RED_,_wDRAW,ON_,_wCLIPBORDER,BROWN_,_wFONTHUE,BLACK,_wVALUE,"ON",_wSTYLE,SVB_,_wredraw,ON_)



 mwo=cWo(vp,WO_BV_)
 
 sWo(_woid,mwo,_wname,"MID",_wcolor,GREEN_,_woresize,wbox(4.5,4,7.5 ,7,WOGRID_),_woFUNC,"ringBell")

 sWo(_woid,mwo,_wBORDER,RED_,_wDRAW,ON_,_wCLIPBORDER,BROWN_,_wFONTHUE,BLACK,_wVALUE,"ON",_wSTYLE,SVB_,_wredraw,ON_)




  
xp = 0.1
yp = 0.5

   while (1) {

     eventWait()


     sWo(_woid,hwo,_wredraw,ON_)

  if (scmp(ewoname_,"QUIT",4)) {
      <<" saw QUIT\n"
  }

  }

 exit_gs()



///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
