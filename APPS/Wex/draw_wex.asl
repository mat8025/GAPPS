/* 
 *  @script wex_draw.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.4 Be 6.3.78 C-Li-Pt 
 *  @date 01/31/2022 09:08:26          
 *  @cdate Fri Jan 1 08:00:00 2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
//----------------<v_&_v>-------------------------//                                                                                                

#include "draw_grids.asl"
#include "draw_goals.asl"
#include "draw_months.asl"
#include "draw_target.asl"
#include "draw_glines.asl"


  float   DX_NEW = 190.0;  // never exceed

  float   DX_MEW = GoalWt+5;  // max dx effort above
  float Cscales[60];


#define ALL_LINES 1

  void drawScreens()
  {
  int i,j;



//<<"%V $_proc $sc_startday  $sc_end \n";
// sc_startday.pinfo()
// sc_startday = (jtoday - Bday) - 20;
// <<"RESET? %V $sc_startday  $sc_end \n"


  if ( wScreen == 0) {

//<<"%V $sc_zstart $minWt $sc_zend $upperWt\n";

 //sWo(_woid,wt_wo,_WSCALES,wbox(rx,minWt,rX,upperWt),_wsavescales,0);

  COUT(sc_zstart);
  COUT(sc_zend);

  sWo(_woid,wt_wo,_wclear,ON_);
  sWo(_woid,cal_wo,_wclear,ON_);
  sWo(_woid,carb_wo,_wclear,ON_);
  sWo(_woid,ket_wo,_wclear,ON_);  





 for (i = 0; i< 10; i++) {
  ans=ask("$i $wedwos[i] ",0)
      if (wedwos[i] <=0) {
         break;
	 }
   sWo(_woid,wedwos[i],_wxscales, wpt(sc_zstart,sc_zend));
        //printf("%d xscales %f %f\n",i,sc_zstart,sc_zend);

//   sWo(_woid,wedwos[i],_wclearclip,WHITE_,_wsave,ON_,_wclearpixmap,ON_,_wclipborder,BLACK_,_wredraw,ON_,_wsavepixmap,ON_);
   sWo(_woid,wedwos[i],_wclearclip,WHITE_,_wsave,ON_,_wclearpixmap,OFF_,_wclipborder,BLACK_,_wredraw,ON_);
   
  }
  
  wScreen= 0


  drawGrids( wScreen);

  drawGoals( wScreen);

oknow = Ask ("que pasa? $_proc",0)

   sWo(_woid,cal_wo,_wfont,f_SMALL_);

/// these need to be a separate wo to contain key  symbol and text

// plot(cal_wo,_Wkeysymbol,0.78 ,0.9,DIAMOND_,Symsz,BLUE_,1);

  // want to use left and right scales
 sWo(_woid,wt_wo,_wscales,wbox(sc_zstart,minWt,sc_zend,upperWt));

<<" scale %V $sc_zstart $minWt $sc_zend $upperWt\n";

//   plotLine(cal_wo,sc_zstart,day_burn,sc_zend,day_burn, GREEN_)

   sWo(_woid,cal_wo,_wline,wbox(sc_zstart,day_burn,sc_zend,day_burn, GREEN_))

 //  plotLine(cal_wo,sc_startday,out_cal,sc_end,out_cal, BLUE_)

  sWo(_woid,cal_wo,_wline,wbox(sc_startday,out_cal,sc_end,out_cal, BLUE_))
  Text(carb_wo,"Exercise Time (mins)",0.8,0.7,1,0,RED_);

   drawMonths(wt_wo);

  //drawMonths(cal_wo);

  //drawMonths(food_wo);

  //drawMonths(carb_wo);

oknow = Ask ("que pasa pre Glines? $_proc",0)

  drawGlines();


  //plotLine(wt_wo,last_known_day,last_known_wt,targetday,TargetGoalWt, BLACK_) ;  // does not show?

 sWo(_woid,wt_wo,_wline,wbox(last_known_day,last_known_wt,targetday,TargetGoalWt, BLACK_)) ;  // does not show?

oknow = Ask ("que pasa post Glines? $_proc",0)


 }

}
//////////////////////////////////////////////////////////////////////



  void resize_screen()
  {

    sWi(_woid,vp,_wresize,wbox(0.05,0.01,0.98,0.98),_wredraw,ON_);

  }
  
 //[EP]/////////////////////////////////////////////// 


//==============\_(^-^)_/==================//
