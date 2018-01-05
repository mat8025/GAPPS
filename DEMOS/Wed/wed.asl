///
/// exercise weight display
/// calories burned (wt at 180)
/// Walk 4mhr 397, Hike 477, R 10mhr 795 Cycle 12mhr 636  Wt lift 350
/// Scuba   556   Gardening 318
/// sleep 8 hours   71.5 per hour
/// office computer work (24-8-exercise hours) 119.3 per hour


vers = "2.0";

envdebug();

setDebug(1);

//#define DBPR  <<

#define DBPR  ~!

wed_dir = "./"

chdir(wed_dir)

wherearewe=!!"pwd "

//<<"%V$wherearewe \n"


#define WALK 1
#define HIKE 2
#define RUN 3
#define BIKE 4
#define SWIM 5
#define TRDMILL 6
#define WTLIFT  7

#define NDAYS 1000

svar Mo[] = { "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC"}


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

char sep = '/'
today = getDate(2,sep)

jtoday = julday(today)

DBPR"$today $jtoday \n"


minWt = 160;
topWt = 210;
//StartWt = 205;

// rates per min
include "wed_rates"



N = 1000

//float DVEC[200+];

long LDVEC[10+]
float DVEC[10+]
float DFVEC[10+]
float DXVEC[10+]

float WTVEC[10+] 

float PWTVEC[10+] 

float WTPMV[10+] 
float GVEC[10+]; // goal line
float BPVEC[10+] 
float SEVEC[10+] 
float CARBV[10+] 
float WDVEC[10+]
float EXTV[10+]
float AVE_EXTV[10+]
float EXEBURN[10+]
float CALBURN[10+]
float CALCON[10+]

float Nsel_exemins = 0.0
float Nsel_exeburn = 0.0

float Nsel_lbs = 0.0

<<"%V $Nsel_exemins $Nsel_exeburn  $(typeof(Nsel_exemins))\n"

int k = 0;

int bday;  // birthday 
int lday;  // last day recorded in file
int dday;

 bday = julday("04/09/1949")
 maxday = julday("04/09/2049") -bday

// this is a new format -- allowing us to put comment labels on graphs

 A=ofr("wfex.dat")

 
if (A == -1) {
<<"FILE not found \n"
  exitsi();
}

<<"%V$A \n"
// check period



    //WDVEC= vgen(_INT_,2*kdays,0,1);

    n = 0
//<<"%V$A \n"

    S= readline(A)

    foe= ferror(A)

//<<"%V$A $foe\n"

  k =0

//  lpd = (sw2-gw2)/ (ng2day * 1.0)
//long wday






////////////////// READ CEX DATA ///////////////////
#include "wed_goals"
#include "wed_read"



////////////// PLOT GOAL LINE  ///////////////////////////////////////////

//    sc_endday = lday + 10
//    sc_endday = 75 * 365


      sc_endday = (jtoday - bday) + 60;

   DBPR"%V$ngday \n"

  gwt = NextGoalWt;

  GVEC[0] = 0.0;

  GVEC[1] = NextGoalWt;

  //ty_gsday = gsday- (sday -bday);
  ty_gsday = gsday;


  GVEC[0] = StartWt;  // start  Wt

  GVEC[ngday-1] = gwt;  // goal wt
  WDVEC[ngday-1] = gsday+ngday;
  k =0

//  lpd = 1.75/7.0      // 1.75 lb a  week

  lpd = 4.0/7.0;      // 5 lb a  week
  sw = StartWt;
  lw = sw;

// our goal line  wtloss per day!
  for (i= 0; i < ngday; i++) {
<<"$(ty_gsday+i) $lw \n"
    GVEC[i] = lw;
    WDVEC[i] = gsday+i;
    lw -= lpd;
    if (lw < 165.0)
        lw = 165;
  }

///  revised goal line
  sz = Caz(GVEC);
<<" days $sz to lose $(StartWt-gwt) \n"
  sz = Caz(WDVEC);

<<"$sz\n"
<<"%6.1f%(7,, ,\n)$WDVEC\n"
<<"%6.1f%(7,, ,\n)$GVEC\n"
////////////////////////////////////////////////////////////////////////

DBPR"%V$i $sz\n"

  sw2 = 205
  gw2 = 170

  cf(A);

include "wed_foodlog"


//////////////////   Predicted Wt   //////////////////////////////////

// (cal_consumed - cal_burn) / 4000.0    is wt gain in lbs
//  if no cal_burn registered for the day assume no exercise
//  if no cal_consumed assume  typical day_burn + 200 

