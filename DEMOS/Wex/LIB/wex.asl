/* 
 *  @script wex.asl 
 * 
 *  @comment  
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


#include "debug"
//#include "hv"
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





float minWt = 160;
float upperWt = 225;




#include "wex_types"

#include "wex_rates"
// rates per min




N = 1000;

//float DVEC[200+];
//  let's use 400 to contain the year [1] will be first day
// [365] or [366] will be the end year 

float DVEC = vgen(FLOAT_,400,1,1);


float DFVEC[400];
float DXVEC[400];

float WTVEC[400] 

//float PWTVEC[400] 


float WTPMV[400];
float GVEC[400]; // goal line
float BPVEC[400] 
float SEVEC[400] 
float CARBV[400] 
float WDVEC[400]
float EXTV[400]
float AVE_EXTV[400]
float EXEBURN[400]
float CALBURN[400]
float CARDIO[400]

float XSTRENGTH[400]



// cals,carbs consumed & when
float CALSCON[400]
float CARBSCON[400]
float FATCON[400]
float PROTCON[400]
float FIBRCON[400]

////////////////////////////////////////////////////

float Nsel_exemins = 0.0
float Nsel_exeburn = 0.0

float Nsel_lbs = 0.0

<<[_DB]"%V $Nsel_exemins $Nsel_exeburn  $(typeof(Nsel_exemins))\n"

int k = 0;


today = getDate(2,sep)

today = date(2);

jtoday = julian(today)

Year= date(YEAR_);

<<"%V $today $jtoday $Year\n"


long Bday;  // birthday 
Bday = julian("04/09/1949")

int lday;  // last day recorded in file
int dday;

long Jan1;  // get they current year

Jan1 = julian("01/01/$Year")

Yday = jtoday -Jan1;

 Str bdate = "04/09/1949"
 //Bday = julian(bdate)

//<<"%V $bdate  $Bday $Jan1 \n"

 maxday = julian("04/09/2049") -Bday

// this is a new format -- allowing us to put comment labels on graphs

//<<"%V $maxday \n"


 A=ofr("DAT/wex2022.tsv")

 
if (A == -1) {
<<"FILE not found \n"
  exitsi();
}


// check period

Svar rx;
//rx->pinfo()

Record RX[400];

//RX=readrecord(A,@del,-1)

 //Nrecs =RX.readrecord(A,_DEL,-1)
 RX.readrecord(A)
 Nrecs = Caz(RX);

<<"%V $Nrecs $RX[0] \n\n"
  <<"%V $RX[1] \n"
  <<"%V $RX[2] \n"
  <<"%V $RX[3] \n"  
    <<"%V $RX[4] \n"  


RX.pinfo();

for (i=0; i < Nrecs ;i++) {
<<"$RX[i] \n"
  }


//ans=query("see rec proceed?");
//  if (ans == "n") {
//     exit(-1);
//   }


//cf(A);

//!a
Nrecs = Caz(RX);



<<[_DB]"$RX[Nrecs-2]\n"
 rx= RX[Nrecs-1]
 
//<<"$RX[Nrecs-1]\n"
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

Record RCC[400]; // TBC has to be at least 1

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
  <<"%V $RCC[0] \n"
  <<"%V $RCC[1] \n"
  <<"%V $RCC[2] \n"
  <<"%V $RCC[3] \n"  
    <<"%V $RCC[4] \n"  

  i = NCCrecs-1;

  <<"%V $i $RCC[i] \n"  

for (i=2; i < NCCrecs ;i++) {
<<"$RCC[i] \n"
  }


<<"/////////\n"
}



////////////////// READ CEX DATA ///////////////////


#include "wex_goals"
#include "wex_read"


nrd=readData();

<<"%V$nrd\n"

readCCData();



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

   PWT = predictWL();


//////////////////// DISPLAY /////////////////////////////




#include "graphic"




msg ="x y z"     // event vars
msgw =split(msg)


//<<[_DB]"%V$msgw \n"



#include "wex_screen"

#include "wex_draw"

#include "wex_glines"


  titleVers();

#include "gevent"

//ans=query("proceed?")
//sleep(0.1)

//<<"%V $Ev_loop\n"


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
 

   lcpx = sc_startday +4;
   rcpx = sc_endday -4;

   sGl(lc_gl,_GLCURSOR,lcpx,0,lcpx,300)

   sGl(rc_gl,_GLCURSOR,rcpx,0,rcpx,300)



  ZIN(); 

woname = ""


showTarget();


  titleVers();


_DB=-1;

   

<<"%V $Ev_loop\n"

    // drawScreens();
//ans=query("proceed?")
 resize_screen()

 sWo(tw_wo,_Wmove,targetday,NextGoalWt,wtwo,_Wredraw));

 sWi(vp,_Wredraw);
 
      drawScreens();
//ans=query("%V$last_known_day")

    getDay(last_known_day);

   CR_init = 1; sGl(rc_gl,_GLCURSOR,last_known_day,0,last_known_day,300, CR_init); CR_init = 0;
	 
//mc=getMouseEvent();

  Gevent gev;

  gev.pinfo();

// Ev_keyw.pinfo();
//Ev_name.pinfo();


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
       // msg =eventWait();
	
<<"%V $m_num $Ev_button \n";

<<" trying gev.eventWait() \n";

        gev.eventWait();

<<" got gev.Wait() \n";

//<<[2]"$m_num $msg  $Ev_name $Ev_woname\n"

//Ev_keyw.pinfo();

//Ev_name.pinfo();

       if (Ev_name == "PRESS") {
      // ans=iread(">>");
/*
     if (Ev_woname != "") {
<<"calling function via <|$Ev_woname|> !\n"
        $Ev_woname()
        }
*/

      }

       if (Ev_msg == "EXIT") {
        <<"leaving WEX !\n"
	 break;
       }


       if (Ev_woname == "WTLB") {
               WTLB();
       }
       
       else if (Ev_woname == "RESIZE") {
             drawScreens();
       }

      else if (Ev_woname == "REDRAW") {
         drawScreens();
      }


      else if (Ev_woname == "StartDay") {
           setGoals()
      }

      else if (Ev_woname == "GoalDay") {
           setGoals()
      }

      else if (Ev_woname == "WtGoal") {
           setGoals()
      }

      else if (Ev_woname == "ZIN") {
           ZIN()
      }

      else if (Ev_keyw != "") {

        <<"calling <|${Ev_keyw}|>  $(typeof(Ev_keyw))\n"
         $Ev_keyw()
	 
       }

        <<[_DB]"%V$lcpx $rcpx \n"

       WXY=WoGetPosition(tw_wo)
//<<"$WXY \n"

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
