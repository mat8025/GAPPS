/* 
 *  @script wex.asl 
 * 
 *  @comment  exercise/diet logger cpp vers
 *  @release CARBON 
 *  @vers 2.55 Cs 6.3.79 C-Li-Au 
 *  @date 02/03/2022 12:40:55          
 *  @cdate Fri Jan 1 08:00:00 2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                        

///
/// exercise weight display
/// calories burned (wt at 180)
/// Walk 4mhr 397, Hike 477, R 10mhr 795 Cycle 12mhr 636  Wt lift 350
/// Scuba   556   Gardening 318
/// sleep 8 hours   71.5 per hour
/// office computer work (24-8-exercise hours) 119.3 per hour
///
//!!"xset fp+ /home/mark/gasp-CARBON/fonts "
//wexdir = "./"
//chdir(wexdir)
//wherearewe=!!"pwd "
//<<[_DB]"%V$wherearewe \n"

#include "si.h"
#include "parse.h"
#include "codeblock.h"
#include "sproc.h"
#include "sclass.h"
#include "declare.h"
#include "gthread.h"
#include "paraex.h"
#include "scope.h"
#include "debug.h"

#include "uac.h"

#include <iostream>
#include <ostream>

class Svar;

  Svar Mo;

#define WALK 1
#define HIKE 2
#define RUN 3
#define BIKE 4
#define SWIM 5
#define GYM_SS 6
#define GYM_WTS  7
#define NDAYS 1000

//  Svar Mo[] = { "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC"};

////////////////////////////////////////  Globals //////////////////////////////



#include "wex_rates.asl"
//#include "tbqrd.asl"

 //float DVEC = vgen(FLOAT_,400,1,1);

  // all vecs should become Vec
  Str ans="xyz";
  
  Vec<double> Vtst(10,10,1);

   Vec<float> DVEC(400);


  Vec<float> DFVEC(400);

  Vec<float> DXVEC(400);

  Vec<float> WTVEC(400);
//Vec<float> PWTVEC(400) ;

  Vec<float> WTPMV(400);

  Vec<float> GVEC(400); // goal line;

  Vec<float> BPVEC(400);

  Vec<float> SEVEC(400);

  Vec<float> CARBV(400);

  Vec<float> WDVEC(400);

  Vec<float> EXTV(400);

  Vec<float> AVE_EXTV(400);

  Vec<float> EXEBURN(400);

  Vec<float> CALBURN(400);

  Vec<float> CARDIO(400);

  Vec<float> STRENGTH(400);
// cals,carbs consumed & when

  Vec<float> CALSCON(400);

  Vec<float> CARBSCON(400);

  Vec<float> FATCON(400);

  Vec<float> PROTCON(400);

  Vec<float> FIBRCON(400);
////////////////////////////////////////////////////

  int Nrecs;
  
  float Nsel_exemins = 0.0;

  float Nsel_exeburn = 0.0;

  float Nsel_lbs = 0.0;


  //<<[_DB]"$Mo \n";

  float WXY[20];

  char sep = 47;

  float minWt = 160;

  float upperWt = 225;
//StartWt = 205;
// rates per min

 float   GoalWt = 175;  // ideal -- flying weight

 float   StartWt = 215;

float   MinWt = 165;

  Str today;

 // today = date(2);

  long jtoday;
  long maxday;
  
  Str Year;

  long Bday;  // birthday;

  Str Bdate ;
  
  int lday;  // last day recorded in file;

  int dday;

  long Jan1;  // get the current year;

  long Yday ;
  long Yd ;


Svar GoalsC;
   
//GoalsC.Split("01/01/2022 03/31/2022 175"); // does not work

  int NCCobs =0;
  int NCCrecs = 0;
  
Record RX;

 Svar Col;

  float last_known_wt = 208.8;

  long last_known_day = 0;

  float tot_exeburn =0;

  float tot_exetime = 0;

  int Nobs = 0;
  int nxobs = 0;

  int Nxy_obs = 0;

  long wday;
  long gday;
  long gsday;

  int NextGoalWt;
  int StGoalWt;

  float   DX_NEW = 200.0;  // never exceed

  float   DX_MEW = GoalWt+5;  // max dx effort above

  Record RCC; // TBC has to be at least 1;

  int kdays;
//////////////////////  WOS ///////////////////////////

  int vp,vp1;

  int gwo,calwo,calcwo,carbwo,extwo;
  int swo,tw_wo,zinwo,zoomwo;
  int nobswo,xtwo,xbwo,xlbswo,dlbswo;
  int dtmwo,obswo,cbmwo,xtmwo,sdwo,gdwo,gwtwo,wtmwo;

//////////////////// GLINES /////////////////
  int calb_gl,carb_gl,fibre_gl,fat_gl,prot_gl,se_gl,bp_gl,pwt_gl,ext_gl, gw_gl,wt_gl;
//=========================================
  float CalsY1 = 5000.0;

  float carb_upper = 250;

  int sc_end ;

  long sc_zend ;   // for zooming;

  long sc_zstart;
  long sc_startday;

  long tday2,Sday,Sday2,yday,eday;
//    Svar Goals;
//    Svar Goals2;
//#include "wex_goals.asl"

////////////////////////////////////////  routines //////////////////////////////
#include "gevent.h"



#include "wex_read.asl"

  int N = 1000;
//float DVEC[200+];
//  let's use 400 to contain the year [1] will be first day
// [365] or [366] will be the end year 


   void computeGoalLine()
   {
 // <<"%V$StartWt $NextGoalWt\n"
     int sz;
     long ngday = gday - gsday;

     GVEC[0] = StartWt;  // start  Wt

     GVEC[1] = NextGoalWt;

     long ty_gsday = gsday;

     float gwt =  NextGoalWt;

     GVEC[ngday-1] = gwt;  // goal wt

     WDVEC[ngday-1] = gsday+ngday;

     int k =0;
//  lpd = 1.75/7.0      // 1.75 lb a  week

     float lpd = 4.0/7.0;      // 4 lb a  week

     float try_lpd = (StartWt - NextGoalWt) / (1.0 * ngday);

     float lw = StartWt;

// our goal line  wtloss per day!
//<<[_DB]"%V $try_lpd $lpd \n"

     for (int i= 0; i < ngday; i++) {
//<<"$(ty_gsday+i) $lw \n"

       GVEC[i] = lw;

       WDVEC[i] = gsday+i;

       lw -= try_lpd;

       if (lw < MinWt)

       lw = MinWt;

       }
///  revised goal line

   //  sz = Caz(GVEC);

 //    <<[_DB]" days $sz to lose $(StartWt-gwt) \n";

 //    sz = Caz(WDVEC);

 //    <<[_DB]"$sz\n";

 //    <<[_DB]"%6.1f%(7,, ,\n)$WDVEC\n";

 //    <<[_DB]"%6.1f%(7,, ,\n)$GVEC\n";

     }
//==================================//



//#include "wex_screen.asl"

#include "wex_draw.asl"

 ///////////////////////////////////////////////////
  void Uac::Wex(Svarg * sarg)
  {
   #include "graphic.asl"

// test Vec Global
   setDebug(2,"pline");

  cout << "Vtst "  << Vtst << endl;

//    Svar Mo;
  // Mo scope  - wex_task

/////////////////////////////////////////////////  SET GOALS  ////////////////////////////////////////
///
///        long-term and current weight loss goals 
///
//  SET     START DATE      END DATE  TARGET WEIGHT

// days will days of year not Julian
   Str stmp;
   Svar Goals;
   
   Goals.Split("01/01/2022 03/31/2022 175");

//<<"Setting goals $Goals\n"

   Svar Goals2;
   
   Goals2.Split("03/21/2022 04/09/2022 194");
////////////////////==============/////////////////

// move these done 10 when reached -- until we are at desired operating weight!



   long tjd =  Julian(Goals[0]) ;
   

   //long sday = julian(Goals[0]) -Jan1 ; // start date

   Sday = tjd - Jan1;
   

   long tarxday = Julian(Goals[1]) -Jan1;
   long targetday = Julian(Goals[1]);

   targetday -= Jan1;
	  
//<<"%V $tjd $Jan1 $Sday $targetday  $tarxday; \n"

   cout << " Jan1 " << Jan1 << endl;

   NextGoalWt = atoi(Goals[2]);

   Sday2 = Julian(Goals2[0]) -Jan1 ; // start date

   tday2 = Julian(Goals2[1]) -Jan1;

   StGoalWt = atoi(Goals2[2]);

   gsday = Sday;

   gday =  targetday;    // next goal day;

   int got_start = 0;

   yday = Julian("01/01/2022")   ; // this should be found from data file

   eday = Julian("12/31/2022");

   stmp = getDate(2);
   jtoday = Julian(stmp);

   int ngday = 7;

   int k = eday - Sday;

   if ( k < 0) {

     cout <<" time backwards !\n";

     exit_si();

     }

   kdays = k;
/////////////////////////////////////////////////  READ RECORDS ////////////////////////////////////////
  int n = 0;



  today = getDate(2);

 // today = date(2);

  jtoday = Julian(today);

  Year= getDate(YEAR_);

  //<<"%V $today $jtoday $Year\n";

  Bday = Julian("04/09/1949");

  Jan1 = Julian("01/01/2022"); // Str adate ; adate.strPrintf("01/01/%s",Year.cptr()");

  Yday = jtoday -Jan1;

  Bdate = "04/09/1949";

  Mo.Split ("JAN,FEB,MAR,APR ,MAY,JUN, JUL, AUG, SEP, OCT, NOV , DEC",44);

  GoalsC.Split("01/01/2022 03/31/2022 175");


  maxday = Julian("04/09/2049") -Bday;
// this is a new format -- allowing us to put comment labels on graphs
//<<"%V $maxday \n"



  int A=ofr("DAT/wex2022.tsv");

  if (A == -1) {

  cout <<"FILE not found \n";

  exit_si();

  }
// check period

  Svar rx;

  Nrecs=RX.readRecord(A,_RDEL,-1);  // no back ptr to Siv?

  // reader in readRecord closes file

//  RX.pinfo();

  cout <<"Nrecs "  << Nrecs << endl;


  //<<"%V $Nrecs $RX[0] \n $(Caz(RX))  $(Caz(RX,0)) \n";


  //<<[_DB]"$RX[Nrecs-2]\n";

  rx= RX[Nrecs-1];

cout << "last rec " << rx << endl;

//<<"$RX[Nrecs-1]\n"

//  <<[_DB]"$rx\n";

//  lastRX = RX[Nrecs-1];
//  <<"%V$lastRX\n";
//!a
//lastRX->pinfo();
//chkT(1)
    //WDVEC= vgen(_INT_,2*kdays,0,1);

  
  k = 0;
///////////// Cals & Carb Consumed ////////
// so far not logged often 

  int ACC=ofr("DAT/cc2022.tsv");

  NCCrecs = 0;

  if (ACC == -1) {

  cout <<" no cc data!\n";

  }

  else {

  int nrc =RCC.readRecord(ACC,_RDEL,-1);  


 // cf(ACC);
  //RCC->info(1);

  NCCrecs = RCC.getNrows();
cout << "NCCrecs " << NCCrecs << endl;
//ans = query("NCCrecs");
  //NCCrecs->info(1)

 // <<"%V $NCCrecs \n";
/*
 for (i=0; i < NCCrecs ;i++) {
  <<[_DB]"$RCC[i] \n"
  }
*/

 // <<[_DB]"; /////////\n";

  }
  
