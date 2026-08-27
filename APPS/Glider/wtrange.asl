/* 
 *  @script wtrange.asl                                                       
 * 
 *  @comment                                                                 
 *  @release Carbon                                                           
 *  @vers 1.2 He Helium [asl 6.67 : C Ho]                                     
 *  @date 02/12/2026 18:04:07                                                 
 *  @cdate 12/14/2025 18:25:14                                                
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2026 -->                                     
 * 
 */ 



///   

  argc = argc();
  arg1= _clarg[1]
    arg2= _clarg[2]
<<"%V $argc harness $arg1 wtlbs $arg2\n"

   c_harness = "adv"
   
   c_harness = _argv[1]


   float body_wt_lbs = _argv[2]
   <<"%V $body_wt_lbs \n"

ans = ask("%V $body_wt_lbs $c_harness ",0)
   

#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of  ";

// Svar argv = _argv;  // allows asl and cpp to refer to clargs

<<" [0] $_argv[0] [1] $_argv[1] [2] $_argv[2] \n"

 argc = argc();

   <<"%V $arg1 \n"
<<" we are in ASL mode $argc and arg1 is $arg1\n"
//<<" $argv[0] $argv[1] $argv[2] \n"
 //wat = ask("using $current_wt_lbs for current weight OK?",0)
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




//   wtrange  for my glider wings
//
///  What is my max and min weight for my PG wings ?
///  Magic motor 27
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
    int heavy_light;
    Str name;
    int hue;
    int bhue;    
    int shape;
  void Set( Str wname, float wmin, float wmax, float wwt)
  {
       name = wname;
       max = wmax;
       min = wmin;
       wt = wwt;
//       best_75 = (max-min) *.75 + min;
  }

  void setIdeal( float wmin, float wmax)
  {

       ideal_max = wmax;
       ideal_min = wmin;
              best_75 = (ideal_max-ideal_min) *.75 + ideal_min;
	      <<"%V $ideal_max $ideal_min $best_75 \n ";
	      
  }

  int Compute ()
  {

    wingwt = wt ;
    allupwt = wingwt + body_wt + ballast_wt + harness_wt + helmet + kit
    current_wt = allupwt;
    current_wt_lbs = current_wt * kg2lb_ 
    
<<"%V $name %4.1f $min $max  $c_harness $body_wt $harness_wt $helmet $wingwt $kit $ballast_wt = $allupwt \n"

  // <<"\tmy range %4.1f  with $name wing $min --> $max kg     $(min * kg2lb_) --> $(max * kg2lb_) lbs  \n" 
    best_75 = (ideal_max-ideal_min) * 0.75 + ideal_min;
    heavy_light = 0;
    // best_wing_wt_lbs = best_75 * kg2lb_ - wingwt*kg2lb_
     best_wing_wt_lbs = best_75 * kg2lb_ 
 //<<"\tmy best weight - bathroom for $name is %4.1f $best_wing_wt_lbs !   \n"

    //max_wing_wt_lbs = max * kg2lb_ - wingwt*kg2lb_
    max_wing_wt_lbs = max * kg2lb_ 
   //<<"\tmy max weight - bathroom for $name is %4.1f $max_wing_wt_lbs !   \n"

//    min_wing_wt_lbs = min *kg2lb_ - wingwt*kg2lb_
    min_wing_wt_lbs = min *kg2lb_   
   //<<"\tmy min weight - bathroom for $name is %4.1f $min_wing_wt_lbs !   \n"

    hue = BLACK_;
    bhue = GREEN_;

    heavy_light = 0;
    
    dw = (current_wt_lbs -best_wing_wt_lbs)
    if ( fabs(dw) < 5) {
        heavy_light = 0;
     <<"\t\t\tAdjust %4.1f $(-1*dw) - for $name!! \n"
    }
    
    if (current_wt > ideal_max) { 
     <<"\t\tAlas too fat for $name!! diet!!!!\n"
         heavy_light = 1;
    }

    if ( current_wt < ideal_min) {
     <<"\t\tAlas too light for $name wing!! add ballast!!!!\n"
      heavy_light = -1;
    }



    return bhue;
  }

  void Plot(float pos)
  {

     plotBox(wtrwo,pos,min,pos+2,max, ORANGE_, FILL_)  ;

     show_max_min =0;
     
     shape = STAR_ ;

     if (heavy_light == -1) {
         hue = BROWN_ ;     
         shape = TRI_;
     }


     
     if (heavy_light == 1) {
         hue = RED_ ; 
         shape = ITRI_;
     }

      if (heavy_light == 0) {
         hue = GREEN_ ;
      }            

     plotSymbol(wtrwo,CROSS_,pos+1,best_75,BLUE_,Symsz,1);

     plotSymbol(wtrwo,shape,pos+0.1,allupwt,hue,Symsz,1,FILL_);

     if (show_max_min) {
          plotSymbol(wtrwo,LEFTARROW_,pos+0.1,max,BLACK_,Symsz,1);
	  plotSymbol(wtrwo,LEFTARROW_,pos+0.1,min,BLACK_,Symsz,1);
     }

       //   plotSymbol(wtrwo,RIGHTARROW_,pos+0.1,ideal_max,GREEN_,Symsz,1);
//	  plotSymbol(wtrwo,RIGHTARROW_,pos+0.1,ideal_min,GREEN_,Symsz,1);
    // plotSymbol(wtrwo,shape,pos+0.1,allupwt,BLUE_,Symsz,1);	  

     plotLine(wtrwo,pos,ideal_min,pos+2,ideal_min,BLUE_)
     plotLine(wtrwo,pos,ideal_max,pos+2,ideal_max,RED_)

     plot(wtrwo,_line,pos,ideal_min,pos+2,ideal_min,YELLOW_)
     plotText(wtrwo,name,pos+1,min -2,BLACK_,0,1)
     plotText(wtrwo,"$heavy_light %6.1f$allupwt",pos+1,min -4,BLACK_,0,1)

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
    heavy_light = 0;
    wt = 5.1;
    best_75 = (max-min) *.75 + min;
    hue = GREEN_;
    shape = STAR_;
  }

 };

    float default_wt_lbs = 195.0
   <<"%V $default_wt_lbs\n"
   
