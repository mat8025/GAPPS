/* 
 *  @script wtrange.asl                                                       
 * 
 *  @comment         *                                                        
 *  @release Carbon                                                           
 *  @vers 1.2 He Helium [asl 6.67 : C Ho]                                     
 *  @date 02/12/2026 18:04:07                                                 
 *  @cdate 12/14/2025 18:25:14       *                                        
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2026 -->                                     
 * 
 */ 


///   

  argc = argc();
  arg1= _clarg[1]
<<"%V $argc $arg1\n"

   c_harness = "adv"
   
   c_harness = _argv[1]
   
   float current_wt_lbs = _argv[2]
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
///  Advance Epsilon DLS 28
///  Hook 3 25
///  Advance Theta ULS 25



   #include "consts.asl"
// a comment

/{
  some comments
  more comments
/}

 
   rejectDB("array")


class Wing
  {

  public:
  
    float max;
    float min;
    float ideal_min;
    float ideal_max;
    float best_75;
    float wt;
    float best_wing_wt_libs;
    float allupwt;
    Str name;
    int hue;
    int bhue;    

  void Set( Str wname, float wmin, float wmax, float wwt)
  {
       name = wname;
       max = wmax;
       min = wmin;
       wt = wwt;
       best_75 = (max-min) *.75 + min;
  }

  void setIdeal( float wmin, float wmax)
  {

       ideal_max = wmax;
       ideal_min = wmin;
  }

  int Compute ()
  {

    wingwt = wt + harness + helmet + kit
    allupwt = wingwt + current_wt;
    
<<"%V $name %4.1f $min $max $wt    $harness $helmet $wingwt $allupwt \n"

   <<"\tmy range %4.1f  with $name wing $min --> $max kg     $(min * kg2lb_) --> $(max * kg2lb_) lbs  \n" 
    best_75 = (max-min) *.75 + min;

     best_wing_wt_lbs = best_75 *kg2lb_ - wingwt*kg2lb_ 
 <<"\tmy best weight - bathroom for $name is %4.1f $best_wing_wt_lbs !   \n"
    max_wing_wt_lbs = max*kg2lb_ - wingwt*kg2lb_  
   <<"\tmy max weight - bathroom for $name is %4.1f $max_wing_wt_lbs !   \n"

    min_wing_wt_lbs = min *kg2lb_ - wingwt*kg2lb_  
   <<"\tmy min weight - bathroom for $name is %4.1f $min_wing_wt_lbs !   \n"

    hue = BLACK_;
    bhue = GREEN_;

    
    dw = (current_wt_lbs -best_wing_wt_lbs)
    if ( fabs(dw) > 5) {
          bhue = ORANGE_;
     <<"\t\t\tAdjust %4.1f $(-1*dw) - for $name!! \n"
    }
    
    if (max_wing_wt_lbs < current_wt_lbs) {
     <<"\t\tAlas too fat for $name!! diet!!!!\n"
     bhue = RED_;
     hue = RED_;     
    }

    if (min_wing_wt_lbs > current_wt_lbs) {
     <<"\t\tAlas too light for $name wing!! add ballast!!!!\n"
     bhue = RED_;
     hue = RED_;     
    }

    return bhue;
  }


  void Print()
  {

    <<"%V $name %4.1f $min $max $ideal_min $ideal_max $wt $best_75 $allupwt %d $hue $bhue\n"

  }

  void Wing()
  {

    max = 100.0;
    min = 80.0;
    ideal_max = 100.0;
    ideal_min = 80.0;    
    wt = 5.1;
    best_75 = (max-min) *.75 + min;
    hue = GREEN_;
  }

 };




   current_wt = current_wt_lbs/kg2lb_ ;

   min_kg = 60
   max_kg = 120;
   min_lbs = min_kg *kg2lb_ 
   max_lbs = max_kg *kg2lb_

 <<"%V $min_kg   $min_lbs \n"
   

   helmet = 0.4  ; /* check /

   //  harnesses
   adv_harness = 2.15
   gin_harness = 5.9

   harness = adv_harness

   if (c_harness == "gin") {

     harness = gin_harness
   }


   if (c_harness == "adv") {

     harness = adv_harness
   }


   // wing weights kg 
   magicw = 5.2
   hook3w = 5.3




   // wings 




   Wing Hook3 ;
   hook_minw = 81.0 ; //kg
   hook_maxw = 101.0 ; 
   Hook3.Set("Hook3",80.0,100.0, 5.3) 
   Hook3.Compute()
   Hook3.Print()   

   Wing Epsilon10_28 ;

   epsilon_minw = 91 ; //  28 kg
   epsilon_maxw = 118 ; 
   epsilonw = 4.35 ;// 28
   
   Epsilon10_28.Set("Epsilon10_28",epsilon_minw,epsilon_maxw,epsilonw)
   Epsilon10_28.setIdeal(99,113)
   Epsilon10_28.Compute()
   Epsilon10_28.Print()

   Wing Epsilon10_26 ;

   epsilon_minw = 79 ; //  26 kg
   epsilon_maxw = 103 ; 
   epsilonw = 4.1 ; // 26

   Epsilon10_26.Set("Epsilon10_26",epsilon_minw,epsilon_maxw,epsilonw)
   Epsilon10_26.setIdeal(86,99)

   Epsilon10_26.Compute()
   Epsilon10_26.Print()



   Wing Magic ;
   // wing ranges
   magic_minw = 80.0 ; //kg
   magic_maxw = 100.0 ;

   magic_name = "Magic"
   Magic.Set(magic_name,magic_minw,magic_maxw,magicw)
   Magic.Compute()
   Magic.Print()

   Wing Theta ;

   theta_minw = 78 ; // kg
   theta_maxw = 99 ;
   thetaw = 3.55 ;
   Theta.Set("Theta",theta_minw,theta_maxw,thetaw)
   Theta.setIdeal(82,95)
   Theta.Compute()
   Theta.Print()


  
   // ballasts
   magicb = 0
   hook3b = 0
   thetab = 0
   epsilonb = 0

   magic_75= 90.0;
   hook_75= 90.0;
   theta_75= 90.0;
   epsilon_75= 90.0;      

   hook_cw = 90.0
   theta_cw = 90.0
   epsilon_cw = 90.0
   magic_cw = 90.0         
   

<<" clothes+shoes + waterbottle $d kg\n"
   cse_lbs = 8.0; // lets measure full kit
   kit = cse_lbs/kg2lb_

    // wing_status
    magic_bhue = GREEN_;        
    hook_bhue = GREEN_;
    epsilon_bhue = GREEN_;
    theta_bhue = GREEN_;        





//  compute_wts()





#include "wevent.asl" 
#include "tbqrd.asl"

  Symsz = 2
  openDll("image")

  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm("PG_WTRANGE")
  }

 void drawScreens()
  {
 
    sWi(_woid,aw,_wclearclip,WHITE_)
    sWo(_woid,wtrwo,_wclipborder,BLACK_,_wredraw,ON_)


      <<"drawScreens $_proc \n"
 
    sWi(_woid,aw,_wclearclip,WHITE__)
    // _clip for wo is clip area with the wob
    i= 2
    hue_name = getColorName(i)
    	ask("$hue_name $i",0);
        //<<"hues are  $i $hue_name  $(getColorName(i+1))\n"
    i++
        //<<"hues are  $i $hue_name  $(getColorName(i+1))\n"
	//ask("$hue_name $i",0);


    sWo(_woid,wtrwo,_wname,"WtRange",_wdraw,ON_,_wpixmap,ON_,_wclip,wbox(0.1,0.1,0.8,0.9,4),_wcolor,WHITE_)
    sWo(_woid,wtrwo,_whue,i,_wbhue,PINK_,_wclipborder,BLACK_,_wredraw,ON_)
    sWo(_woid,wtrwo,_wclipborder,BLACK_,_wclipbhue,LILAC_,_wclipfhue,ORANGE_,_wupdate,ON_)

    
    axnum(wtrwo,2,min_kg,max_kg,5,2,"2.0f")
    
    //axnum(wtrwo,2,min_kg,max_kg,5,-3,"2.0f")
    // want to use rht scales which should be scales 1

   // sWo(_woid,wtrwo,_wusescales,1)    
    sWo(_woid,wtrwo,_wscales,wbox(xmin,min_lbs,xmax,max_lbs),_wsavescales,1)
    axnum(wtrwo,8,min_lbs,max_lbs,12,-3,"2.0f")  ; // lets use 9-12 to force use of scales 1

    sWo(_woid,wtrwo,_wscales,wbox(xmin,min_kg,xmax,max_kg),_wsavescales,0)


    sWo(_woid,wtrwo,_wusescales,0)    


    axnum(wtrwo,1,xmin,xmax,2,1,"2.0f")

     mywt =helmet + harness + kit + current_wt

     magic_cw = magicw + mywt

     hook_cw = hookw + mywt

  // hook3 wtrange box
    <<"%V $Hook3.min  $Hook3.max $Hook3.allupwt \n"
     plotBox(wtrwo,2,Hook3.min,4,Hook3.max, Hook3.bhue, FILL_)  

     plotSymbol(wtrwo,DIAMOND_,3,Hook3.best_75,BLUE_,Symsz,1);
     plotSymbol(wtrwo,STAR_,3,Hook3.allupwt,Hook3.hue,Symsz,1);
     plotText(wtrwo,Hook3.name,3,Hook3.min -2,BLACK_,0,1)
     plotText(wtrwo,Theta.name,6,Theta.min -2,BLACK_,0,1)
     plotText(wtrwo,Epsilon10_26.name,9,Epsilon10_26.min-2,BLACK_,0,1)
     plotText(wtrwo,Epsilon10_28.name,12,Epsilon10_28.min-2,BLACK_,0,1)     
     

  // advance theta wtrange box
     <<"%V $Theta.min  $Theta.max $Theta.allupwt \n"
     plotBox(wtrwo,5,Theta.min,7,Theta.max, Theta.bhue, FILL_)  
     plotSymbol(wtrwo,DIAMOND_,6,Theta.best_75,BLUE_,Symsz,1);
     plotSymbol(wtrwo,STAR_,6,Theta.allupwt,Theta.hue,Symsz,1);     
    // Text(wtrwo,Theta.name,6,Theta.min-2,BLACK_,0)
     plotLine(wtrwo,5,Theta.ideal_min,7,Theta.ideal_min,BLACK_)
     plotLine(wtrwo,5,Theta.ideal_max,7,Theta.ideal_max,BLACK_)

  // epsilon wtrange box
     <<"%V $Epsilon10_26.min  $Epsilon10_26.max $Epsilon10_26.allupwt \n"
     plotBox(wtrwo,8,Epsilon10_26.min,10,Epsilon10_26.max, Epsilon10_26.bhue, FILL_)  
     plotSymbol(wtrwo,DIAMOND_,9,Epsilon10_26.best_75,BLUE_,Symsz,1);
     plotSymbol(wtrwo,STAR_,9,Epsilon10_26.allupwt,Epsilon10_26.hue,Symsz,1);
     plotLine(wtrwo,8,Epsilon10_26.ideal_min,10,Epsilon10_26.ideal_min,BLACK_)
     plotLine(wtrwo,8,Epsilon10_26.ideal_max,10,Epsilon10_26.ideal_max,BLACK_)
     

     <<"%V $Epsilon10_28.min  $Epsilon10_28.max $Epsilon10_28.allupwt \n"
     plotBox(wtrwo,11,Epsilon10_28.min,13,Epsilon10_28.max, Epsilon10_28.bhue, FILL_)  
     plotSymbol(wtrwo,DIAMOND_,12,Epsilon10_28.best_75,BLUE_,Symsz,1);
     plotSymbol(wtrwo,STAR_,12,Epsilon10_28.allupwt,Epsilon10_28.hue,Symsz,1);     
     plotLine(wtrwo,11,Epsilon10_28.ideal_min,13,Epsilon10_28.ideal_min,BLACK_)
     plotLine(wtrwo,11,Epsilon10_28.ideal_max,13,Epsilon10_28.ideal_max,BLACK_)



      woSetValue(wtbwo,"%4.2f $current_wt_lbs");

      woSetValue(harbwo,"$c_harness");

    for (i=0;i<10;i++) {
    if (mwos[i] == -1)
        break;
    sWo(_woid,mwos[i],_wredraw,ON_);

    }
}



  aw =cWi("WT_RANGE");

  titleButtonsQRD(aw);
//<<" CGW $aw \n"

  sWi(_woid, aw,_wresize,wbox(0.1,0.1,0.9,0.7,0))
  sWi(_woid,aw,_wclip,wbox(0.05,0.1,0.95,0.9))
     xmin = 0
     xmax = 14

    sWi(_woid,aw,_wscales,wbox(xmin,0,xmax,120),_wsavescales,0,_wsave,ON_)



      wtrwo=cWo(aw,WO_GRAPH_);

     sWo(_woid,wtrwo,_wresize,wbox(0.15,0.15,0.8,0.95),_wcolor,WHITE_)

 
     sWo(_woid,wtrwo,_wname,"WTRANGE",_wdraw,ON_,_wpixmap,ON_,_wclip,wbox(0.4,0.1,0.8,0.9),_wcolor,PINK_)
//sdb(1, "step","stderr")  ; // step thru code ?

     //sWo(_woid,wtrwo,_wrhtscales,wbox(xmin,min_lbs,xmax,max_lbs),_wsavescales,1)
     sWo(_woid,wtrwo,_wscales,wbox(xmin,min_lbs,xmax,max_lbs),_wsavescales,1)

     sWo(_woid,wtrwo,_wscales,wbox(xmin,min_kg,xmax,max_kg),_wsavescales,0)
     //<<"using RHT scales !\n"

      wtbwo=cWo(aw,WO_BV_); 
      sWo(_woid,wtbwo,_wname,"WT",_wclipbhue,CYAN_,_wfonthue,BLACK_,_whelp," Pilot WT lbs "); 

      harbwo=cWo(aw,WO_BV_); 
      sWo(_woid,harbwo,_wname,"Harness",_wclipbhue,LILAC_,_wfonthue,BLACK_,_whelp," Harness type "); 

      upbwo=cWo(aw,WO_SYM_); 
      sWo(_woid,upbwo,_wname,"UPWT",_wclipbhue,CYAN_,_wfonthue,BLACK_,_wsymbol,TRI_,_wsymsize,25,_whelp," increase WT lbs ");

      downbwo=cWo(aw,WO_SYM_); 
      sWo(_woid,downbwo,_wname,"DOWNWT",_wclipbhue,CYAN_,_wfonthue,BLACK_,_wsymbol,ITRI_,_wsymsize,25,_whelp," decrease WT lbs "); 

      int mwos[] = { upbwo, wtbwo,downbwo, harbwo, -1 }
     
      wovtile( mwos, 0.01,0.15,0.1,0.7,0.1);

      woSetValue(wtbwo,"%4.2f $current_wt_lbs");

      woSetValue(harbwo,"$harness");
     sWo(_woid,wtbwo ,_wstyle,SVB_,_wredraw,ON_);
     sWo(_woid,harbwo ,_wstyle,SVB_,_wredraw,ON_);
  
     drawScreens()


m_num = 0;
 while (1) {

        m_num++
       recompute = 0
       eventWait()

       if (ewoname == "WT") {
         recompute = 1
	 if (ebutton == 1) {
         current_wt_lbs += 2.5
	 }
	 else {
         current_wt_lbs -= 2.5
         }
         current_wt = current_wt_lbs/kg2lb_ ;	 
	 woSetValue(wtbwo,"$current_wt_lbs");
       }

       if (ewoname == "UPWT") {
                recompute = 1
           current_wt_lbs += 1
           current_wt = current_wt_lbs/kg2lb_ ;	 
	   woSetValue(wtbwo,"$current_wt_lbs");
       }
       if (ewoname == "DOWNWT") {
                recompute = 1
           current_wt_lbs -= 1
           current_wt = current_wt_lbs/kg2lb_ ;	 
	   woSetValue(wtbwo,"$current_wt_lbs");
       }
       
            if (ewoname == "Harness") {

             if (c_harness == "adv") {
                 c_harness = "gin"
		 harness = gin_harness
             }
             else {
                   c_harness = "adv"
		   harness = adv_harness
             }

             woSetValue(harbwo,"$c_harness");
                recompute = 1
                Theta.Compute()
		Hook3.Compute()
		Epsilon10_26.Compute()				
		Epsilon10_28.Compute()		
             }
           

               if( recompute) {
                Theta.Compute()
		Hook3.Compute()
		Epsilon10_28.Compute()		
               }

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