////////////////// READ CEX DATA ///////////////////

    int nrd= readCCData();

 COUT (nrd) ;



    nrd= readData();


COUT (nrd) ;
  /////////////////////  part 1 ////////////////////////////

//   init_period = 32;

  sc_startday = (jtoday - Jan1) -20;

  if (sc_startday <0)

  sc_startday =0;

  long sc_endday = targetday + 10;
//   <<"%V$sc_startday $targetday $sc_endday \n"

  float gwt = NextGoalWt;

  computeGoalLine();
////////////////////////////////////////////////////////////////////////

  float sw2 = 205;

  float gw2 = 170;

COUT(gw2);


//////////////////   Predicted Wt   //////////////////////////////////
// (cal_consumed - cal_burn) / 4000.0    is wt gain in lbs
//  if no cal_burn registered for the day assume no exercise
//  if no cal_consumed assume  typical day_burn + 200 
//         first_k = ty_gsday
      //   first_k = 220
/////////////////////////////////////////////////////////////////////

float ae = EXTV[15];

COUT(ae);

   AVE_EXTV = EXTV;

  ae = AVE_EXTV[15];

COUT(ae);
   AVE_EXTV.Smooth(7);  // add Smooth (smooth_win_size)

   ae = AVE_EXTV[15];

COUT(ae);

