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


  float   DX_NEW = 190.0;  // never exceed

  float   DX_MEW = GoalWt+5;  // max dx effort above


  void showTarget()
  {
// target wt and date
//  <<"$_proc $gday $FirstGoalWt $last_known_day\n"


  //<<"%V $last_known_day $PWT $PWT7 $PWT14  $tday2 $TargetGoalWt \n";


// cout<<"showTarget()\n";
  
  plotSymbol(wt_wo,targetday,TargetGoalWt,DIAMOND_,Symsz,GREEN_,1);

  //cout<<"plotSymbol\n";

  plotSymbol(wt_wo,tday2,FirstGoalWt,DIAMOND_,Symsz,BLUE_, 1);

  plotSymbol(wt_wo,last_known_day,FirstGoalWt,DIAMOND_,Symsz,RED_,1);

  plotSymbol(wt_wo,last_known_day+2,PWT,DIAMOND_,Symsz,GREEN_,1);

  plotSymbol(wt_wo,last_known_day+8,PWT7,DIAMOND_,Symsz,LILAC_,1);

  plotSymbol(wt_wo,last_known_day+15,PWT14,DIAMOND_,Symsz,PINK_,1);

  hlng = (last_known_wt - FirstGoalWt) / 0.43;

  if (hlng  > 0) {

 // <<"%v $hlng\n";

  plotSymbol(wt_wo,last_known_day+hlng,FirstGoalWt,STAR_,Symsz, BLUE_);

  plotSymbol(wt_wo,last_known_day+hlng,last_known_wt,CROSS_,Symsz,GREEN_);
 // <<"$_proc %v $hlng\n"

  plotSymbol(wt_wo,last_known_day+hlng,GoalWt,STAR_,Symsz, RED_);

  plotSymbol(wt_wo,last_known_day+hlng,last_known_wt,CROSS_,Symsz,GREEN_);

  }

 sWo(_WOID,wt_wo,_WSHOWPIXMAP,ON_);

//cout<<"Done showTarget\n";
  //plotSymbol(wt_wo,targetday,GoalWt,STAR_,Symsz, LILAC_);
//  dGl(gw_gl);
//sc_startday.pinfo();

  }
//===========================

  void showCompute()
  {


//<<" SHOW_COMPUTE %V $Nxy_obs $Nsel_exeburn $Nsel_lbs  $xhrs \n"

  sWo(_WOID,nobswo,_WVALUE,"%d $Nxy_obs",_WUPDATE,ON_)

  sWo(_WOID,xtwo,_WVALUE,"%6.2f $xhrs",_WREDRAW,ON_)

  sWo(_WOID,xbwo,_WVALUE,"%6.2f $Nsel_exeburn",_WREDRAW,ON_)

  //sWo(_WOID,xlbswo,_WVALUE,"%4.1f$Nsel_lbs",_WUPDATE,ON_)
  sWo(_WOID,xlbswo,_WVALUE,"%4.1f $Nsel_lbs",_WUPDATE,ON_)

  sWo(_WOID,dlbswo,_WVALUE,"%4.1f $Ndiet_lbs",_WUPDATE,ON_)

  }
