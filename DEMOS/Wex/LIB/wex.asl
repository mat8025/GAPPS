/* 
 *  @script wex.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 2.52 Te Tellurium [asl 6.3.38 C-Li-Sr] 
 *  @date 07/02/2021 15:24:19 
 *  @cdate Fri Jan 1 08:00:00 2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                       


///
/// exercise weight display
/// calories burned (wt at 180)
/// Walk 4mhr 397, Hike 477, R 10mhr 795 Cycle 12mhr 636  Wt lift 350
/// Scuba   556   Gardening 318
/// sleep 8 hours   71.5 per hour
/// office computer work (24-8-exercise hours) 119.3 per hour



#include "debug"
#include "hv"

if (_dblevel >0) {
    debugON()
   }




allowErrors(-1)
_DB =-1;

//<<[_DB]"%V$vers $ele_vers\n"


//#define DBPR  ~!

wexdir = "./"

chdir(wexdir)

//wherearewe=!!"pwd "

//<<[_DB]"%V$wherearewe \n"


/*

class Activity {

 public:

 int type;
 uint duration;  //  secs
 float distance;  // Km 
 float speed;
 int intensity;

}
//--------------------------------------------------

class Measure {
 public:

 int type;
 float weight;  // kg
}
//

*/

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
#include "wex_rates"
#include "wex_types"






N = 1000

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

int bday;  // birthday 
int lday;  // last day recorded in file
int dday;

 bday = julian("04/09/1949")


 str bdate = "04/09/1949"
 //bday = julian(bdate)

<<[_DB]"%V $bdate  $bday \n"

 maxday = julian("04/09/2049") -bday

// this is a new format -- allowing us to put comment labels on graphs

<<[_DB]"%V $maxday \n"


 A=ofr("DAT/wex2021.tsv")

 
if (A == -1) {
<<"FILE not found \n"
  exitsi();
}


// check period

svar rx;
//rx->pinfo()

Record RX[];

RX=readrecord(A,@del,-1)

Nrecs = Caz(RX);

<<[_DB]"%V $Nrecs $RX[0] \n $(Caz(RX))  $(Caz(RX,0)) \n"

<<[_DB]"$RX[Nrecs-2]\n"
 rx= RX[Nrecs-1]
 
<<"$RX[Nrecs-1]\n"
<<[_DB]"$rx\n"

lastRX = RX[Nrecs-1]

  <<[_DB]"%V$lastRX\n"

//lastRX->pinfo();

chkT(1)


    //WDVEC= vgen(_INT_,2*kdays,0,1);

    n = 0;
    k = 0;
///////////// Cals & Carb Consumed ////////
// so far not logged often 



 //ACC=ofr("DAT/ccwx.tsv")

ACC=ofr("DAT/cc2021.tsv")

Record RCC[];

NCCrecs = 0;
if (ACC == -1) {
 <<" no cc data!\n"

}
else {

  RCC=readrecord(ACC)
  
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

/*
first_k = 0

//         end_k = first_k + 90;
         end_k = first_k + 30;

         last_wt = last_known_wt

         last_cal_out = day_burn
         last_cal_in =  day_burn
         cal_in_strike = 0
         cal_out_strike = 0
         strike_n = 10  // continue trend for 30 days
      

         j = first_k

         while (j > 0) {
//<<[_DB]"%V $j $WTVEC[j] \n"
          if (WTVEC[j] > 0) {
           last_known_wt = WTVEC[j]
//<<[_DB]"%V $j $last_known_wt \n"
           break
          }
         j--

         }


       for (k = first_k; k <= end_k ; k++) {

          if (CALBURN[k] > 0.0) {
              cal_out = CALBURN[k]
              last_cal_out = cal_out
              cal_out_strike = 0
          }
          else {

              if (cal_out_strike < strike_n) {
                cal_out = last_cal_out
              }
              else {
                cal_out =  day_burn + 100
              }

              cal_out_strike++
          }

              if (cal_in_strike < strike_n) {
                cal_in = last_cal_in
              }
              else {
               cal_in = day_burn 
              }
              cal_in_strike++

          calc_wtg = (cal_in - cal_out) / 4000.0

          last_wt +=   calc_wtg 

          PWTVEC[k] = last_wt

     <<"day $k %V $PWTVEC[k] $CALSCON[k] $CALBURN[k]\n"
    // PWTVEC->info(1)
    CALSCON->info(1)
        }

*/
/////////////////////////////////////////////////////////////////////


    AVE_EXTV = vsmooth(EXTV,7)

//<<[_DB]" Done calcs !\n"
//<<[_DB]"$Nxy_obs total exeburn %6.2f $tot_exeburn  cals  $(tot_exeburn/4000.0) lbs in $(tot_exetime/60.0) hrs\n"



//////////////////// DISPLAY /////////////////////////////


#include "gevent"

<<"%V $_eloop\n"

#include "graphic"

msg ="x y z"     // event vars
msgw =split(msg)


<<[_DB]"%V$msgw \n"



#include "wex_screen"

#include "wex_draw"

#include "wex_glines"

//ans=query("proceed?")
//sleep(0.1)


///////////////////////// PLOT  ////////////////////////////////////////////
//  

#include "wex_compute";
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
/*
ans=query("proceed?")
resize_screen();
ans=query("proceed?")
drawScreens();
ans=query("proceed?")
*/

showTarget();
//ans=query("proceed?")
  titleVers();


_DB=-1;




   

<<"%V $_eloop\n"
  sWi(vp,@resize,0.05,0.1,0.9,0.95,0);
    // drawScreens();
//ans=query("proceed?")

 sWo(tw_wo,@move,targetday,NextGoalWt,gwo,@redraw));

 sWi(vp,@redraw)
      drawScreens();
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