#include "wex_screen.asl"



cout<<"DONE\n";

}



  extern "C" int wex_task(Svarg * sarg)  {

  Str a0 = sarg->getArgStr(0) ;

  Str Use_ ="plot Wex data";


  //<<[_DB]"%V $Nsel_exemins $Nsel_exeburn  $(typeof(Nsel_exemins))\n";

  int k = 0;

   Svar GoalsB;
   
    GoalsB.Split("01/01/2022 03/31/2022 175");


#include "wex_types.asl"



//#include "wex_callbacks.asl"


//#include "wex_glines.asl"



  Uac *o_uac = new Uac;

  o_uac->Wex(sarg);

    exit(0);
  }


   


///////////////////////////////// TBD /////////////////////////
// date-day
// interpolate missing
// carb, cal lookup   carb,protein,fat proportions
// energy expenditure
//- run,walk, cycle  --- weight/resistance exercise
// 
// OO activity organizer
// XML for data
// trend prediction toward goal (wt,strength) done?
// scrollable windows
// text - events ( notable days, events)
//  organize in Quarters  JFM,  AMJ,  JAS, OND
//  (last month, current month, next)
//  bench press value, arm curl, lat pull ?? values
//
//  get today's date and set up view for this quarter
//  can we add comments
//
//  1/12/22   - startup with yesterdays date and display of activity - for last 7 days (average?)
//

