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
;//----------------<v_&_v>-------------------------//;                                                                                                

#include "uac.h"

  int symsz =5;
  Str mdy;
   Vec<float> RS(25);


  void showTarget()
  {
// target wt and date
//  <<"$_proc $gday $NextGoalWt $last_known_day\n"
//  plot(gwo,_Wsymbol,gday,NextGoalWt, TRI_,1, YELLOW_);
//  plot(gwo,_Wsymbol,gday-1,NextGoalWt, 3,1,GREEN_);

  //<<"%V $last_known_day $PWT $tday2 $StGoalWt \n";
  cout<<"showTarget()\n";
  
  plotSymbol(gwo,tday2,StGoalWt,TRI_,symsz,BLACK_,1);

cout<<"plotSymbol\n";

  plotSymbol(gwo,gday,NextGoalWt,DIAMOND_,symsz,BLUE_);

  plotSymbol(gwo,last_known_day,NextGoalWt,DIAMOND_,symsz,RED_,1);

  plotSymbol(gwo,last_known_day+2,PWT,DIAMOND_,symsz,GREEN_,1);

  plotSymbol(gwo,last_known_day+8,PWT7,DIAMOND_,symsz,LILAC_,1);

  plotSymbol(gwo,last_known_day+15,PWT14,DIAMOND_,symsz,PINK_,1);

  hlng = (last_known_wt - NextGoalWt) / 0.43;

  if (hlng  > 0) {

 // <<"%v $hlng\n";

  plotSymbol(gwo,last_known_day+hlng,NextGoalWt,STAR_,symsz, BLUE_);

  plotSymbol(gwo,last_known_day+hlng,last_known_wt,CROSS_,symsz,GREEN_);
 // <<"$_proc %v $hlng\n"

  plotSymbol(gwo,last_known_day+hlng,GoalWt,STAR_,symsz, RED_);

  plotSymbol(gwo,last_known_day+hlng,last_known_wt,CROSS_,symsz,GREEN_);

  }

sWo(gwo,_WSHOWPIXMAP,_WEO);

cout<<"Done showTarget\n";
  //plotSymbol(gwo,targetday,GoalWt,STAR_,symsz, LILAC_);
//  dGl(gw_gl);
//sc_startday.pinfo();

  }
//===========================


  void showCompute()
  {
//<<"$_proc %V $Nsel_exeburn $Nsel_lbs\n"

  sWo(nobswo,_WVALUE,Nxy_obs,_WUPDATE,_WEO);

  sWo(xtwo,_WVALUE,xhrs,_WREDRAW,_WEO);

  sWo(xbwo,_WVALUE,"%6.2f$Nsel_exeburn",_WREDRAW,_WEO);

  sWo(xlbswo,_WVALUE,"%4.1f$Nsel_lbs",_WUPDATE,_WEO);

  sWo(dlbswo,_WVALUE,"%4.1f$Ndiet_lbs",_WUPDATE,_WEO);

  }
//========================================================

  void drawGoals(int ws)
  {

  if (ws == 0) {
   // Plot(gwo,_WBOX,sc_startday,DX_NEW,sc_end,DX_NEW+20, ORANGE_) ; // never go above

  plotBox(gwo,sc_startday,DX_NEW,sc_end,DX_NEW+20, ORANGE_) ; 

  plotBox(gwo,sc_startday,DX_MEW,sc_end,DX_NEW, YELLOW_) ; 

  plotBox(gwo,sc_startday,GoalWt-5,sc_end,GoalWt+5, LIGHTGREEN_) ; //
    //Plot(calwo,_WLINE,sc_startday,day_burn,sc_end,day_burn, GREEN_)

  plotLine(calwo,sc_startday,day_burn,sc_end,day_burn, GREEN_);

  plotLine(calwo,sc_startday,out_cal,sc_end,out_cal, BLUE_);

  plotLine(calwo,sc_startday,in_cal,sc_end,in_cal, RED_);

  plotLine(calwo,sc_startday,50,sc_end,50, GREEN_);
    // use todays date and wt to the intermediate short-term goal

  plotLine(gwo,last_known_day,last_known_wt,tday2,StGoalWt, RED_) ;

  }

  if (ws == 1) {

  //<<[_DB]"$ws $swo $kdays \n";

  plotLine(swo,0,150,kdays-10,250, BLUE_);

  }

  }
