/* 
 *  @script axnum.asl                                                         
 * 
 *  @comment Demo Axis number/label      *                                    
 *  @release Carbon                                                           
 *  @vers 1.3 Li Lithium [asl 6.67 : C Ho]                                    
 *  @date 02/13/2026 11:09:40                                                 
 *  @cdate 02/13/2026 08:35:12       *                                        
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2026 -->                                     
 * 
 */ 


#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of Demo Axis number/label ";

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

 


//////// axnum.asl ////////////////////


#include "wevent.asl" 
#include "tbqrd.asl"

 
Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


// need some labels --- and font manipulation

float  Pi = 4.0 * atan(1.0);
<<"%V $Pi\n"

 x_label = "Freq (Khz)"
 y_label = "Magnitude"

    txtw = cWi("MC_INFO")
    sWi(_woid,txtw, _wresize,wbox(0.01,0.76,0.75,0.99,0))

    sWi(txtw,_wpixmap, OFF_,_wdraw, ON_,_wsave,ON_,_wbhue,WHITE_,_wsticky,OFF_)


    two=cWo(txtw,WO_TEXT_);
    sWo(_woid,two,_wname,"Text",_wvalue,"howdy",_wcolor,ORANGE_,_wresize,wbox(0.1,0.1,0.9,0.9,1))

    sWo(_woid,two,_wborder,BLACK_,_wdraw,ON_,_wpixmap,OFF_,_wredraw,ON_)

    sWo(_woid,two,_wscales,wbox(0,0,1,1,0),_wsavescales,0)

    //qwo=cWo(txtw,WO_BN_)
    //sWo(_woid,qwo,_wname,"QUIT?",_wvalue,"QUIT",_wcolor,TEAL_,_wresize,wbox(0.7,0.1,0.9,0.3,0))
    //sWo(_woid,qwo,_wredraw,ON_)


    vp = cWi("GRAPH_XY"),

    sWi(_woid,vp,_wresize,wbox(0.01,0.01,0.9,0.9,0),_wpixmap, ON_,_wdraw,ON_,_wbhue,WHITE_)

    sWi(_woid,vp,_wclip,wbox(0.2,0.2,0.9,0.9,0),_wbhue,PINK_,_wclipborder,BLACK_,_wredraw,ON_,_wsae,ON_)

    grwo=cWo(vp,WO_GRAPH_)
    sWo(_woid,grwo,_wname,"pic",_wcolor,YELLOW_,_wresize,wbox(0.1,0.1,0.9,0.9,1))
    sWo(_woid,grwo,_wborder,BLACK_,_wfonthue,RED_ )
    sWo(_woid,grwo,_wbhue,TEAL_,_wfhue,RED_,_wclipbhue,SKYBLUE_,_wclipfhue,BROWN_,_wfonthue,GREEN_)
    sWo(_woid,grwo,_wscales,wbox(-2,-2,2,2,0),_wsavescales,0,_wclip,wbox(0.2,0.2,0.9,0.9))

    sWi(_woid,txtw,_wredraw,ON_)
    sWi(_woid,vp,_wredraw,ON_)

 titleButtonsQRD(vp);

//  now loop wait for message  and print


Svar msg


int kloop =0



xp = 0.8
yp = 0.5

dx = 0.2
dy = 0.2

xfoff = 1.0   // font offset relative to axis

yfoff = -3.0   //  string offset relative to y axis -- neg means inside clip

ang = 0.0;

   five_deg = Pi / 180.0 * 5;


   sWo(_woid,grwo,_wclear,SKYBLUE_,_wclearclip,TEAL_);


   while (1) {

     
     eventWait()

     <<"%V$kloop  $emsg \n"
  //   sWi(_woid,vp,_wclear,ON_)


//   sWo(_woid,grwo,_wclearclip,ON_,_wredraw,ON_)
   sWo(_woid,grwo,_wclearclip,PINK_)

   xp = Sin(ang)
   yp = Cos(ang)

   ang += five_deg



   sWo(_woid,grwo,_wline,wbox(0,0,xp,yp,4))

      sWo(_woid,grwo,_wline,wbox(0,0,yp,xp,3))

   RP = wogetrscales(grwo)

   rx = RP[1];
   rZ = RP[3]
   rX = RP[3]
   ry = RP[2]
   rY = RP[4]

   sWo(grwo,_wfonthue,BLACK_,_wfont,"small");

   axnum(grwo,1)
   axnum(grwo,-1)

   axnum(grwo,3,rx,rX,dx, xfoff, "g")

   axnum(grwo,2,ry,rY,dy, yfoff, "g")

   axnum(grwo,4,ry,rY,dy, yfoff, "g")

   sWo(_woid,grwo,_wfonthue,GREEN_) 

   axnum(grwo,3,rx,rX,dx, -xfoff, "g")

   axnum(grwo,2,ry,rY,dy, -yfoff, "g")

   axnum(grwo,4,ry,rY,dy, -yfoff, "g")

    sWo(_woid,grwo,_wfont,"medium");

    Axlabel(grwo,1,x_label,0.5,2,BLACK_,2)

    Axlabel(grwo,2,y_label,0.6,2,BLACK_,1,90)
   sWi(_woid,txtw,_wclear,ON_)
   sWo(_woid,two,_wclear,WHITE_,_wclearclip,PINK_,_wredraw,ON_)
   
   <<"$emsg $rx $ry $rX $rY $dx $dy $ang \n"

   plotText(two,"$emsg $rx $ry $rX $rY $dx $dy $ang ",0.1,0.8)

   plotText(two,"%V %6.2f$xp $yp  ",0.02,0.5)

  }


 exit_gs()


///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