;//==============\_(^-^)_/==================//;

/////////////////////  part 1 ////////////////////////////
/*

//<<"%V$nrd\n"
////////////// PLOT GOAL LINE  ///////////////////////////////////////////
//    sc_endday = lday + 10
//    sc_endday = 75 * 365
// 

  init_period = 32;

  long sc_startday = (jtoday - Jan1) -20;

  if (sc_startday <0)

  sc_startday =0;

  long sc_endday = targetday + 10;
//   <<"%V$sc_startday $targetday $sc_endday \n"

  gwt = NextGoalWt;

  computeGoalLine();
////////////////////////////////////////////////////////////////////////

  sw2 = 205;

  gw2 = 170;

  //cf(A);

#include "wex_foodlog.asl"
//////////////////   Predicted Wt   //////////////////////////////////
// (cal_consumed - cal_burn) / 4000.0    is wt gain in lbs
//  if no cal_burn registered for the day assume no exercise
//  if no cal_consumed assume  typical day_burn + 200 
//         first_k = ty_gsday
      //   first_k = 220
/////////////////////////////////////////////////////////////////////

  AVE_EXTV = vsmooth(EXTV,7);
//<<[_DB]" Done calcs !\n"
//<<[_DB]"$Nxy_obs total exeburn %6.2f $tot_exeburn  cals  $(tot_exeburn/4000.0) lbs in $(tot_exetime/60.0) hrs\n"
#include "wex_compute.asl";

  PWT=predictWL();
//////////////////// DISPLAY /////////////////////////////
#include "graphic.asl"

  msg ="x y z"     ; // event vars;

  msgw =split(msg);
//<<[_DB]"%V$msgw \n"


  titleVers();

//ans=query("proceed?")
//sleep(0.1)
//<<"%V $_eloop\n"
///////////////////////// PLOT  ////////////////////////////////////////////
//  


  int wScreen = 0;

  float Rinfo[30];
//<<[_DB]"%(7,, ,\n)$CALBURN \n"
//<<[_DB]"%(7,, ,\n)$CALCON \n"

  int m_num = 0;

  int button = 0;

  Keyw = "";

  lcpx = sc_startday;

  rcpx = sc_endday;

  sGl(lc_gl,_cursor,lcpx,0,lcpx,300);

  sGl(rc_gl,_cursor,rcpx,0,rcpx,300);

  ZIN();

  woname = "";

  showTarget();

  titleVers();

  _DB=-1;

 // <<"%V $_eloop\n";
    // drawScreens();
//ans=query("proceed?")

  resize_screen();

  sWo(tw_wo,_move,targetday,NextGoalWt,gwo,_redraw));

  sWi(vp,_redraw);

  drawScreens();
//ans=query("%V$last_known_day")

  getDay(last_known_day);

  CR_init = 1; sGl(rc_gl,_cursor,last_known_day,0,last_known_day,300, CR_init); CR_init = 0;
//mc=getMouseEvent();
// _ekeyw.pinfo();
//_ename.pinfo();

  while (1) {

  m_num++;
//sleep(0.05)

//   if (m_num == 1) {
//      drawScreens();
     // setCursors();
//       }


  msg =eventWait();
//<<[2]"$m_num $msg  $_ename $_ewoname\n"
//_ekeyw.pinfo();
//_ename.pinfo();

  if (_ename == "PRESS") {
      // ans=iread(">>");

//     if (_ewoname != "") {
//<<"calling function via <|$_ewoname|> !\n"
//        $_ewoname()
//        }



   }

  if (_emsg == "EXIT") {

   <<"leaving WEX !\n";

   break;

   }

  if (_ewoname == "WTLB") {

   WTLB();

   }

  else if (_ewoname == "RESIZE") {

   drawScreens();

   }

  else if (_ewoname == "REDRAW") {

   drawScreens();

   }

  else if (_ewoname == "StartDay") {

   setGoals();

   }

  else if (_ewoname == "GoalDay") {

   setGoals();

   }

  else if (_ewoname == "WtGoal") {

   setGoals();

   }

  else if (_ewoname == "ZIN") {

   ZIN();

   }

  else if (_ekeyw != "") {

   <<"calling <|${_ekeyw}|>  $(typeof(_ekeyw))\n";

   $_ekeyw();

   }

  <<[_DB]"%V$lcpx $rcpx \n";

  WXY=WoGetPosition(tw_wo);
//<<"$WXY \n"
    //   place_curs( gwo,100,5,1,1)

  }
*/  