//---------------------------------------------------------

  void  drawMonths(int wwo)
  {
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
  int match[2];
  int sd;

  int k;

  int yd;

  int wd;

  int wm = 0;

  float lty = 0;

  float qfwd = 0.0;

  RS=wgetrscales(wwo);
// just plot at mid - the date

  mid_date = (RS[3] - RS[1])/2 + RS[1];

  float q1_date = (RS[3] - RS[1])/4 + RS[1];

  float q3_date = 3*(RS[3] - RS[1])/4 + RS[1];

  long jd= mid_date +Bday;

//  the_date = julmdy("$jd");
   the_date = Julmdy(jd);

 // <<[_DB]"%V$mid_date $jd $the_date \n";
   //AxText(wwo, 1, the_date, mid_date, -0.25, BLUE_)

  jd= RS[1] + Jan1;

  the_date = Julmdy(jd);
//  AxText(wwo, 1, the_date, q1_date, -0.25, BLUE_);

  float wdate = RS[1];

  sWo(wwo,_WFONT,"small",_WEO);
 //  AxText(wwo, 1, the_date, wdate, 0.25, BLUE_);

  int draw_months =1;

  while (draw_months <= 12) {

  jd += 7;

  wdate += 7;

  if (wdate >= RS[3]) {

  break;

  }

  the_date = Julmdy(jd);

  Str mday = spat(the_date, (char *)"/",-1,-1, match);

  axisLabel(wwo, 1, mday, wdate, 0.7, BLUE_);
 //  <<"%V $jd $wdate $RS[3] $the_date\n"

  draw_months++;

  }

  }
//---------------------------------------------------------------

  void  drawGrids(int  ws )
  {
// <<[_DB]" $ws \n"

  if (ws == 0) {

  //sWo({extwo,calwo,gwo},_WFONT,"small");

  sWo(extwo,_WFONT,"small",_WEO); // check font can accept a int or char *;
//  axnum(gwo,AXIS_LEFT_);

  sWo(carbwo,_WAXNUM,AXIS_LEFT_,_WEO);

  sWo(carbwo,_WYSCALES,wpt(0,carb_upper),_WSAVESCALES,0,_WEO);

  sWo(calwo,_WUSESCALES,0,_WAXNUM,  AXIS_LEFT_,_WEO);
//  sWo(carbwo,_WAXNUM,2);

  sWo(extwo,_WYSCALES,wpt(0,upperWt),_WSAVESCALES,1,_WEO);

  sWo(extwo,_WAXNUM,AXIS_LEFT_,_WEO);
  //sWo(extwo,_WAXNUM,2,0,sc_endday,20,10)
  //Text(gwo, "Weight (lbs)",-4,0.7,4,-90)

  axisLabel(gwo,AXIS_BOTTOM_,"Weight (lbs)",0.5,1.7);

  axisLabel(calwo,AXIS_BOTTOM_,"Calories",0.5,1.7);
   //axisLabel(extwo,AXIS_LEFT_,"Exercise Time (mins)",0.1,0.7); // TBF

  axisLabel(extwo,AXIS_LEFT_,"Mins",0.1,4.0); // TBF;

  axisLabel(carbwo,AXIS_LEFT_,"Carbs",0.1,4);
  //Text(calwo,"Cals In/Out",-4,0.7,4,-90);

  }

  else {

  //axnum(swo,2);
  //sWo(swo,_WAXNUM,2,150,bp_upper,50,10)

  //sWo(xwo,_WCLIPBORDER,BLACK_,_WSAVE,_WEO);

  }
  int allwo[] = {gwo,swo, calwo,  extwo , carbwo,-1};

    sWo(allwo,_WSHOWPIXMAP,_WSAVE,_WCLIPBORDER,-1,_WEO);

  }