//========================================================

  void drawGoals(int ws)
  {

 //  oknow = Ask ("que pasa? $ws $_proc",1)

  if (ws == 0) {
   // Plot(wt_wo,_WBOX,sc_startday,DX_NEW,sc_end,DX_NEW+20, ORANGE_)  // never go above

 // sWo(_WOID,wt_wo,_WSCALES,wbox(rx,minWt,rX,upperWt),_WSAVESCALES,0);

  plotBox(wt_wo,sc_zstart,DX_NEW,sc_zend,upperWt, RED_, FILL_)  

  plotBox(wt_wo,sc_zstart,180.0,sc_zend,DX_NEW, ORANGE_, FILL_)  

  plotBox(wt_wo,sc_zstart,170.0,sc_zend,180, YELLOW_, FILL_)  

  plotBox(wt_wo,sc_zstart,GoalWt-2,sc_zend,GoalWt+3, LIGHTGREEN_,FILL_)  //
    //Plot(cal_wo,_WLINE,sc_startday,day_burn,sc_end,day_burn, GREEN_)

  plotLine(cal_wo,sc_zstart,day_burn,sc_zend,day_burn, GREEN_)

  plotLine(cal_wo,sc_startday,out_cal,sc_end,out_cal, BLUE_)

  plotLine(cal_wo,sc_startday,in_cal,sc_end,in_cal, BLACK_)

  plotLine(cal_wo,sc_zstart,0,sc_zend,0, RED_)

  plotBox(cal_wo,sc_zstart,-1000,sc_zend,0, RED_, FILL_)

  // but we are getting RD% not gramss!
 // plotLine(food_wo,sc_startday,180,sc_end,180, GREEN_) ; //daily req protein (g)

//  plotLine(food_wo,sc_startday,50,sc_end,50, BLUE_) ; //daily req fat (g)

//   plotLine(food_wo,sc_startday,30,sc_end,30, BROWN_) ; //daily req fibre (g)

  plotLine(carb_wo,sc_startday,35,sc_end,35, RED_)
  
    // use todays date and wt to the intermediate short-term goal

  plotLine(wt_wo,last_known_day,last_known_wt,targetday,TargetGoalWt, BLACK_) 

  }

  if (ws == 1) {

  //<<[_DB]"$ws $swo $kdays \n"

  plotLine(swo,0,150,kdays-10,250, BLUE_)

  }

  }
//---------------------------------------------------------

  void  drawMonths(int wwo)
  {
  //
  // as either Months Jan,Feb, ... Dec  
  // or quarter and cross-quarter days
  // Candlemass Feb 2
  // Lady Day   March 25
  // Beltane (may day) May 1
  // MidSummer   June 24
  // Lughnasaid  Aug 1
  // Michlemas   Sept 29
  // Samhain     Oct 31
  // Christmas   Dec 25
  //
  // Equinoxes Dec 21, March 21, June 21, Sep 21 -
  // winter ,vernal, midsummer, fall
  //<<"$_proc  $wwo\n"
  // oknow = Ask ("que pasa? $_proc $wwo",1)
  int match[2]
  int sd

  int k

  int yd

  int wd

  int wm = 0

  float lty = 0
//  Str wday = "Mon"
  
  float qfwd = 0.0

  RS=wgetrscales(wwo)
// just plot at mid - the date

  mid_date = (RS[3] - RS[1])/2 + RS[1]

  float q1_date = (RS[3] - RS[1])/4 + RS[1]

  float q3_date = 3*(RS[3] - RS[1])/4 + RS[1]

  long jd= mid_date +Bday

//  the_date = julmdy("$jd")
   the_date = Julmdy(jd)

   // use mondays as the date tick


   //AxText(wwo, 1, the_date, mid_date, -0.25, BLUE_)

  jd= RS[1] + Jan1

  the_date = Julmdy(jd)
  
  Str mday = spat(the_date, "/",-1,-1, match)
  
 // AxText(wwo, 1, mday, q1_date, -0.25, BLUE_)

  float wdate = RS[1]

  sWo(_WOID,wwo,_WFONT,"small")
 //  AxText(wwo, 1, the_date, wdate, 0.25, BLUE_)

  int draw_months =1

  int mon = (jd +1) % 7

  mon = 2 -mon
  jd -= mon
  wdate -= mon
  
  while (draw_months <= 12) {

  jd += 7

  wdate += 7

  if (wdate >= RS[3]) {

     break

  }

  the_date = Julmdy(jd)

 //wday = Julday(jd)
  
 // Str mday = spat(the_date, (char *)"/",-1,-1, match)
  mday = spat(the_date, "/",-1,-1, match)

 // axisLabel(wwo, 1, mday, wdate, 0.7, BLUE_)
  AxText(wwo, 1, mday, wdate, -0.25, MAGENTA_)
  
//   <<"%V $jd $wdate $RS[3] $the_date $mday $wday\n"

  draw_months++

  }

  }
