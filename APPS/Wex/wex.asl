/* 
 *  @script wex.asl                                                           
 * 
 *  @comment exercise/diet logger cpp vers     *                              
 *  @release Carbon                                                           
 *  @vers 2.57 La Lanthanum [asl 6.65 : C Tb]                                 
 *  @date 12/30/2025 10:48:12                                                 
 *  @cdate Fri Jan 1 08:00:00 2010    *                                       
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2025 -->                                     
 * 
 */ 

//----------------<v_&_v>-------------------------//;                  

  Str Wex_Vers= "2.68";

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

#define GT_DB   0
#define _ASL_ 1
#define _CPP_ 0

#if _CPP_
#include <iostream>
#include <ostream>

using namespace std;
#include "vargs.h"
#include "cpp_head.h" 
#include "consts.h"
#define PXS  cout<<
#define _ASL_ 0

#endif




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

#if _ASL_
#define cout NOP
#define COUT NOP
#define VCOUT NOP
#endif


 Svar Mo;
//#include "hv.asl"


#include "rates_wex.asl"


 //float DVEC = vgen(FLOAT_,400,1,1);

 ///////////////////////////////// GLOBALS /////////////////////////////////
 //////////////// put thme ahead of include asl modules //////////////
 ///   all procs/funcs  should be after globals and before main
 //

  int Nrecrd = 0;
  int i = 0;
  Str ans="xyz";
  nrecdays = 730;   
  Vec<double> Vtst(10,10,1);

  Vec<float> DVEC(nrecdays,0,1); // day 1 in year is array ele 0 in DVEC ?

  Vec<float> DFVEC(nrecdays);

  Vec<float> DXVEC(nrecdays);

  Vec<float> WTVEC(nrecdays);
//Vec<float> PWTVEC(nrecdays) ;

  Vec<float> WTPMV(nrecdays);

  Vec<float> GVEC(nrecdays); // goal line;

  Vec<float> BPVEC(nrecdays);

  Vec<float> SEVEC(nrecdays);

  Vec<float> CARBV(nrecdays);

  Vec<float> WDVEC(nrecdays);

  Vec<float> EXTV(nrecdays);

  Vec<float> AVE_EXTV(nrecdays);

  Vec<float> EXEBURN(nrecdays);

  Vec<float> CALSBURN(nrecdays);

  Vec<float> CALSCON(nrecdays);

  Vec<float> CALSDEF(nrecdays);

  Vec<float> CARDIO(nrecdays);

  Vec<float> STRENGTH(nrecdays);
// cals,carbs consumed & when



  Vec<float> CARBSCON(nrecdays);

  Vec<float> FATCON(nrecdays);

  Vec<float> PROTCON(nrecdays);

  Vec<float> FIBRCON(nrecdays);

  Vec<float> GLUCOSE(nrecdays);

  Vec<float> KETONE(nrecdays);

  Vec<float> GKI(nrecdays);

////////////////////////////////////////////////////

  int Wex_Nrecs;
  
  float Nsel_exemins = 0.0;

  float Nsel_exeburn = 0.0;

  float Nsel_lbs = 0.0;


  //<<[_DB]"$Mo \n";

  float WXY[20];

  char sep = 47;

  float minWt = 160;

  float upperWt = 205;  // this is way too much
//StartWt = 205;
// rates per min

 float   GoalWt = 175;  // ideal -- flying weight

 float   StartWt = 205;

 float   MinWt = 160;

  Str today;

 // today = date(2);

  long jtoday;
  long maxday;
  
  Str Year;

  long Bday;  // birthday;
  
  int lday;  // last day recorded in file;

  int dday;

  long Jan1;  // get the current year;

  long Yday ;
  long Yd ;
  long YesterYd;
  
  long sc_endday;

//////////////////////  Set Dates /////////////////////////////////

  long tday2,Sday,Sday2,yday,eday;


//  Str emsg;

  Svar GoalsC;
   


  int NCCobs =0;
  int NCCrecs = 0;

int Wex_CR_init = 1;
int Wex_CL_init = 1;

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
  
  int FirstGoalWt;
  int TargetGoalWt;
  float mid_date;



  Record RCC; // TBC has to be at least 1;

  int kdays;
  long jd;
  Str the_date;
  float hlng;
  int do_all_gls =0;
  Str mdy;
  Vec<float> RS(25);


//////////////////// GLINES /////////////////
  int calc_gl,calb_gl,cald_gl, carb_gl,fibre_gl,fat_gl,prot_gl,se_gl,bp_gl,pwt_gl,ext_gl, gw_gl,wt_gl,lc_gl,rc_gl;



#include "compute_wex.asl"

#include "read_wex.asl"


//////////////////////  SCREEN ///////////////////////////
#include "wevent.asl"
// use Gevent asl variable and vmf (member methods)  == cpp compatible


#include "tbqrd.asl"

  int wScreen = 0;
//////////////////////  WOS ///////////////////////////