//---------------------------------------------------------------------------------
#define ALL_LINES 1

  void drawScreens()
  {
//<<" $_proc \n"
//<<"%V $sc_startday  $sc_end \n"
// sc_startday.pinfo()
 //sc_startday = (jtoday - Bday) - 20;
//<<"RESET? %V $sc_startday  $sc_end \n"
 int wedwos[] = { gwo, calwo,  carbwo, extwo,-1  };
  Str ans;
cout<<"DrawScreens\n";

  if ( wScreen == 0) {
//<<"%V $sc_zstart $minWt $sc_zend $upperWt\n"
 // sWo(gwo,_WSCALES,wbox(rx,minWt,rX,upperWt),_WSAVESCALES,0,_WFLUSH);
  //sWo(wedwos,_WXSCALES,wpt(sc_zstart,sc_zend),_WFLUSH);
  

 // sWo(wedwos,_WCLEARCLIP,WHITE_,_WSAVE,_WCLEARPIXMAP,_WCLIPBORDER,BLACK_,_WFLUSH);

//  drawGoals( wScreen);

//  drawGrids( wScreen);

 //sWo(gwo,_WCLEARCLIP,CYAN_,_WSAVE,_WCLEARPIXMAP,_WCLIPBORDER,BLACK_,_WFLUSH);

// sWo(calwo,_WCLEARCLIP,YELLOW_,_WSAVE,_WCLEARPIXMAP,_WCLIPBORDER,BLACK_,_WFLUSH);
 sWo(gwo,_WSCALES,wbox(sc_startday,150,sc_end,220),_WFLUSH);
 
  if (ALL_LINES) {

 // <<[_DB]" draw lines \n";

  //dGl(exgls);
      //dGl(cardio_gl);
      //dGl(strength_gl);

  sWo(calwo,_WFONT,F_SMALL_,_WEO);
      /// these need to be a separate wo to contain key  symbol and text
     // plot(calwo,_Wkeysymbol,0.78 ,0.9,DIAMOND_,symsz,BLUE_,1);

      //Text(calwo,"Calories Burnt", 0.8,0.9,1)      

 // plotSymbol(calwo,_WKEYSYMBOL,wpt(0.78 ,0.8),DIAMOND_,symsz,RED_,1);

  sWo(calwo,_WTEXTR,"Calories Ate", wpt(0.8,0.82),1,0,BLACK_,_WEO);
     // plot(calwo,_Wkeysymbol,0.78 ,0.7,TRI_,symsz,RED_,1,_Wfonthue,WHITE_);      
      //Text(calwo,"Carbs Ate", 0.8,0.72,1)

  sWo(extwo,_WFONT,F_SMALL_,_WEO);
      //plot(extwo,_Wkeysymbol,0.78,0.7,TRI_,symsz,GREEN_,1);

  sWo(extwo,"Exercise Time (mins)",wpt( 0.8,0.7),1,0,RED_,_WEO);


  int allgls[] = {wt_gl,  carb_gl,  fibre_gl,  fat_gl,  prot_gl,  calc_gl,  calb_gl,  wt_gl,wt_gl2,ext_gl, -1};

   // int allgls[] = {wt_gl2,wt_gl, wt_gl3,-1};


   sGl(allgls,_GLDRAW,_GLEO);


   
 //  ans= query("see lines?\n");
      

  }


//ans=query("proceed?");

  int allwo[] = {gwo,swo, calwo,  extwo , carbwo,-1};
 // int allwo[] = {gwo,-1};
   
  sWo(allwo,_WCLIPBORDER,BLACK_,_WEO);
   
   
  //drawMonths(gwo);

//  drawMonths(calwo);

//  drawMonths(carbwo);

//  drawMonths(extwo);
      //Text(extwo,"Exercise mins",-4,0.5,4,-90)
      //Text(gwo,  "Weight (lbs)",0.8,0.8,1)
       //dGl(wt_gl)
       //dGl(wt_gl)

 showTarget();

 
  sWo(wedwos,_WSHOWPIXMAP,_WCLIPBORDER,BLACK_,_WEO);

  }

  if ( wScreen == 1) {

 // <<[_DB]" Drawscreen 1  BP!!\n";

  drawGoals(1);

  drawGrids(1);

  drawMonths(swo);

  sGl(bp_gl,_GLDRAW);   

  sWo(swo,_WSHOWPIXMAP,_WEO);

  //sWo(allwo,_WCLIPBORDER,GREEN_);

  }

  //sWo(fewos,_WREDRAW);

 // sWo(tw_wo,_WMOVE,wpt(targetday,NextGoalWt),gwo,_WREDRAW,_WEO); // ?? parent wo

  CR_init = 1;

  CL_init = 1;
 //sc_startday.pinfo();
   cout<<"Done drawScreens\n";
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
 int wedwos[] = { gwo, calwo,  carbwo, extwo,-1  };
  float rx,ry,rX,rY;
  RS=wgetrscales(gwo);
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
//  <<"%V  $yrd \n"

  long st_jday = Julian("01/01/$yrd");

  long ed_jday = Julian("12/31/$yrd");
  //<<"%V  $yrd  $st_jday $ed_jday\n"

  rx = st_jday - Bday;

  rX = ed_jday - Bday;
     // rx = st_jday 
    //  rX = ed_jday 

  sc_startday = rx;

  sc_endday = rX;

  sWo(wedwos,_WXSCALES,wpt(rx,rX),_WSAVESCALES,0,_WEO);

  sWo(swo,_WXSCALES,wpt(rx,rX),_WEO);

 sWo(gwo,_WSCALES,wbox(rx,minWt,rX,upperWt),_WSAVESCALES,0,_WFLUSH);

  drawScreens();

  }