//---------------------------------------------------------------

  void  drawGrids(int  ws )
  {
    int i,j
 <<" $ws \n"
//oknow = Ask ("que pasa? $_proc $ws",1)

  if (ws == 0) {

  //sWo({carb_wo,cal_wo,wt_wo},_WFONT,"small")

  //sWo(carb_wo,_WFONT,"small",_WEO) // check font can accept a int or char *

<<"%V $food_wo $carb_wo \n"
//oknow = Ask ("que pasa? $_proc",1)

  sWo(_WOID,food_wo,_WAXNUM,AXIS_LEFT_)

  sWo(_WOID,food_wo,_WYSCALES,wpt(-10,200),_WSAVESCALES,0) ; // rqdaily %

  sWo(_WOID,cal_wo,_WUSESCALES,0,_WAXNUM,  AXIS_LEFT_)
//  sWo(food_wo,_WAXNUM,2)

  sWo(_WOID,carb_wo,_WYSCALES,wpt(-5,200),_WSAVESCALES,1)

  sWo(_WOID,carb_wo,_WAXNUM,AXIS_LEFT_)

  sWo(_WOID,wt_wo,_WYSCALES,wpt(160,205))

    sWo(_WOID,wt_wo,_WAXNUM,AXIS_LEFT_)
  //sWo(carb_wo,_WAXNUM,2,0,sc_endday,20,10)
  Text(wt_wo, "Weight (lbs)",0.1,1.0,RED_,0,0,2)
  Text(carb_wo, "Carbs (grams) ",0.1,1.0,RED_,0,0,2)

  axisLabel(wt_wo,AXIS_BOTTOM_,"Weight (lbs)",0.5,1.7)

 // axisLabel(cal_wo,AXIS_BOTTOM_,"Calories",0.5,1.7)
   //axisLabel(carb_wo,AXIS_LEFT_,"Exercise Time (mins)",0.1,0.7) // TBF

 // axisLabel(carb_wo,AXIS_LEFT_,"Mins",0.1,4.0) // TBF

  axisLabel(food_wo,AXIS_LEFT_,"Carbs",0.1,4)
 

  }

  else {

  //axnum(swo,2)
  //sWo(swo,_WAXNUM,2,150,bp_upper,50,10)

  //sWo(xwo,_WCLIPBORDER,BLACK_,_WSAVE,_WEO)

  }
  int allwo[] = {wt_wo,swo, cal_wo,  carb_wo , food_wo,-1}
    for (i = 0; i< 10; i++) {
      if (allwo[i] <=0)
         break;
      sWo(_WOID,allwo[i],_WSHOWPIXMAP,ON_,_WSAVE,ON_,_WCLIPBORDER,BLACK_)
    }

//oknow = Ask ("que pasa? $_proc",1)

  }
