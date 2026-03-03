//
//  drawGoals
//



  void drawGoals(int ws)
  {

   oknow = Ask ("que pasa? $ws $_proc",0)

  if (ws == 0) {
   // Plot(wt_wo,_wbox,(sc_startday,DX_NEW,sc_end,DX_NEW+20), ORANGE_)  // never go above
  sWo(_WOID,wt_wo,_wlhbscales,wbox(sc_zstart,minWt,sc_zend,upperWt,0));
//sdb(1,"step,stderr")
  sWo(_woid,wt_wo,_wscales,wbox(sc_zstart,minWt,sc_zend,upperWt,0));
  sWo(_woid,wt_wo,_wusescales,0);

  cscales = wogetscales(wt_wo, Cscales)
  <<"%V $Cscales[0:4]\n"

  // set current scales

  oknow = Ask ("box? $ws $minWt $upperWt",0)
  plotBox(wt_wo,sc_zstart,DX_NEW,sc_zend,upperWt, RED_, FILL_)  

  plotBox(wt_wo,sc_zstart,180.0,sc_zend,DX_NEW, ORANGE_, FILL_)  

  plotBox(wt_wo,sc_zstart,170.0,sc_zend,180, YELLOW_, FILL_)  

  plotBox(wt_wo,sc_zstart,GoalWt-2,sc_zend,GoalWt+3, LIGHTGREEN_,FILL_)  //
    //Plot(cal_wo,_WLINE,sc_startday,day_burn,sc_end,day_burn, GREEN_)
  gflush()
  
  plotLine(cal_wo,sc_zstart,day_burn,sc_zend,day_burn, GREEN_)

  plotLine(cal_wo,sc_startday,out_cal,sc_end,out_cal, BLUE_)

  plotLine(cal_wo,sc_startday,in_cal,sc_end,in_cal, BLACK_)

  plotLine(cal_wo,sc_zstart,0,sc_zend,0, RED_)
  sWo(ket_wo,_WUSESCALES,1)
  plotLine(ket_wo,sc_zstart,1,sc_zend,1, BLUE_)
  sWo(ket_wo,_WUSESCALES,0)
  plotLine(ket_wo,sc_zstart,100,sc_zend,100, GREEN_)


  plotBox(cal_wo,sc_zstart,-1000,sc_zend,0, RED_, FILL_)

  // but we are getting RD% not gramss!
 // plotLine(food_wo,sc_startday,180,sc_end,180, GREEN_) ; //daily req protein (g)

//  plotLine(food_wo,sc_startday,50,sc_end,50, BLUE_) ; //daily req fat (g)

//   plotLine(food_wo,sc_startday,30,sc_end,30, BROWN_) ; //daily req fibre (g)

  plotLine(food_wo,sc_startday,35,sc_end,35, RED_)
  
    // use todays date and wt to the intermediate short-term goal

  plotLine(wt_wo,last_known_day,last_known_wt,targetday,TargetGoalWt, BLACK_) 

  <<"%V $last_known_day, $last_known_wt, $targetday, $TargetGoalWt \n" 

  }

  if (ws == 1) {

  //<<[_DB]"$ws $swo $kdays \n"

  plotLine(swo,0,150,kdays-10,250, BLUE_)

  }

  }
//---------------------------------------------------------
// what is current include?

oknow = Ask (" $_include  ",0)