//wdb=DBaction((DBSTEP_),ON_)


  int Symsz= 5;
//=========================================
  float CalsY1 = 5000.0;

  float carb_upper = 300;

  int sc_end ;

  long sc_zend ;   // for zooming;

  long sc_zstart;
  long sc_startday;
  float lcpx = 0.0;
  float rcpx = 10.0;

////////////////////////////////////////  routines //////////////////////////////



  int N = 1000;


//  float DVEC[200+];
//  let's use 400 to contain the year [1] will be first day
//  [365] or [366] will be the end year


  int vp,vp1;
  int wt_wo,cal_wo,calcwo,food_wo,carb_wo;
  int bpwo,tw_wo,zinwo,zoomwo;
  int nobswo,xtwo,xbwo,xlbswo,dlbswo;
  int dtmwo,obswo,calburnwo,calcon,xtmwo,sdwo,gdwo,gwt_wo,wtmwo;


#include "draw_wex.asl"

#include "callbacks_wex.asl"

/////////////////////////////////////////////////  SET GOALS  ////////////////////////////////////////
///
///        long-term and current weight loss goals 
///
//  SET     START DATE      END DATE  TARGET WEIGHT
  
   yday = Julian("01/01/2026")   ; // this should be found from data file

   eday = Julian("12/31/2026");

  
  today = getDate(2);

 // today = date(2);

  jtoday = Julian(today);

  Year= getDate(YEAR_);

  //<<"%V $today $jtoday $Year\n";

  Bday = Julian("04/09/1949");

  Jan1 = Julian("01/01/2026");
  // Str adate ; adate.strPrintf("01/01/%s",Year.cptr()");

  Yday = jtoday -Jan1;

//cout << " Jan1 " << Jan1 << " Yday " << Yday  << endl;




///////////////////////////////////////////////////////////////////////


// days will days of year not Julian
   Str stmp;
   Svar Goals;
   
   Goals.Split("02/27/2026 04/09/2026 175");

//<<"Setting goals $Goals\n"

   Svar Goals2;
   
   Goals2.Split("02/27/2026  03/10/2026 180");
////////////////////==============/////////////////

// move these down 10 when reached -- until we are at desired operating weight!


   //COUT(Goals);

//ans=query("Goals ?");

   long tjd =  Julian(Goals[0]) ;
   

   //long sday = julian(Goals[0]) -Jan1 ; // start date

   Sday = tjd - Jan1;
   

   long tarxday = Julian(Goals[1]) -Jan1;
   long targetday = Julian(Goals[1]) -Jan1;

	  
//<<"%V $tjd $Jan1 $Sday $targetday  $tarxday; \n"

//   FirstGoalWt = atoi(Goals[2]);

   Sday2 = Julian(Goals2[0]) -Jan1 ; // start date

   tday2 = Julian(Goals2[1]) -Jan1;

   TargetGoalWt = atoi(Goals[2]);

   FirstGoalWt = atoi(Goals2[2]);

//   gsday = Sday;
   gsday = Sday ; // is Jan1 day0 or day1 in DVEC

   gday =  targetday;    // next goal day;

//COUT(gday);

//   Onwards();
  // context two weeks
  sc_startday = (jtoday - Jan1) -14  ;

  if (sc_startday <0)
     sc_startday =0;

//  sc_endday = targetday + 7;

    sc_endday = sc_startday + 42;
//   <<"%V$sc_startday $targetday $sc_endday \n"




   int got_start = 0;


   int ngday = 7;

   int k = eday - Sday;

   if ( k < 0) {

     //cout <<" time backwards !\n";

     exit_si();

     }

   kdays = k;

 //oknow = Ask ("que pasa? $_proc",1)

/////////////////////////////////////////////////  READ RECORDS ////////////////////////////////////////
  int n = 0;

  Mo.Split ("JAN,FEB,MAR,APR ,MAY,JUN, JUL, AUG, SEP, OCT, NOV , DEC",44);

  GoalsC.Split("02/01/2026 04/09/2026 175");


  maxday = Julian("04/09/2049") -Bday;
// this is a new format -- allowing us to put comment labels on graphs
//<<"%V $maxday \n"

  <<" $GoalsC \n"

//  Onwards();

  int A=ofr("~/GAPPS/DAT/wex.tsv");

  if (A == -1) {

  printf("FILE not found \n");

  exit_si();

  }
// check period

  Svar rx;

  Wex_Nrecs=RX.readRecord(A,_RDEL,-1);  // no back ptr to Siv?

 <<" readRecord  $Wex_Nrecs\n";

// reader in readRecord closes file

  //RX.pinfo();


  //<<"%V $Wex_Nrecs $RX[0] \n $(Caz(RX))  $(Caz(RX,0)) \n";


  //<<[_DB]"$RX[Nrecs-2]\n";
/*
  int irx = Wex_Nrecs -30;
  for (i = irx ; i < Wex_Nrecs; i++) {
       rx= RX[i];
       <<"$i  $rx \n"
  }
*/
 //  ans=query(" readRecord proceed?");
  
  k = 0;