//         first_k = ty_gsday

         first_k = 220

         end_k = first_k + 90;

         last_wt = last_known_wt

         last_cal_out = day_burn
         last_cal_in =  day_burn
         cal_in_strike = 0
         cal_out_strike = 0
         strike_n = 10  // continue trend for 30 days
      

         j = first_k

         while (j > 0) {
//DBPR"%V $j $WTVEC[j] \n"
          if (WTVEC[j] > 0) {
           last_known_wt = WTVEC[j]
//DBPR"%V $j $last_known_wt \n"
           break
          }
         j--

         }


       for (k = first_k; k <= end_k ; k++) {

          if (CALBURN[k] > 0.0) {
              cal_out = CALBURN[k]
//              cal_in = day_burn - 200
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

          if (CALCON[k] > 0.0) {
              cal_in = CALCON[k]
              last_cal_in = cal_in
              cal_in_strike = 0
          }
          else {

              if (cal_in_strike < strike_n) {
                cal_in = last_cal_in
              }
              else {
               cal_in = day_burn 
              }
              cal_in_strike++
              //CALCON[k] = cal_in  // make it the estimate
          }

          calc_wtg = (cal_in - cal_out) / 4000.0

          last_wt +=   calc_wtg 

          PWTVEC[k] = last_wt

    //   DBPR"day $k $PWTVEC[k] $CALCON[k] $CALBURN[k]\n"

        }
/////////////////////////////////////////////////////////////////////


    AVE_EXTV = vsmooth(EXTV,7)

//<<" Done calcs !\n"
<<"$Nxy_obs total exeburn %6.2f $tot_exeburn  cals  $(tot_exeburn/4000.0) lbs in $(tot_exetime/60.0) hrs\n"



//////////////////// DISPLAY /////////////////////////////
Graphic = CheckGwm()
 if (!Graphic) {
     X=spawngwm()
  }


msg ="x y z"     // event vars
msgw =split(msg)


DBPR"%V$msgw \n"


include "wed_draw"

include "wed_screen"

include "wed_glines"



///////////////////////// PLOT  ////////////////////////////////////////////
//  
//  DrawGline(ext_gl)
//  DrawGline(allgl)
//  sWo(carbwo,@showpixmap)

include "wed_compute";
include "wed_callbacks";


int wScreen = 0
float Rinfo[30]



//DBPR"%(7,, ,\n)$CALBURN \n"
//DBPR"%(7,, ,\n)$CALCON \n"

int m_num = 0
int button = 0

   Keyw = ""
 

   lcpx = sc_startday
   rcpx = sc_endday

   sGl(lc_gl,@cursor,lcpx,0,lcpx,300)

   sGl(rc_gl,@cursor,rcpx,0,rcpx,300)



   ZIN();

woname = ""
gevent E;
resize_screen();
drawScreens();
showTarget();



   while (1) {

        m_num++

        msg  = E->waitForMsg()
DBPR"got message\n $msg \n"
<<"got message\n $msg \n"
        msgw = split(msg)
        Keyw = E->getEventKeyw()
DBPR"$m_num $msg $Keyw \n"
       button = E->getEventButton()
DBPR"%V$button \n"
       woname = E->getEventWoname()
DBPR"%V$woname \n"
       Rinfo = E->getEventRinfo();
DBPR"%V$Rinfo\n"
       Evtype = E->getEventType()    

       if (Evtype @= "PRESS") {
        if (!(woname @= "")) {
DBPR"calling function via $woname !\n"
            $woname()
        }
      }

       if (Evtype @= "RESIZE") {
         drawScreens();
      }

        
       if (!(Keyw @= "")) {
         DBPR"calling |${Keyw}| $(typeof(Keyw))\n"
         $Keyw()        
       }

        DBPR"%V$lcpx $rcpx \n"

    //   place_curs( gwo,100,5,1,1)

   }


stop("Done!")
;

exit_si()

///////////////////////////////// TBD /////////////////////////
// date-day
// interpolate missing
// carb, cal lookup   carb,protein,fat proportions
// energy expenditure - run,walk, cycle  --- weight/resistance exercise
// 
// OO activity organizer
// XML for data
// trend prediction toward goal (wt,strength) done?
// scrollable windows
// text - events ( notable days, events)
//   organize in Quarters  JFM,  AMJ,  JAS, OND
//   (last month, current month, next)
//  bench press value, arm curl, lat pull ?? values
//
//  get today's date and set up view for this quarter
//  can we add comments