//////////////////////////////////////////////////////////////////////

  void adjustQrt(int updown)
  {
// find mid-date 
// adjust to a 90 day resolution
// shift up/down by 30
   int wedwos[] = { gwo, calwo,  carbwo, extwo,-1  };
   float rx,ry,rX,rY;

   RS=wgetrscales(gwo);
// just plot at mid - the date

  mid_date = (RS[3] - RS[1])/2 + RS[1];

  jd= mid_date +Bday;

  the_date = Julmdy(jd);

  if (updown > 0) {

  rx = mid_date -30;

  rX = mid_date +60;

  }

  if (updown < 0) {

  rx = mid_date -60;

  rX = mid_date +30;

  }

  sc_startday = rx;

  sc_endday = rX;

  //sWo(wedwos,_WXSCALES,wpt(rx,rX),_WSAVESCALES,0);

  sWo(gwo,_WSCALES,wbox(rx,minWt,rX,upperWt),_WSAVESCALES,0,_WEO);

  sWo(swo,_WXSCALES,wpt(rx,rX),_WSAVESCALES,0,_WEO);

  drawScreens();

  }
//========================================================



  void resize_screen()
  {

  sWi(vp,_WRESIZE,wbox(0.05,0.01,0.98,0.98),_WREDRAW);

  }

  void getDay(long dayv)
  {

  long m_day;  // int ?;

  float cbm;

  float xtm;

  float wtm;

  int dt;



  m_day= dayv + Jan1 -1;  // ? OBO;

  mdy = Julmdy(m_day);

  //sWo(dtmwo,_WVALUE2 ,mdy,_WREDRAW );
  sWo(dtmwo,_WVALUE ,mdy,_WREDRAW ,_WEO);

  wtm = 0.0;

  sWo(wtmwo,_WVALUE,wtm,_WREDRAW,_WEO);

  sWo(cbmwo,_WVALUE,0,_WREDRAW,_WEO);

  sWo(xtmwo,_WVALUE,0,_WREDRAW,_WEO);

  sWo(obswo,_WVALUE,0,_WREDRAW,_WEO);

  int i = dayv -1;

  xtm = EXTV[i];

  wtm  = WTVEC[i];

  cbm  = CALBURN[i];

  dt = dayv -Sday;
   //<<"%V $dayv  $Sday $mdy\n"
   //<<"FOUND $i %V $dayv $Sday $dt  $wtm $xtm $cbm\n"

  sWo(obswo,_WVALUE,dt+1,_WREDRAW,_WEO);

  sWo(xtmwo,_WVALUE,xtm,_WREDRAW,_WEO);

  sWo(wtmwo,_WVALUE,wtm,_WREDRAW,_WEO);

  sWo(cbmwo,_WVALUE,cbm,_WREDRAW,_WEO);

  }
//[EM]=================================//
//===========//

;//==============\_(^-^)_/==================//;