///////////// Cals & Carb Consumed ////////
// so far not logged often 

  int ACC=ofr("~/GAPPS/DAT/ccfpf.tsv");

<<"%V $ACC\n"

  NCCrecs = 0;

  if (ACC == -1) {

  cout <<" no cc data!\n";

  }

  else {

  Nrecrd =RCC.readRecord(ACC,_RDEL,-1);  


 // cf(ACC);
 RCC->info(1);

  NCCrecs = RCC.getNrowsrd(); // this get size of record array - not num of records just read
  
  //cout << "NCCrecs " << NCCrecs << endl;
//ans = query("NCCrecs");
  //NCCrecs->info(1)

  <<"%V $NCCrecs $Nrecrd \n";

 for (i=0; i < Nrecrd ;i++) {
//  <<"[$i]  $RCC[i]       \n" ; // BUG
  }


ans= ask("readCCData %V $Nrecrd $NCCrecs proceed?",0);

  if (ans =="q") {
       exit()
  }
  NCCrecs = Nrecrd;
 // <<[_DB]"; /////////\n";

  }




////////////////// READ CEX DATA ///////////////////

     nrd= readData();

     nrd= readCCData();

//<<"exit  readCCData() $nrd \n"

  /////////////////////  part 1 ////////////////////////////

//ans= ask("after readCCData proceed?",1);

//   init_period = 32;



  float gwt = FirstGoalWt;
// ans=query("computeGoalLine()?");


  
////////////////////////////////////////////////////////////////////////

 //ans=query("do predict?");

  float sw2 = 205;

  float gw2 = 170;

  //COUT(gw2);


//////////////////   Predicted Wt   //////////////////////////////////
// (cal_consumed - cal_burn) / 4000.0    is wt gain in lbs
//  if no cal_burn registered for the day assume no exercise
//  if no cal_consumed assume  typical day_burn + 200 
//         first_k = ty_gsday
      //   first_k = 220
/////////////////////////////////////////////////////////////////////

float ae = EXTV[15];

 //COUT(ae);

   AVE_EXTV = EXTV;

  ae = AVE_EXTV[15];

// COUT(ae);

   //AVE_EXTV.pinfo();


   AVE_EXTV.Smooth(7);  // add Smooth (smooth_win_size)

   ae = AVE_EXTV[15];


  predictWL();


   openDll("plot");

  int Graphic = checkGWM();

  //Graphic.pinfo();

  int Xgm;

  if (!Graphic) {


#if _ASL_
    Xgm = spawnGWM("WEX");
    Graphic = checkGWM();
#endif

#if _CPP_
    Xgm = spawnGWM("WEX");
    Graphic = checkGWM();
#endif



}


  printf("Have Graphic %d now\n", Graphic);


#include "screen_wex.asl"

#include "glines_wex.asl"



//ans=Ask("  proceed?",1);

   computeGoalLine();
 

  lcpx = sc_startday;
  rcpx = sc_endday;

 ans=Ask(" draw screens proceed?",0);

  drawScreens();
//

  showTarget();



 // drawScreens();


//  <<" %(1,,,\n) $EXTV \n"
  Str tit_msg = "Tomorrow's wt will be %6.2f $PWT1 +week $PWT7  + fortnight $PWT14"
 

  titleMessage(vp,tit_msg)

//ans=Ask(" show target proceed?",1);

 int nevent = 0;



  int rcb = 0;

     oknow = Ask ("que pasa? %V $Nrecrd $Yd",0)      

     Graphic = checkGWM();

     sel_day = Yd

     getDay(sel_day)


     while (Graphic) {

        showTarget();


         eventWait(-1);

         nevent++;

<<"$nevent $ewoname_ \n"
       //ans = ask("$nevent $ewoname_ \n",1)

         getDay(sel_day)
	 
      if (ewoname_ == "REDRAW") {
             drawScreens();
       }

       else if (ewoname_ == "RESIZE") {
             drawScreens();
       }
     // else if (ewoname_ == "ZIN") {
    //  <<" calling ZIN"
     //         ZIN(ebutton)
    //   }       
       else if (ebutton_ > 0)       {
       
         <<"trying  $ewoid_ $ewoname_ $ebutton_ \n"
       
         if ((ewoname_ == "WTLB") || (ewoname_ == "ZIN") || (ewoname_ == "ZOUT")) {
           rcb= $ewoname_(ebutton_)
         }

            //rcb=runproc(ewoname_,ebutton_)

            // ZIN(); ZOUT , WTLB
       }

	 if (nevent > 2000) {
	   break;
	   }
     }

  exitGS(1)
  exit(0)

#if _CPP_
}  
#endif

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
//  12/28/25 - show yesterday's values - add calorie deficit measure

//  retry cpp version
//  
/////////////////////  TBDFC ///////////////////////
// redraw,resize not re-displaying 1/9/2026 

;//==============\_(^-^)_/==================//;