if ( body_wt_lbs == 0) {
   body_wt_lbs = default_wt_lbs;
}
  
   body_wt =  body_wt_lbs/kg2lb_ ;



   float current_wt = body_wt;
   float current_wt_lbs = body_wt_lbs;
   float kit = 4.0;
   wingwt = 2.0;
   ballast_wt = 0.0;
   ballast_wt_lbs = 0.0;
   min_kg = 70
   max_kg = 120;
   min_lbs = min_kg *kg2lb_ 
   max_lbs = max_kg *kg2lb_

 <<"%V $min_kg   $min_lbs \n"
   

   helmet = 0.4  ; /* check /

   //  harnesses
   adv_harness = 2.15
   gin_harness = 3.5

   harness_wt = adv_harness

   if (c_harness == "gin") {
     harness_wt = gin_harness
   }


   if (c_harness == "adv") {
     harness_wt = adv_harness
   }
  ask("%V $c_harness $harness_wt\n",0)
   // wing weights kg 

   hook3w = 5.3



   // wings 


   Wing Hook3 ;
   hook_minw = 81.0 ; //kg
   hook_maxw = 101.0 ; 
   Hook3.Set("Hook3",80.0,100.0, 5.3)
   Hook3.setIdeal(81,98)
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

   Wing IotaDLS_25 ;

   iota_minw = 80 ; //  
   iota_maxw = 100 ; 
   iotaw = 4.3 ; // 

   IotaDLS_25.Set("IotaDLS_25",iota_minw,iota_maxw,iotaw)
   IotaDLS_25.setIdeal(85,97)

   IotaDLS_25.Compute()
   IotaDLS_25.Print()

   Wing Phi_Maestro_22 ;

   Phi_Maestro_22.Set("Phi_Maestro_22",83,108,4.95)
   Phi_Maestro_22.setIdeal(83,103)

   Phi_Maestro_22.Compute()
   Phi_Maestro_22.Print()


   Wing Phi_Maestro_23 ;

   Phi_Maestro_23.Set("Phi_Maestro_23",90,115,5.1)
   Phi_Maestro_23.setIdeal(90,110)

   Phi_Maestro_23.Compute()
   Phi_Maestro_23.Print()


   // wing ranges
   Wing Magic ;
   magic_minw = 88.0 ; //kg
   magic_maxw = 108.0 ;
   magicw = 5.2 ;
   magic_name = "Magic"
   Magic.Set(magic_name,magic_minw,magic_maxw,magicw)
   Magic.setIdeal(90,105)
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
   
   kit = cse_lbs/kg2lb_ ;

    // wing_status
    magic_bhue = GREEN_;        
    hook_bhue = GREEN_;
    epsilon_bhue = GREEN_;
    theta_bhue = GREEN_;
    phi_bhue = GREEN_;        


   current_wt = body_wt + wingwt + harness_wt + kit + helmet + ballast_wt;



//  compute_wts()


ans= ask("%V $body_wt $body_wt_lbs",0)


#include "wevent.asl" 
#include "tbqrd.asl"

  Symsz = 4.0;
  openDll("image")

  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm("PG_WTRANGE")
  }
 sleep (2)
 
 void drawScreens()
  {
 
    sWi(_woid,aw,_wclearclip,PINK_,_whue,LILAC_,_wbhue,TURQUOISE_,_wredraw,ON_)
    sWo(_woid,wtrwo,_wclipborder,BLACK_,_whue,LILAC_,_wbhue,PINK_,_wredraw,ON_)


      <<"drawScreens $_proc \n"
 
 
    // _clip for wo is clip area with the wob
    i= 2
    hue_name = getColorName(i)
    	ask("$hue_name $i",0);
        //<<"hues are  $i $hue_name  $(getColorName(i+1))\n"
    i++
        //<<"hues are  $i $hue_name  $(getColorName(i+1))\n"
	//ask("$hue_name $i",0);


    sWo(_woid,wtrwo,_woname,"WtRange",_wodraw,ON_,_wopixmap,OFF_,_woclip,wbox(0.1,0.1,0.9,0.9,4),_wocolor,WHITE_)
    sWo(_woid,wtrwo,_wohue,i,_wobhue,WHITE_,_woclipborder,BLACK_,_woredraw,ON_)
    sWo(_woid,wtrwo,_woclipborder,BLACK_,_woclipbhue,LILAC_,_woclipfhue,ORANGE_,_woupdate,ON_)

    
    axnum(wtrwo,2,min_kg,max_kg,5,2,"2.0f")
    
    //axnum(wtrwo,2,min_kg,max_kg,5,-3,"2.0f")
    // want to use rht scales which should be scales 1

   // sWo(_woid,wtrwo,_wousescales,1)    
    sWo(_woid,wtrwo,_woscales,wbox(xmin,min_lbs,xmax,max_lbs),_wosavescales,1)
    axnum(wtrwo,8,min_lbs,max_lbs,12,-3,"2.0f")  ; // lets use 9-12 to force use of scales 1

    sWo(_woid,wtrwo,_woscales,wbox(xmin,min_kg,xmax,max_kg),_wosavescales,0)


    sWo(_woid,wtrwo,_wousescales,0)    


    axnum(wtrwo,1,xmin,xmax,2,1,"2.0f")

     mywt =helmet + harness_wt + kit + body_wt

     magic_cw = magicw + mywt

     hook_cw = hookw + mywt

  // hook3 wtrange box
   // <<"%V $Hook3.min  $Hook3.max $Hook3.allupwt \n"
     Hook3.Plot(2)

     Theta.Plot(5)

  // advance theta wtrange box
   //  <<"%V $Theta.min  $Theta.max $Theta.allupwt \n"
 

  // IotaDLS wtrange box
   //  <<"%V $Iota2_27.min  $Iota2_27.max $Iota2_27.allupwt \n"
   //   IotaDLS_25.Plot(8)


  // Phi wtrange box

     Phi_Maestro_22.Plot(8)
     
   //Phi_Maestro_23.Plot(8)
   
    Epsilon10_28.Plot(11)

    Magic.Plot(14)

    current_wt = body_wt + wingwt + harness_wt + kit + helmet + ballast_wt;

<<"%V %6.4f $current_wt  $body_wt $wingwt $harness_wt $kit  $helmet $ballast_wt \n"     

     current_wt_lbs = current_wt * kg2lb_;
     
     woSetValue(wtbwo,"%4.2f $body_wt $body_wt_lbs");
     woSetValue(wtkgbwo,"%4.2f $current_wt $current_wt_lbs");     
      

      woSetValue(harbwo,"$c_harness $harness_wt");

    for (i=0;i<10;i++) {
    if (mwos[i] == -1)
        break;
    sWo(_woid,mwos[i],_woredraw,ON_);

    }
}
/////////////////////////////////////////////////////////


  aw =cWi("WT_RANGE");

  titleButtonsQRD(aw);
//<<" CGW $aw \n"

  sWi(_woid, aw,_wresize,wbox(0.05,0.1,0.95,0.9,0))
  sWi(_woid,aw,_wclip,wbox(0.05,0.1,0.99,0.95))
     xmin = 0
     xmax = 18

    sWi(_woid,aw,_woscales,wbox(xmin,0,xmax,120),_wosavescales,0,_wosave,ON_)

    wtrwo=cWo(aw,WO_GRAPH_);

     sWo(_woid,wtrwo,_woresize,wbox(0.15,0.15,0.9,0.95),_wocolor,WHITE_)

 
     sWo(_woid,wtrwo,_woname,"WTRANGE",_wodraw,ON_,_wopixmap,OFF_,_woclip,wbox(0.4,0.1,0.8,0.9),_wocolor,PINK_)
//sdb(1, "step","stderr")  ; // step thru code ?

     //sWo(_woid,wtrwo,_worhtscales,wbox(xmin,min_lbs,xmax,max_lbs),_wosavescales,1)
     sWo(_woid,wtrwo,_woscales,wbox(xmin,min_lbs,xmax,max_lbs),_wosavescales,1)

     sWo(_woid,wtrwo,_woscales,wbox(xmin,min_kg,xmax,max_kg),_wosavescales,0)
     //<<"using RHT scales !\n"

      wtbwo=cWo(aw,WO_BV_); 
      sWo(_woid,wtbwo,_woname,"BODYWT",_woclipbhue,CYAN_,_wofonthue,BLACK_,_wohelp," Pilot WT kg lbs ");


      harbwo=cWo(aw,WO_BV_); 
      sWo(_woid,harbwo,_wname,"Harness",_wclipbhue,LILAC_,_wfonthue,BLACK_,_whelp," Harness type "); 

      wtkgbwo=cWo(aw,WO_BV_); 
      sWo(_woid,wtkgbwo,_wname,"ALLUPWT",_wclipbhue,PINK_,_wfonthue,BLACK_,_whelp," All upw WT kg "); 

      upbwo=cWo(aw,WO_SYM_); 
      sWo(_woid,upbwo,_wname,"UPWT",_wclipbhue,CYAN_,_wfonthue,BLACK_,_wsymbol,TRI_,_wsymsize,25,_whelp," increase WT lbs ");

      downbwo=cWo(aw,WO_SYM_); 
      sWo(_woid,downbwo,_wname,"DOWNWT",_wclipbhue,CYAN_,_wfonthue,BLACK_,_wsymbol,ITRI_,_wsymsize,25,_whelp," decrease WT lbs ");

      ballastbwo=cWo(aw,WO_BV_); 
      sWo(_woid,ballastbwo,_wname,"BALLAST",_wclipbhue,CYAN_,_wfonthue,BLACK_,_wvalue,"0",_whelp," ballast WT kg "); 




      int mwos[] = { upbwo, wtbwo,downbwo, wtkgbwo,  harbwo,ballastbwo, -1 }
     
      wovtile( mwos, 0.01,0.15,0.12,0.7,0.1);

      woSetValue(wtbwo,"%4.2f $current_wt $current_wt_lbs");

      woSetValue(harbwo,"$harness");
     sWo(_woid,wtbwo ,_wstyle,SVB_,_wredraw,ON_);
     sWo(_woid,wtkgbwo ,_wstyle,SVB_,_wredraw,ON_);     
     sWo(_woid,harbwo ,_wstyle,SVB_,_wredraw,ON_);
       sWo(_woid,ballastbwo ,_wstyle,SVB_,_wredraw,ON_);
     drawScreens()

  ans= ask("%V $body_wt $body_wt_lbs",0)
  m_num = 0;

  while (1) {



        m_num++
       recompute = 0
       eventWait()

       if ( ewoname_ == "BODYWT") {
         recompute = 1
	 if (ebutton_ == 1) {
         body_wt_lbs += 2.5
	 }
	 else {
         body_wt_lbs -= 2.5
         }
         body_wt = body_wt_lbs/kg2lb_ ;

         current_wt = body_wt + wingwt + harness_wt + kit + helmet + ballast_wt;
         current_wt_lbs = current_wt/kg2lb_;

//<<"%V $wtbwo $wtkgbwo $body_wt $current_wt \n"

	 //woSetValue(wtbwo,"$bodywt $body_wt_lbs");

         //woSetValue(wtkgbwo,"%4.1f$current_wt");	 
         sWo(_woid,wtbwo,_wotext,"%4.1f$body_wt $body_wt_lbs");	 
        }

       if ( ewoname_ == "BALLAST") {
         recompute = 1
	 if (ebutton_ == 1) {
         ballast_wt += 1.0
	 }
	 else {
         ballast_wt -= 1.0
         }

         if ( ballast_wt < 0) {
            ballast_wt = 0;
         }
	 
	 current_wt = body_wt + wingwt + harness_wt + kit + helmet + ballast_wt;
         current_wt_lbs = current_wt *kg2lb_;
         ballast_wt_lbs = ballast_wt *kg2lb_;
         woSetValue(ballastbwo,"%4.1f$ballast_wt $ballast_wt_lbs");

         woSetValue(wtkgbwo,"%4.1f$current_wt $current_wt_lbs");



       }

       if (ewoname_ == "UPWT") {
                recompute = 1
           body_wt_lbs += 1
           body_wt = body_wt_lbs/kg2lb_ ;
	   
	   //woSetValue(wtbwo,"$bodywt $body_wt_lbs");	 
         current_wt = body_wt + wingwt + harness_wt + kit + helmet + ballast_wt;
         current_wt_lbs = current_wt*kg2lb_;


        // Symsz += 1.0;

         sWo(_woid,wtbwo,_wotext,"%4.1f$body_wt $body_wt_lbs");	 
         // woSetValue(wtkgbwo,"%4.1f$current_wt");	 	   
       }
       if (ewoname_ == "DOWNWT") {
           recompute = 1
           body_wt_lbs -= 1
           body_wt = body_wt_lbs/kg2lb_ ;	 
	//   woSetValue(wtbwo,"$bodywt $body_wt_lbs");	 		
	 current_wt = body_wt + wingwt + harness_wt + kit + helmet + ballast_wt;
         current_wt_lbs = current_wt*kg2lb_;
	 sWo(_woid,wtbwo,_wotext,"%4.1f$body_wt $body_wt_lbs");	 
         //  woSetValue(wtkgbwo,"%4.1f$current_wt");	 	   
     //    Symsz -= 2.0;
        }



            if (ewoname_ == "Harness") {

             if (c_harness == "adv") {
                 c_harness = "gin"
		 harness_wt = gin_harness
             }
             else {
                   c_harness = "adv"
		   harness_wt = adv_harness
             }
	    current_wt = body_wt + wingwt + harness_wt + kit + helmet + ballast_wt;
            current_wt_lbs = current_wt*kg2lb_;
	 
             woSetValue(harbwo,"$c_harness %4.1f$harness_wt");
           //  woSetValue(wtkgbwo,"%4.1f$current_wt");	 

//	     sWo(_woid,harbwo,_wotext,"$c_harness %4.1f$harness_wt");
//	      woSetText(harbwo,"$c_harness %4.1f$harness_wt");	 
                recompute = 1
             }
           

               if( recompute) {
                  Magic.Compute()
                  Theta.Compute()
  		Hook3.Compute()


//		IotaDLS_25.Compute()
//		Phi_Maestro_23.Compute()
//		Phi_Maestro_23.Print()

		Phi_Maestro_22.Compute()
		Phi_Maestro_22.Print()
		
	  	Epsilon10_28.Compute()
	  			Epsilon10_28.Print()


		current_wt = body_wt + wingwt + harness_wt + kit + helmet + ballast_wt;
                current_wt_lbs = current_wt*kg2lb_;	

                }

       drawScreens()
//  <<" Paras %V $wtbwo $wtkgbwo $body_wt $body_wt_lbs $current_wt $Symsz\n"	 
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
