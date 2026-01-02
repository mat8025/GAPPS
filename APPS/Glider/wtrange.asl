
/* 
 *  @script wtrange.asl                                                 
 * 
 *  @comment                                                            
 *  @release 6.61 : C Pm                                                
 *  @vers 1.1 H Hydrogen [asl 6.61 : C Pm]                              
 *  @date 12/14/2025 18:25:14                                           
 *  @cdate 12/14/2025 18:25:14                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2025 -->                               
 * 
 */

///   

 argc = argc();
  arg1= _clarg[1]
<<"%V $argc $arg1\n"

   float current_wt_lbs = _argv[1]
   <<"%V $current_wt_lbs \n"

#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of  ";

// Svar argv = _argv;  // allows asl and cpp to refer to clargs

<<" [0] $_argv[0] [1] $_argv[1] [2] $_argv[2] \n"

 argc = argc();

   <<"%V $arg1 \n"
<<" we are in ASL mode $argc and arg1 is $arg1\n"
//<<" $argv[0] $argv[1] $argv[2] \n"
 //wat = ask("using $current_wt_lbs for current weight OK?",1)
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

<<" doing CPP \n"
  int main( int argc, char *argv[] ) {  
    init_cpp(argv[0]) ; 

#endif       


  chkIn(1) ;

  chkT(1);


    float default_wt_lbs = 195.0
   <<"%V $default_wt_lbs\n"
   


//   wtrange  for my glider wings
//
///  What is my max and min weight for my PG wings ?
///  Magic versa 27
///  Hook 3 25
///  Advance Theta ULS 25



   #include "consts.asl"
// a comment

/{
  some comments
  more comments
/}

 
//   sdb(1, "step")  ; // step thru code ?
   thin_lbs = 175.0
   fat_lbs  = 195.0



   helmet = 0.4  ; /* check /
   adv_harness = 2.15
   magicw = 5.2
   hook3w = 5.3
   thetaw = 3.55
   
   <<" thin $thin_lbs  fat $fat_lbs \n" 
   
   thin = thin_lbs/2.2
   fat = fat_lbs/2.2
   current_wt = current_wt_lbs/2.2

   mhw = magicw +adv_harness + helmet ; // harness + wing +helmet
   
   // thw = 23.0 /2.2 ; // harness + wing

   thwt = thetaw + adv_harness + helmet // harness + wing + helmet
   <<" advance easiness + theta 25 wing $thw kg \n"
   hookwt =  hook3w + adv_harness + helmet // harness + wing + helmet

   <<" clothes+shoes + waterbottle $d kg\n"
   cse_lbs = 8.0; // lets measure full kit
   kit = cse_lbs/2.2
   
   c1 = 175 * lb2kg_
   d1= 5.70 * kg2lb_
   
   mcw = fat + mhw + kit
   mtw = thin + mhw + kit
   magic_cw =  current_wt + mhw + kit
   <<" MAGIC VIRGO \n"
   <<"my range with magic wing $mtw --> $mcw ideal (88 - 108) kg \n"
   <<"my range with magic wing $(mtw *kg2lb_) --> $(mcw  *kg2lb_) lbs \n"

     best_magic_wt_lbs = 100*2.2 - mhw*2.2 - kit*2.2
 <<" my best weight - bathroom for magic is $best_magic_wt_lbs !   \n"

    max_magic_wt_lbs = 108*2.2 - mhw*2.2 -kit*2.2 
   <<" my max weight - bathroom for magic is $max_magic_wt_lbs !   \n"

    if (max_magic_wt_lbs < current_wt_lbs) {
     <<"\ntoo fat for magic wing!! diet!\n"
    }

   <<"\n HOOK 3 25 \n"

   hook_cw = current_wt + hookwt  + kit

   hook_tw = thin + hookwt + kit

   hook_minw = 80 ; //kg
   hook_maxw = 100 ; 
   
   <<"\tmy range  with hook3 wing $(hook_tw * kg2lb_) --> $(hook_cw * kg2lb_) $(80 *2.2) $(100 *2.2) lbs \n"
   <<"\tmy range  with hook3 wing $hook_tw  --> $hook_cw  (80-100) kg  \n"

     best_hook3_wt_lbs = 95*2.2 - hookwt*2.2 - kit*2.2
 <<"\tmy best weight - bathroom for hook3 25 is $best_hook3_wt_lbs !   \n"
    max_hook3_wt_lbs = 100*2.2 - hookwt*2.2 -kit*2.2 
   <<"\tmy max weight - bathroom for hook3 25 is $max_hook3_wt_lbs !   \n"
    hook_hue = GREEN_;
    dw = (current_wt_lbs -best_hook3_wt_lbs)
    if ( dw > 0) {
          hook_hue = ORANGE_;
     <<"\t\t\tSlim down $dw - for hook wing!! \n"
    }
    if (max_hook3_wt_lbs < current_wt_lbs) {
     <<"\t\tAlas too fat for hook wing!! diet!!!!\n"
     hook_hue = RED_;
    }


   <<"\n THETA ULS 25 \n"

   theta_cw = current_wt + thwt + kit
   
   theta_tw = thin + thwt + kit

   theta_minw = 82 ; // kg
   theta_maxw = 95 ; 
   theta_hue = GREEN_;

   <<"\tmy range with theta uls wing $theta_tw --> $theta_cw ideal (82 - 95,max 99) kg \n"
   <<"\tmy range with theta uls wing $(theta_tw * kg2lb_) --> $(theta_cw * kg2lb_) lbs \n"
    best_theta_wt_lbs = 90*2.2 - thwt*2.2 - kit*2.2
 <<"\tmy best weight - bathroom for theta 25 is $best_theta_wt_lbs !   \n"
    max_theta_wt_lbs = 95*2.2 - thwt*2.2 - kit*2.2
   <<"\tmy max weight - bathroom for theta 25 is $max_theta_wt_lbs !   \n"
     dw = (current_wt_lbs -best_theta_wt_lbs)
    if ( dw > 0) {
     <<"\t\tSlim down $dw for theta wing!! \n"
      theta_hue = ORANGE_;
     }

    if (max_theta_wt_lbs < current_wt_lbs) {
         theta_hue = RED_;
     <<"\t\tAlas too fat for theta wing!! diet!\n"
    }


    #include "wevent.asl" 
#include "tbqrd.asl"


  Symsz = 2


  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm("PG_WTRANGE")
  }

 void drawScreens()
  {

    <<"drawScreens $_proc \n"
 
    sWi(_woid,aw,_wclearclip,WHITE__)
    sWo(_woid,wtrwo,_wclipborder,BLACK_,_wredraw,ON_)
    axnum(wtrwo,2)
    axnum(wtrwo,1)

      <<"drawScreens $_proc \n"
 
    sWi(_woid,aw,_wclearclip,WHITE__)
    sWo(_woid,wtrwo,_wclipborder,BLACK_,_wredraw,ON_)
    axnum(wtrwo,2)
    axnum(wtrwo,1)

  // hook3 wtrange box
     plotBox(wtrwo,2,hook_minw,4,hook_maxw, LILAC_, FILL_)  
     plotSymbol(wtrwo,DIAMOND_,3,95,BLUE_,Symsz,1);
     plotSymbol(wtrwo,STAR_,3,hook_cw,hook_hue,Symsz,1);

  // advance theta wtrange box
     plotBox(wtrwo,6,theta_minw,8,theta_maxw, PINK_, FILL_)  
     plotSymbol(wtrwo,DIAMOND_,7,90,BLUE_,Symsz,1);
     
     plotSymbol(wtrwo,STAR_,7,theta_cw,theta_hue,Symsz,1);     

}



  aw =cWi("WT_RANGE");

titleButtonsQRD(aw);
//<<" CGW $aw \n"

  sWi(_woid, aw,_wresize,wbox(0.1,0.1,0.9,0.7,0))
  sWi(_woid,aw,_wclip,wbox(0.1,0.1,0.8,0.9))
    xmin = 0
     xmax = 10

    sWi(_woid,aw,_wscales,wbox(xmin,0,xmax,120),_wsavescales,0,_wsave,ON_)


    wtrwo=cWo(aw,WO_GRAPH_);

     sWo(_woid,wtrwo,_wresize,wbox(0.05,0.15,0.8,0.95),_wcolor,WHITE_)

 
     sWo(_woid,wtrwo,_wdraw,ON_,_wpixmap,ON_,_wclip,wbox(0.1,0.1,0.9,0.9))

     sWo(_woid,wtrwo,_wscales,wbox(xmin,70,xmax,110),_wsavescales,0)          

       drawScreens()


m_num = 0;
 while (1) {

        m_num++

       eventWait()
       drawScreens()
}
//////////

   //units()
   // to be fixed   !\n - ! cancels \


///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
