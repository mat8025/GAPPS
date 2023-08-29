/* 
 *  @script wex.asl                                                     
 * 
 *  @comment exercise/diet logger cpp vers                              
 *  @release CARBON                                                     
 *  @vers 2.56 Ba Barium [asl 6.4.31 C-Be-Ga]                           
 *  @date 06/17/2022 07:54:49                                           
 *  @cdate Fri Jan 1 08:00:00 2010                                      
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
//----------------<v_&_v>-------------------------//;                  

  Str Wex_Vers= "2.61  ";

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

#if_ ASL_
#define cout //
#define COUT //
#define VCOUT //
#endif


 Svar Mo;
//#include "hv.asl"


#include "rates_wex.asl"





 //float DVEC = vgen(FLOAT_,400,1,1);

 ///////////////////////////////// GLOBALS /////////////////////////////////
 //////////////// put thme ahead of include asl modules //////////////
 ///   all procs/funcs  should be after globals and before main
 //


  int i = 0;
  Str ans="xyz";
  
  Vec<double> Vtst(10,10,1);

  Vec<float> DVEC(400,1,1);

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

  Vec<float> CALSCON(400);


  Vec<float> CARDIO(400);

  Vec<float> STRENGTH(400);
// cals,carbs consumed & when



  Vec<float> CARBSCON(400);

  Vec<float> FATCON(400);

  Vec<float> PROTCON(400);

  Vec<float> FIBRCON(400);
////////////////////////////////////////////////////

  int Wex_Nrecs;
  
  float Nsel_exemins = 0.0;

  float Nsel_exeburn = 0.0;

  float Nsel_lbs = 0.0;


  //<<[_DB]"$Mo \n";

  float WXY[20];

  char sep = 47;

  float minWt = 150;

  float upperWt = 235;  // this is way too much
//StartWt = 205;
// rates per min

 float   GoalWt = 175;  // ideal -- flying weight

 float   StartWt = 215;

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

  long sc_endday;

//////////////////////  Set Dates /////////////////////////////////

  long tday2,Sday,Sday2,yday,eday;


  Str emsg;

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
  
  int NextGoalWt;
  int FirstGoalWt;
  float mid_date;

  float   DX_NEW = 200.0;  // never exceed

  float   DX_MEW = GoalWt+5;  // max dx effort above

  Record RCC; // TBC has to be at least 1;

  int kdays;
  long jd;
  Str the_date;
  float hlng;
  int do_all_gls =0;
  Str mdy;
  Vec<float> RS(25);


//////////////////// GLINES /////////////////
  int calc_gl,calb_gl,carb_gl,fibre_gl,fat_gl,prot_gl,se_gl,bp_gl,pwt_gl,ext_gl, gw_gl,wt_gl,lc_gl,rc_gl;



#include "compute_wex.asl"

#include "read_wex.asl"


//////////////////////  SCREEN ///////////////////////////
//#include "gevent.asl"
// use Gevent asl variable and vmf (member methods)  == cpp compatible


#include "tbqrd.asl"

  int wScreen = 0;
//////////////////////  WOS ///////////////////////////




  int Symsz= 5;
//=========================================
  float CalsY1 = 5000.0;

  float carb_upper = 200;

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
  int wtwo,calwo,calcwo,carbwo,extwo;
  int swo,tw_wo,zinwo,zoomwo;
  int nobswo,xtwo,xbwo,xlbswo,dlbswo;
  int dtmwo,obswo,cbmwo,xtmwo,sdwo,gdwo,gwtwo,wtmwo;


#include "draw_wex.asl"

#include "callbacks_wex.asl"


  



/////////////////////////////////////////////////  SET GOALS  ////////////////////////////////////////
///
///        long-term and current weight loss goals 
///
//  SET     START DATE      END DATE  TARGET WEIGHT


  
   yday = Julian("01/01/2023")   ; // this should be found from data file

   eday = Julian("12/31/2023");

  
  today = getDate(2);

 // today = date(2);

  jtoday = Julian(today);

  Year= getDate(YEAR_);

  //<<"%V $today $jtoday $Year\n";

  Bday = Julian("04/09/1949");

  Jan1 = Julian("01/01/2023"); // Str adate ; adate.strPrintf("01/01/%s",Year.cptr()");

  Yday = jtoday -Jan1;

//cout << " Jan1 " << Jan1 << " Yday " << Yday  << endl;




///////////////////////////////////////////////////////////////////////


// days will days of year not Julian
   Str stmp;
   Svar Goals;
   
   Goals.Split("07/21/2023 09/30/2023 175");

//<<"Setting goals $Goals\n"

   Svar Goals2;
   
   Goals2.Split("07/21/2023 08/31/2023 185");
////////////////////==============/////////////////

// move these down 10 when reached -- until we are at desired operating weight!


   //COUT(Goals);

//ans=query("Goals ?");

   long tjd =  Julian(Goals[0]) ;
   

   //long sday = julian(Goals[0]) -Jan1 ; // start date

   Sday = tjd - Jan1;
   

   long tarxday = Julian(Goals[1]) -Jan1;
   long targetday = Julian(Goals[1]);

   targetday -= Jan1;
	  
//<<"%V $tjd $Jan1 $Sday $targetday  $tarxday; \n"



   NextGoalWt = atoi(Goals[2]);

   Sday2 = Julian(Goals2[0]) -Jan1 ; // start date

   tday2 = Julian(Goals2[1]) -Jan1;

   FirstGoalWt = atoi(Goals[2]);

   NextGoalWt = atoi(Goals2[2]);

   gsday = Sday;

   gday =  targetday;    // next goal day;

COUT(gday);

//   Onwards();

  sc_startday = (jtoday - Jan1) -10;

  if (sc_startday <0)
     sc_startday =0;

//  sc_endday = targetday + 7;

    sc_endday = sc_startday + 30;
//   <<"%V$sc_startday $targetday $sc_endday \n"




   int got_start = 0;


   int ngday = 7;

   int k = eday - Sday;

   if ( k < 0) {

     //cout <<" time backwards !\n";

     exit_si();

     }

   kdays = k;

/////////////////////////////////////////////////  READ RECORDS ////////////////////////////////////////
  int n = 0;

  Mo.Split ("JAN,FEB,MAR,APR ,MAY,JUN, JUL, AUG, SEP, OCT, NOV , DEC",44);

  GoalsC.Split("04/15/2023 08/31/2023 175");


  maxday = Julian("04/09/2049") -Bday;
// this is a new format -- allowing us to put comment labels on graphs
//<<"%V $maxday \n"

  <<" $GoalsC \n"

//  Onwards();

  int A=ofr("~/gapps/DAT/wex2023.tsv");

  if (A == -1) {

  printf("FILE not found \n");

  exit_si();

  }
// check period

  Svar rx;

  Wex_Nrecs=RX.readRecord(A,_RDEL,-1,_RLAST);  // no back ptr to Siv?

//  <<" readRecord  $Wex_Nrecs\n";

// reader in readRecord closes file

//  RX.pinfo();

//   pa (Wex_Nrecs);


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

  int ACC=ofr("~/gapps/DAT/cc2023.tsv");

<<"%V $ACC\n"

  NCCrecs = 0;

  if (ACC == -1) {

  cout <<" no cc data!\n";

  }

  else {

  int nrc =RCC.readRecord(ACC,_RDEL,-1);  


 // cf(ACC);
  //RCC->info(1);

  NCCrecs = RCC.getNrows();
  
  //cout << "NCCrecs " << NCCrecs << endl;
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



//<<"exit  readCCData() $nrd \n"

//   <<" CC $nrd\n" ;

    nrd= readData();


 //   <<" $nrd \n"
  /////////////////////  part 1 ////////////////////////////

//ans=query("after readData proceed?");

//   init_period = 32;



  float gwt = NextGoalWt;
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

/*
 ans=query("after predict proceed with Graphics?");

 if (ans != "y") {
    exit()
 }
*/
   openDll("plot");

  int Graphic = checkGWM();

  Graphic.pinfo();

  int Xgm;

  if (!Graphic) {
#if _TRANS_  
     <<" no Graphics while TRANS  $_TRANS_ \n"
#endif

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

   computeGoalLine();
 

  lcpx = sc_startday;
  rcpx = sc_endday;
  
  drawScreens();

  showTarget();


  drawScreens();


//  <<" %(1,,,\n) $EXTV \n"

 titleMessage("Tomorrow's wt will be %6.2f $PWT1 +week $PWT7  + month $PWT30")


int nevent = 0;

 //ans=query(" screen interact proceed?");
drawScreens();
int rcb = 0;

     Graphic = checkGWM();

      

     while (Graphic) {


       eventWait();



         nevent++;
  
       
      if (GEV__woname == "REDRAW") {
             drawScreens();
       }

       else if (GEV__woname == "RESIZE") {
             drawScreens();
       }
       else {
         <<"trying $GEV__woname $GEV__button \n"
            rcb=runproc(GEV__woname,GEV__button)
            // ZIN(); ZOUT , WTLB
       }


 // if (Button == 1 || Button == 3) 
 //         WTLB();


	 if (nevent > 2000) {
	   break;
	   }
     }



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
//

;//==============\_(^-^)_/==================//;
