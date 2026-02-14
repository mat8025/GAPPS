/* 
 *  @script axnum.asl                                                         
 * 
 *  @comment Demo Axis number/label *     *                                   
 *  @release Carbon                                                           
 *  @vers 1.4 Be Beryllium [asl 6.67 : C Ho]                                  
 *  @date 02/13/2026 21:36:49                                                 
 *  @cdate 02/13/2026 08:35:12 *      *                                       
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
    sWi(_woid,txtw, _wresize,wbox(0.01,0.76,0.5,0.9,0))

    sWi(txtw,_wpixmap, OFF_,_wdraw, ON_,_wsave,ON_,_wbhue,WHITE_,_wsticky,OFF_)


    two=cWo(txtw,WO_TEXT_);
    sWo(_woid,two,_wname,"Text",_wvalue,"howdy",_wcolor,ORANGE_,_wresize,wbox(0.1,0.1,0.9,0.9,1))

    sWo(_woid,two,_wborder,BLACK_,_wdraw,ON_,_wpixmap,OFF_,_wredraw,ON_)

    sWo(_woid,two,_wscales,wbox(0,0,1,1,0),_wsavescales,0)

    //qwo=cWo(txtw,WO_BN_)
    //sWo(_woid,qwo,_wname,"QUIT?",_wvalue,"QUIT",_wcolor,TEAL_,_wresize,wbox(0.7,0.1,0.9,0.3,0))
    //sWo(_woid,qwo,_wredraw,ON_)


    vp = cWi("GRAPH_XY"),

    sWi(_woid,vp,_wresize,wbox(0.01,0.01,0.90,0.7,0),_wpixmap, ON_,_wdraw,ON_,_wbhue,WHITE_)

    sWi(_woid,vp,_wclip,wbox(0.1,0.1,0.9,0.9,0),_wbhue,PINK_,_wclipborder,BLACK_,_wredraw,ON_,_wsave,ON_)

    grwo=cWo(vp,WO_GRAPH_)
    sWo(_woid,grwo,_wname,"pic",_wtitle,"AXTESTS",_wcolor,YELLOW_,_wresize,wbox(0.1,0.1,0.9,0.8,1))
    sWo(_woid,grwo,_wborder,BLACK_,_wfonthue,RED_ ,_wdraw,ON_,_wpixmap,ON_)
    sWo(_woid,grwo,_wbhue,TEAL_,_wfhue,RED_,_wclipbhue,SKYBLUE_,_wclipfhue,BROWN_,_wfonthue,GREEN_)
    sWo(_woid,grwo,_wscales,wbox(-2,-2,2,2,0),_wsavescales,0,_wclip,wbox(0.3,0.2,0.6,0.9,0),_wcolor,LILAC_)

        sWo(_woid,grwo,_wscales,wbox(-4,-4,4,4,0),_wsavescales,1,_wclip,wbox(0.1,0.2,0.9,0.9,4),_wcolor,LILAC_)

    sWi(_woid,txtw,_wredraw,ON_)
    sWi(_woid,vp,_wredraw,ON_)
    Swo(_woid,grwo,_wredraw,ON_)

 titleButtonsQRD(vp);

//  now loop wait for message  and print


Svar msg


int kloop =0



xp = 0.8
yp = 0.5

dx = 0.2
dy = 0.2

xfoff = 3   // font offset relative to axis

yfoff = -5   //  string offset relative to y axis -- neg means inside clip

ang = 0.0;

   five_deg = Pi / 180.0 * 5;


   sWo(_woid,grwo,_wclear,SKYBLUE_,_wclearclip,TEAL_);

   axoff = 3;
   hue = 1;
   cx = 0.1
   while (1) {

      sWo(_woid,grwo,_wclip,wbox(cx,0.1,0.95,0.8,4),_wcolor,YELLOW_)
     eventWait()
   //  cx -= 0.05

     if (cx <= 0) {
         cx = 0.5
     }
     <<"%V$kloop  $emsg \n"
  //   sWi(_woid,vp,_wclear,ON_)


//   sWo(_woid,grwo,_wclearclip,ON_,_wredraw,ON_)
   sWo(_woid,grwo,_wclearclip,ON_)

  if (kloop < 1) {
   ans=ask("WTF",0)
  }
  
   xp = Sin(ang)
   yp = Cos(ang)

   ang += five_deg

   if ((kloop % 2) == 0 ) {
     <<"usescales 0\n"
     sWo(_woid,grwo,_wusescales, 0)
   }
   else {
     <<"usescales 1\n"
     sWo(_woid,grwo,_wusescales, 1)

   }

   sWo(_woid,grwo,_wclear, BROWN_)
   sWo(_woid,grwo,_wclearclip, hue)
   hue++
   if (hue > 8) {
     hue = 1
   }
   sWo(_woid,grwo,_wline,wbox(0,0,xp,yp,4))

   sWo(_woid,grwo,_wline,wbox(0,0,yp,xp,3))

   RP = wogetrscales(grwo)

if ((kloop % 2) == 0 ) {
  dy=  dx =0.2
  // rx = RP[5];
  // ry = RP[6]
  // rX = RP[7]
  // rY = RP[8]
}
else {
 dy = dx = 0.4
  // rx = RP[9];
  // ry = RP[10]
  // rX = RP[11]
  // rY = RP[12]
}

   rx = RP[1];
   ry = RP[2]
   rX = RP[3]
   rY = RP[4]
   
   <<"$kloop scales are $rx $ry $rX $rY\n"
   //sWo(grwo,_wscales,wbox(rx,ry,rX,rY,0),_wsavescales,0)

  // sWo(grwo,_wfonthue,BLACK_,_wfont,"small");

  // axnum(grwo,1)
  // axnum(grwo,-1)
   // axis # 1-4 use current
   //  axis # 5-8 use scales 1
   //axnum(grwo,1,rx,rX,dx, xfoff, "4.2f")
      axnum(grwo,1)

   axnum(grwo,3,rx,rX,dx, -xfoff, "4.2f")
//   axnum(grwo,3)

   axnum(grwo,2,ry,rY,dx, axoff, "4.2f")
  // axnum(grwo,2,ry,rY,dy, yfoff, "4.2f")   
 //  axnum(grwo,2)
   axnum(grwo,2,ry,rY,dx, -axoff, "4.2f")
   axnum(grwo,4,ry,rY,dy, yfoff, "4.2f")

 //  sWo(_woid,grwo,_wfonthue,GREEN_) 
   dx = (rX-rx)  /10.0
   dy = (rY-ry)  /10.0
   
   axnum(grwo,1)
   //axnum(grwo,1,rx,rX,dx, xfoff, "4.2f")

   //axnum(grwo,2,ry,rY,dy, -8, "4.2f")

   axnum(grwo,3,rx,rX,dx, -xfoff, "4.2f")
  //   axnum(grwo,3)

   axnum(grwo,4,ry,rY,dy, -yfoff, "4.2f")

    sWo(_woid,grwo,_wfont,"medium");

    Axlabel(grwo,1,x_label,0.5,2,BLACK_,2)

//    Axlabel(grwo,2,y_label,0.6,2,BLACK_,1,90)
   sWi(_woid,txtw,_wclear,ON_)
   sWo(_woid,two,_wclear,WHITE_,_wclearclip,PINK_,_wredraw,ON_)
   
   <<"$emsg $rx $ry $rX $rY $dx $dy $ang \n"

   plotText(two,"$emsg $rx $ry $rX $rY $dx $dy $ang ",0.1,0.8)

   plotText(two,"%V %6.2f$xp $yp  ",0.02,0.5)

  kloop++
  
  }


 exit_gs()


///

  chkOut(1);
 exit()


#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