//---------------------------------------------------------------------------------
#define ALL_LINES 1

  void drawScreens()
  {
  int i,j;

//oknow = Ask ("que pasa? $_proc",1)

//<<"%V $_proc $sc_startday  $sc_end \n";


// sc_startday.pinfo()
 //sc_startday = (jtoday - Bday) - 20;
//<<"RESET? %V $sc_startday  $sc_end \n"


//int wedwos[10] = { wt_wo, cal_wo,  food_wo, carb_wo,-1  };  // TBC 10/13/24 - xic error?
// better to declare as global screen_wex


  if ( wScreen == 0) {

//<<"%V $sc_zstart $minWt $sc_zend $upperWt\n";

 //sWo(wt_wo,_WSCALES,wbox(rx,minWt,rX,upperWt),_WSAVESCALES,0,_WFLUSH);

  COUT(sc_zstart);
  COUT(sc_zend);

 for (i = 0; i< 10; i++) {
//<<"$i $wedwos[i] \n"
      if (wedwos[i] <=0) {
         break;
	 }
        sWo(_WOID,wedwos[i],_WXSCALES, wpt(sc_zstart,sc_zend));
//printf("%d xscales %f %f\n",i,sc_zstart,sc_zend);

        sWo(_WOID,wedwos[i],_wclearclip,WHITE_,_wsave,ON_,_wclearpixmap,ON_,_wclipborder,BLACK_,_wredraw,ON_,_wsavepixmap,ON_);
  }
  
  wScreen= 0
//oknow = Ask ("que pasa? $_proc $wScreen ",1)
  drawGoals( wScreen);

  drawGrids( wScreen);

 
  if (ALL_LINES) {

  //ok=ask(" draw lines \n",2);

  //dGl(exgls);
      //dGl(cardio_gl);
      //dGl(strength_gl);

  sWo(_WOID,cal_wo,_WFONT,F_SMALL_);
      /// these need to be a separate wo to contain key  symbol and text
     // plot(cal_wo,_Wkeysymbol,0.78 ,0.9,DIAMOND_,Symsz,BLUE_,1);

      //Text(cal_wo,"Calories Burnt", 0.8,0.9,1)      
 plotLine(cal_wo,sc_zstart,day_burn,sc_zend,day_burn, GREEN_)

  plotLine(cal_wo,sc_startday,out_cal,sc_end,out_cal, BLUE_)

    Text(cal_wo,"Calories Ate", 0.8,0.82,1,0,BLACK_);


     // plot(cal_wo,_Wkeysymbol,0.78 ,0.7,TRI_,Symsz,RED_,1,_Wfonthue,WHITE_);      
      //Text(cal_wo,"Carbs Ate", 0.8,0.72,1)

  sWo(_WOID,carb_wo,_WFONT,F_SMALL_);

//plot(carb_wo,_Wkeysymbol,0.78,0.7,TRI_,Symsz,GREEN_,1);



//  sWo(_WOID,carb_wo,"Exercise Time (mins)",wpt( 0.8,0.7),1,0,RED_);
   Text(carb_wo,"Exercise Time (mins)",0.8,0.7,1,0,RED_);

   int gi=0;

  //while ( allgls[gi] >= 0)  {    // ?? bug
  
  do_all_gls = 1;
  if (do_all_gls) {
  while ( 1) {
  gname = glineGetName(allgls[gi]);
  
  //ok=ask("%V $gi $allgls[gi] $gname",1);

  sGl(_GLID,allgls[gi],_GLDRAW,ON_);
  
  gi++;

    if (allgls[gi] < 0)  {
             break;
    }

  }

  //sGl(_GLID,ext_gl,_GLUSESCALES,1,_GLDRAW,ON_);

  for (i = 0; i< 10; i++) {
        if (wedwos[i] <=0) {
         break;
	 }

     sWo(_WOID,wedwos[i],_WCLIPBORDER,BLACK_,_WPIXMAP,ON_,_WSAVEPIXMAP,ON_);
     // sWo(_WOID,wedwos[i],_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_);
   }


 }





//ans=query("proceed?");

//  int allwo[] = {wt_wo, swo, cal_wo, carb_wo , food_wo,-1};
   
   
  drawMonths(wt_wo);

  //drawMonths(cal_wo);

  //drawMonths(food_wo);

  drawMonths(carb_wo);
      //Text(carb_wo,"Exercise mins",-4,0.5,4,-90)
      //Text(wt_wo,  "Weight (lbs)",0.8,0.8,1)
       //dGl(wt_gl)
       //dGl(wt_gl)

     showTarget();

   for (i = 0; i< 10; i++) {
        if (wedwos[i] <=0) {
         break;
	 }


   }


 woSetValue(nobswo, Nobs);
 
 sWo(_WOID,nobswo,_WREDRAW,ON_);
  // <<"KEYS?\n"

////////////////////////////////////////// KEYS /////////////////////////////////////
 if (do_keys) {
float keypos[10]
  keypos = wogetposition (keycal_wo);
//   <<"keycal_wo $keypos \n";
    sWo(_WOID,keycal_wo,_WHMOVE,ON_);
    sWo(_WOID,keywo,_WHMOVE,ON_);
//    womove(keycal_wo,PANLEFT_,10);  // move left
//keypos = wogetposition (keycal_wo);

   <<"movewo keycal_wo $keypos \n";
     //womove(keycal_wo,PANLEFT_,10);
    sWo(_WOID,cal_wo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_)
    sWo(_WOID,keycal_wo,_WSCALES,wbox(0.0,0.0,1.0,1.0))
    sWo(_WOID,keycal_wo,_WCLIPBORDER,ON_,_WREDRAW,ON_,_WKEYGLINE,calgls);
    sWo(_WOID,food_wo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_)

  //womove(keywo,PANLEFT_,10);
    sWo(_WOID,food_wo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_)
    sWo(_WOID,keywo,_WSCALES,wbox(0.0,0.0,1.0,1.0))
    sWo(_WOID,keywo,_WCLIPBORDER,ON_,_WREDRAW,ON_,_WKEYGLINE,foodgls);

  keypos = wogetposition (keywo);

   //<<"keyfood_wo $keypos \n";
}

Text(cal_wo,"CALS In/Out",0.2,0.90);

//Textr(cal_wo,"Cals In/Out",155,1500);

Text(food_wo,"Fat,Fiber, Protein (dailyreq %%) ",0.1,0.89);

//Textr(food_wo,"Food",140,50);

 //sWo(_WOID,tbqrd_tv,_WCLEAR,ON_,_WCLEARCLIP,ON_,_WREDRAW,ON_);
 //textr(TBqrd_tv,Wex_Vers)

}

  if ( wScreen == 1) {

 // <<[_DB]" Drawscreen 1  BP!!\n";

  drawGoals(1);

  drawGrids(1);

  drawMonths(swo);

  sGl(_GLID,bp_gl,_GLDRAW,ON_);   

  sWo(_WOID,swo,_WSHOWPIXMAP,1);

  //sWo(allwo,_WCLIPBORDER,GREEN_);

  }

  //sWo(fewos,_WREDRAW);

 // sWo(tw_wo,_WMOVE,wpt(targetday,FirstGoalWt),wt_wo,_WREDRAW); // ?? parent wo

  Wex_CR_init = 1;
  Wex_CL_init = 1;
 //sc_startday.pinfo();
<<"Done drawScreens\n";
//oknow = Ask ("que pasa? $_proc",1)
  
  }
  
 }

 
