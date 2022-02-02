/* 
 *  @script wex.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 2.53 I 6.3.78 C-Li-Pt 
 *  @date 01/31/2022 08:56:58          
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


#include "debug"
#include "hv"
#include "tbqrd.asl"  //

//if (_dblevel >0) {
//    debugON()
//   }


filterFuncDebug(REJECT_,"pushsivele","storer","varIndex","var_sindex","init");



allowErrors(-1)
_DB =-1;

//<<[_DB]"%V$vers $ele_vers\n"


//#define DBPR  ~!

!!"xset fp+ /home/mark/gasp-CARBON/fonts "

wexdir = "./"

chdir(wexdir)

//wherearewe=!!"pwd "

//<<[_DB]"%V$wherearewe \n"


#define WALK 1
#define HIKE 2
#define RUN 3
#define BIKE 4
#define SWIM 5
#define GYM_SS 6
#define GYM_WTS  7


#define NDAYS 1000

svar Mo[] = { "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC"}

<<[_DB]"$Mo \n"


float WXY[];



//char sep = '/'
char sep = 47;


today = getDate(2,sep)

today = date(2);

jtoday = julian(today)

<<[_DB]"%V $today $jtoday \n"


float minWt = 160;
float upperWt = 225;
//StartWt = 205;

// rates per min


#include "wex_types"

<<"Done include of types\n";

#include "wex_rates"





N = 1000;

//float DVEC[200+];

long LDVEC[>10]
float DVEC[>10];
float DFVEC[>10];
float DXVEC[>10];

float WTVEC[>10] 

float PWTVEC[>10] 


float WTPMV[>10] 
float GVEC[>10]; // goal line
float BPVEC[>10] 
float SEVEC[>10] 
float CARBV[>10] 
float WDVEC[>10]
float EXTV[>10]
float AVE_EXTV[>10]
float EXEBURN[>10]
float CALBURN[>10]
float CARDIO[>10]
float STRENGTH[>10]



// cals,carbs consumed & when
float CALSCON[>10]
float CARBSCON[>10]
float FATCON[>10]
float PROTCON[>10]
float FIBRCON[>10]
float CCDV[>10]
///

float Nsel_exemins = 0.0
float Nsel_exeburn = 0.0

float Nsel_lbs = 0.0

<<[_DB]"%V $Nsel_exemins $Nsel_exeburn  $(typeof(Nsel_exemins))\n"

int k = 0;

long bday;  // birthday 
int lday;  // last day recorded in file
int dday;

 bday = julian("04/09/1949")


 str bdate = "04/09/1949"
 //bday = julian(bdate)

<<"%V $bdate  $bday \n"

 maxday = julian("04/09/2049") -bday

// this is a new format -- allowing us to put comment labels on graphs

<<"%V $maxday \n"


 A=ofr("DAT/wex2022.tsv")

 
if (A == -1) {
<<"FILE not found \n"
  exitsi();
}


// check period

svar rx;
//rx->pinfo()

Record RX[1];

//RX=readrecord(A,@del,-1)
RX.readrecord(A,@del,-1)
//cf(A);
RX.pinfo();
//!a
Nrecs = Caz(RX);

<<"%V $Nrecs $RX[0] \n $(Caz(RX))  $(Caz(RX,0)) \n"

<<[_DB]"$RX[Nrecs-2]\n"
 rx= RX[Nrecs-1]
 
<<"$RX[Nrecs-1]\n"
<<[_DB]"$rx\n"

lastRX = RX[Nrecs-1]

  <<"%V$lastRX\n"
//!a
//lastRX->pinfo();

chkT(1)


    //WDVEC= vgen(_INT_,2*kdays,0,1);

    n = 0;
    k = 0;
///////////// Cals & Carb Consumed ////////
// so far not logged often 





ACC=ofr("DAT/cc2022.tsv")

Record RCC[1]; // TBC has to be at least 1

NCCrecs = 0;
if (ACC == -1) {
 <<" no cc data!\n"

}
else {

  RCC.readrecord(ACC)
  
  cf(ACC)
  //RCC->info(1);
  NCCrecs = Caz(RCC);
  //NCCrecs->info(1)
  <<"%V $NCCrecs \n"

 for (i=0; i < NCCrecs ;i++) {
  <<[_DB]"$RCC[i] \n"
  }

<<[_DB]"/////////\n"
}
////////////////// READ CEX DATA ///////////////////


#include "wex_goals"
#include "wex_read"


readCCData();


nrd=readData();
//<<"%V$nrd\n"




////////////// PLOT GOAL LINE  ///////////////////////////////////////////

//    sc_endday = lday + 10
//    sc_endday = 75 * 365

// 
   init_period = 32;

 //  long sc_startday = (jtoday - bday) - 20;
   long sc_startday = (jtoday - bday) - 20;

   long sc_endday = targetday + 10;

   <<[_DB]"%V$ngday \n"

  gwt = NextGoalWt;

  computeGoalLine()
  

////////////////////////////////////////////////////////////////////////


  sw2 = 205
  gw2 = 170

  cf(A);


#include "wex_foodlog"


//////////////////   Predicted Wt   //////////////////////////////////

// (cal_consumed - cal_burn) / 4000.0    is wt gain in lbs
//  if no cal_burn registered for the day assume no exercise
//  if no cal_consumed assume  typical day_burn + 200 

//         first_k = ty_gsday

      //   first_k = 220

/////////////////////////////////////////////////////////////////////


    AVE_EXTV = vsmooth(EXTV,7)

//<<[_DB]" Done calcs !\n"
//<<[_DB]"$Nxy_obs total exeburn %6.2f $tot_exeburn  cals  $(tot_exeburn/4000.0) lbs in $(tot_exetime/60.0) hrs\n"

#include "wex_compute";

 PWT=predictWL();


//////////////////// DISPLAY /////////////////////////////




#include "graphic"




msg ="x y z"     // event vars
msgw =split(msg)


<<[_DB]"%V$msgw \n"



#include "wex_screen"

#include "wex_draw"

#include "wex_glines"


  titleVers();

#include "gevent"

//ans=query("proceed?")
//sleep(0.1)

<<"%V $_eloop\n"


///////////////////////// PLOT  ////////////////////////////////////////////
//  






#include "wex_callbacks";


int wScreen = 0
float Rinfo[30]



//<<[_DB]"%(7,, ,\n)$CALBURN \n"
//<<[_DB]"%(7,, ,\n)$CALCON \n"

int m_num = 0
int button = 0

   Keyw = ""
 

   lcpx = sc_startday
   rcpx = sc_endday

   sGl(lc_gl,@cursor,lcpx,0,lcpx,300)

   sGl(rc_gl,@cursor,rcpx,0,rcpx,300)



  ZIN(); // goes in does'nt leave -- proc stack error

woname = ""


showTarget();


  titleVers();


_DB=-1;




   

<<"%V $_eloop\n"

    // drawScreens();
//ans=query("proceed?")
 resize_screen()

 sWo(tw_wo,@move,targetday,NextGoalWt,gwo,@redraw));

 sWi(vp,@redraw);
 
      drawScreens();
//ans=query("%V$last_known_day")

    getDay(last_known_day);

   CR_init = 1; sGl(rc_gl,@cursor,last_known_day,0,last_known_day,300, CR_init); CR_init = 0;
	 
//mc=getMouseEvent();
while (1) {

     //if ((m_num % 50) ==0) {
      //  resetDebug();
//	}

     m_num++
//sleep(0.05)
/*
   if (m_num == 1) {
      drawScreens();
     // setCursors();
       }
*/
        msg =eventWait();
<<[2]"$m_num $msg  $_ename $_ewoname\n"

       if (_ename == "PRESS") {
      // ans=iread(">>");
<<"calling function via <|$_ewoname|> !\n"
     if (_ewoname != "") {

           // $_ewoname()
        }
      }

       if (_emsg == "EXIT") {
        <<"leaving WEX !\n"
	 break;
       }


       if (_ewoname == "WTLB") {

               WTLB();
       }
       
       else if (_ewoname == "RESIZE") {
       <<" RESIZE\n"
         drawScreens();
      }

      else if (_ewoname == "REDRAW") {
         drawScreens();
      }


      else if (_ewoname == "StartDay") {
           setGoals()
      }

      else if (_ewoname == "GoalDay") {
           setGoals()
      }

      else if (_ewoname == "WtGoal") {
           setGoals()
      }

      else if (_ekeyw != "") {

        <<[_DB]"calling |${_ekeyw}| $(typeof(_ekeyw))\n"
         $_ekeyw()
	 
       }

        <<[_DB]"%V$lcpx $rcpx \n"

       WXY=WoGetPosition(tw_wo)
<<"$WXY \n"

    //   place_curs( gwo,100,5,1,1)

   }



exit()

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