//=================================================

  void showWL(long ws, long we)
  {
//<<"$_proc $ws $we\n"

  computeWL( ws, we);

  showCompute();

  }
//========================================================
//////////////////////// UTIL PROCS /////////////////////////////

  void adjustYear(int updown)
  {
// find current mid-year
// decrement - and set rx,RX to jan 1, dec 31 of that year
// then label 1/4 days
  int i,j;
  int wedwos[] = { wt_wo, cal_wo,  food_wo, carb_wo,-1  };
  float rx,ry,rX,rY;
  RS=wgetrscales(wt_wo);
// just plot at mid - the date

  mid_date = (RS[3] - RS[1])/2 + RS[1];

  jd= mid_date +Bday;

  the_date = Julmdy(jd);
   // which year?

 // Str yrs = sele(the_date,-4,4);
  Str yrs = the_date(-4,-1,1);

  long yrd = atoi(yrs);
//<<[_DB]"%V$jd $the_date $yrs $yrd \n"
//<<"%V$jd $the_date $yrs $yrd \n"

  if (updown > 0) {

  yrd++;

  }

  if (updown < 0) {

  yrd--;

  }
//<<"%V  $yrd \n"

  long st_jday = Julian("01/01/$yrd");

  long ed_jday = Julian("12/31/$yrd");
  //<<"%V  $yrd  $st_jday $ed_jday\n"

  rx = st_jday - Bday;

  rX = ed_jday - Bday;
     // rx = st_jday 
    //  rX = ed_jday 

  sc_startday = rx;

  sc_endday = rX;
  for (i = 0; i< 10; i++) {
      if (wedwos[i] <=0)
         break;
  sWo(_WOID,wedwos[i],_WXSCALES,wpt(rx,rX),_WSAVESCALES,0);
  }
  
  sWo(_WOID,swo,_WXSCALES,wpt(rx,rX));
  // want to use left and right scales
 // sWo(_WOID,wt_wo,_WSCALES,wbox(rx,minWt,rX,upperWt),_WSAVESCALES,0);
  sWo(_WOID,wt_wo,_WSCALES,wbox(rx,minWt,rX,upperWt));

  drawScreens();

  }
//////////////////////////////////////////////////////////////////////



  void resize_screen()
  {

    sWi(_WOID,vp,_WRESIZE,wbox(0.05,0.01,0.98,0.98),_WREDRAW,ON_);

  }
  
 //[EP]/////////////////////////////////////////////// 

  void getDay(long dayv)
  {

<<" $_proc   $dayv \n"

  dayv.pinfo();
  
  long m_day;  // int ?;

  float cbm;

  float xtm;

  float wtm;

  float carb;

  int dt;



  m_day= dayv + Jan1  ;  // ? OBO;

  Str mdy = Julmdy(m_day);
 int dindex = dayv ;
 
<<"%V $dayv $m_day $Jan1 $mdy $dindex\n"


  
  //sWo(dtmwo,_WVALUE2 ,mdy,_WREDRAW );
  woSetValue(dtmwo,mdy);

// day of year is 0 or 1 for Jan1 ?
 

//<<"%V $dindex \n"

  wtm = WTVEC[dindex];
  cbm = CALSBURN[dindex];
  ccon = CALSCON[dindex];  
  xtm = EXTV[dindex];
  carb= CARBSCON[dindex];
  prot= PROTCON[dindex];
  fat = FATCON[dindex];
  fiber = FIBRCON[dindex];    
//<<"%V $xtm \n"
  xtm = fround(xtm,1);
//<<"round %V $xtm \n"  


// ? set the wo up to display float  rather than string
  //  have XGS round the float ?


  woSetValue(wtmwo,"%6.1f$wtm");
  
  woSetValue(calburnwo,"%6.1f$cbm");

  woSetValue(calconwo,"%6.1f$ccon");

  woSetValue(carbewo,"%6.1f$carb");

  woSetValue(protewo,"%6.1f$prot");

  woSetValue(fatewo,"%6.1f$fat");

  woSetValue(fibewo,"%6.1f$fiber");

  woSetValue(xtmwo,"%6.1f$xtm");

  sWo(_WOID,calburnwo,_WREDRAW,1);
  sWo(_WOID,calconwo,_WREDRAW,1);  
  sWo(_WOID,wtmwo,_WREDRAW,1);
  sWo(_WOID,xtmwo,_WREDRAW,1);
  sWo(_WOID,carbewo,_WREDRAW,1);
  sWo(_WOID,protewo,_WREDRAW,1);
  sWo(_WOID,fatewo,_WREDRAW,1);
  sWo(_WOID,fibewo,_WREDRAW,1);  
  
  
  sWo(_WOID,dtmwo,_WSTRVALUE ,mdy,_WREDRAW,1);


  //  return m_day;
    
  }
//[EM]=================================//


//==============\_(^-^)_/==================//
