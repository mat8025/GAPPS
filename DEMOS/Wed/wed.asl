//
// exercise weight display
// calories burned (wt at 180) Walk 4mhr 397, Hike 477, R 10mhr 795 Cycle 12mhr 636  Wt lift 350
// Scuba   556   Gardening 318
// sleep 8 hours   71.5 per hour
// office computer work (24-8-exercise hours) 119.3 per hour


//setdebug(1)

#define DBPR  <<
//#define DBPR  ~!

wed_dir = "./"

chdir(wed_dir)

wherearewe=!!"pwd "

<<"%V$wherearewe \n"

#define WALK 1
#define HIKE 2
#define RUN 3
#define BIKE 4
#define SWIM 5
#define TRDMILL 6
#define WTLIFT  7

#define NDAYS 1000

//svar Mo = { "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC"}

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

proc isData()
{
//<<"$S \n"

   dok = 1

   fword=""

   sscan(S,'%s',&fword) // get first word -non WS

   if (scmp(fword,"#",1)) {
       dok = 0
   }

   //<<"$fword $dok\n"

   return dok
}
//



char sep = '/'
today = getDate(2,sep)

jtoday = julday(today)

DBPR"$today $jtoday \n"

StartWt = 208
GoalWt = 170

// rates per min

rpm = 0.0166667

w_rate = 397.0 * rpm
h_rate = 477.0 * rpm
c_rate = 636.0 * rpm
run_rate = 795.0 * rpm
wex_rate = 350.0 * rpm
swim_rate = 477.0 * rpm
yard_rate =  318.3 *rpm

//  metabolic rate slowdown ??

metaf = 0.95

office_rate =  119.3 * rpm * metaf
sleep_rate = 71.5 * rpm  * metaf


sleep_burn = 8 * 60 * sleep_rate
office_burn = 16 * 60 * office_rate
day_burn = sleep_burn + office_burn


out_cal = day_burn * 5/4
in_cal =  day_burn * 3/4

<<"%V$out_cal $in_cal \n"

N = 1000

//float DVEC[200+];

long LDVEC[10+]
float DVEC[10+]
float DFVEC[10+]
float DXVEC[10+]

float WTVEC[10+] 

float PWTVEC[10+] 

float WTPMV[10+] 
float GVEC[10+] // goal line
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

int k = 0

int bday  // birthday 
int lday  // last day recorded in file
int dday

    bday = julday("04/09/1949")
    maxday = julday("04/09/2049") -bday

// this is a new format -- allowing us to put comment labels on graphs

A=ofr("wfex.dat")

<<"%V$A \n"



if (A == -1) {

<<"FILE not found \n"
  exitsi();
}

<<"%V$A \n"



//A=ofr("wed_2012.dat")

//  SET  START AND END DATES HERE
//  --



long sday = julday("4/1/2014")

got_start = 0

long yday = julday("1/1/2014")   // this should be found from data file
long eday = julday("12/31/2014")  // this should be found from data file
today = julday("$(date(2))")

// check period

<<"%V$yday  $eday $today  $(date(2))\n"

k = eday - sday

if ( k < 0) {
 DBPR" time backwards !\n"
 exit_gs()
}


kdays = k

DBPR"%V$kdays \n"

     WDVEC= Igen(2*kdays,0,1)

    n = 0
<<"%V$A \n"

    S= readline(A)

    foe= ferror(A)

<<"%V$A $foe\n"







//setdebug(1)
  k =0

//  lpd = (sw2-gw2)/ (ng2day * 1.0)



long wday

////////////////// READ CEX DATA ///////////////////


   S= readline(A)

   last_known_wt = 205

tl = 0

float tot_exeburn =0
float tot_exetime = 0

Nobs = 0
nxobs = 0



int Nxy_obs = 0


  while (1) {

   S= readline(A)
   tl++

   if (check_eof(A) ) {
     break
   }

   ll = slen(S)

 //  DBPR"$tl $ll  $S "

   if (ll < 9) {
        continue
   }


//   sscan(S,'%s',&fword) // get first word -non WS
//<<"%V$ll $fword\n"
//   if (!scmp(fword,"#",1)) { // not a comment



    if (isData()) {

      col= split(S)

//DBPR"$col \n"

    day = col[1]

    wday = julday(day) 

    if (!got_start) {
        sday = wday
        got_start = 1;
    }


    k = wday - bday

    lday = k

//DBPR"%V$day $wday  $k \n"

   if (k < 0) {
      <<" $k neg offset ! \n"
       break
   }

   else {

   // will need separate day vector for the food carb/protein/fat/calorie totals -(if we count/estimate those) 

   if (col[0] @= "WEX") {

   // variables are plotted against dates (juldays - birthday)

   j = 2


   LDVEC[Nobs] = wday

   DVEC[Nobs] = k

   WTVEC[Nobs] = atof(col[j++])

//DBPR"$k  $DVEC[Nobs]  $WTVEC[Nobs] \n"

    if (WTVEC[Nobs] > 0.0) {
      last_known_wt = WTVEC[Nobs]
    } 


//   WTPMV[Nobs] = atof(col[j++])
//   CARBV[Nobs] = atof(col[j++])
   CARBV[Nobs] = 0
   walk =  atof(col[j++])
   hike = atof(col[j++]) 
   run = atof(col[j++]) 
   cycle =  atof(col[j++])
   swim =  atof(col[j++])
   yardwrk =  atof(col[j++])
   wex = atof(col[j++])

   EXTV[Nobs] =  ( walk + hike + run + cycle + swim + yardwrk + wex)

//DBPR"$k $EXTV[Nobs] $walk $run \n"
    if (wday > yday) {
      tot_exetime += EXTV[Nobs]
    }

   SEVEC[Nobs] =  wex
   BPVEC[Nobs] =  atof(col[j++])

// any extra activities ?

   tex = EXTV[Nobs]

   exer_burn =  ( walk * w_rate + hike * h_rate + run * run_rate + cycle * c_rate )
   exer_burn +=	 (swim * swim_rate + yardwrk * yard_rate + wex * wex_rate)

   EXEBURN[Nobs] =  exer_burn

   if (wday > yday) {
     tot_exeburn += exer_burn
//<<"%V$wday $yday $(typeof(wday)) $day %4.1f$exer_burn  $walk $run $cycle\n"
Nxy_obs++
   }

  

   wrk_sleep  = (sleep_burn + (16 * 60 - tex) * office_rate )  

   CALBURN[Nobs] =  wrk_sleep + exer_burn

 //<<"$k $Nobs $day %6.1f $exer_burn $wrk_sleep $CALBURN[Nobs] $CARBV[Nobs]\n"

   Nobs++
   }

   }

   }

  }

<<"there were $Nobs measurements \n"

//////////////////////////////////////// PLOT GOAL LINE  ///////////////////////////////////////////
//exitsi()
//    sc_endday = lday + 10
//    sc_endday = 75 * 365


      sc_endday = (jtoday - bday) + 20

      gsday = julday("4/01/2013") -bday
      gday =  julday("6/30/2013") -bday    // goal day 



       ngday = gday - gsday 

   DBPR"%V$ngday \n"

gwt = GoalWt

  GVEC[0] = 0.0

  GVEC[365] = GoalWt 

  ty_gsday = gsday- (sday -bday)


  GVEC[ty_gsday] = StartWt

  GVEC[gday-sday] = gwt

  k =0

//  lpd = 1.75/7.0      // 1.75 lb a  week
  lpd = 2.0/7.0      // 5 lb a  week
  sw = StartWt
  lw = sw

  for (i= 0; i < ngday; i++) {

//DBPR"$(ty_gsday+i) $lw \n"

    GVEC[ty_gsday+i] = lw

    lw -= lpd
    if (lw < 165.0)
        lw = 165
  }




///  revised goal line
sz = Caz(GVEC)

////////////////////////////////////////////////////////////////////////


DBPR"%V$i $sz\n"

  sw2 = 205
  gw2 = 170


 cf(A)



///////////////////////  read FPC_LOG ///////////////////////////////
#define DO_FOOD_LOG 0


if (DO_FOOD_LOG) {

   A=ofr("fpc_log.dat")

   S= readfile(A)
   cf(A)


 nlines = Caz(S)
 j = 0

 str fline

   first_k = 0 
   end_k = 0

   nfobs = 0
   for (j = 0 ; j < nlines; j++) {

   fline = S[j]

//DBPR"$j $fline \n"
   
    if (!scmp(fline,"#",1)) {

    col= split(fline)

    day = col[0]
    calcon = col[7]
    carbcon = col[2]

//DBPR"$j $day $calcon $carbcon\n"

    wday = julday(col[0]) 

   k = wday - sday

   if (!first_k) {
       first_k = k;
   }
   else {
       end_k = k
   }

   if (k >= 0) {

      CALCON[nfobs] = atof(col[7])
      CARBV[nfobs] = atof(col[2])
//DBPR"carb $CARBV[nfobs]\n"
      DFVEC[nfobs] = k
      nfobs++
   }
   }
 }
}
//------------------------------------------------------------\\


//////////////////   Predicted Wt   //////////////////////////////////

// (cal_consumed - cal_burn) / 4000.0    is wt gain in lbs
//  if no cal_burn registered for the day assume no exercise
//  if no cal_consumed assume  typical day_burn + 200 

//         first_k = ty_gsday

         first_k = 220

         end_k = first_k + 90

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

<<" Done calcs !\n"
<<"$Nxy_obs total exeburn %6.2f $tot_exeburn  cals  $(tot_exeburn/4000.0) lbs in $(tot_exetime/60.0) hrs\n"

/{
 for (i= 0; i < Nobs; i++) {
  <<"$i $DVEC[i] $WTVEC[i] \n"
 }
/}



//////////////////// DISPLAY /////////////////////////////
msg ="x y z"     // event vars
msgw =split(msg)


DBPR"%V$msgw \n"

////////////////////////////// GLINE ////////////////////
proc drawGoals(ws)
  {

   if (ws == 0) {
    Plot(gwo,@line,sc_startday,165,sc_endday,165, "green")
    Plot(calwo,@line,sc_startday,day_burn,sc_endday,day_burn, "green")
    Plot(calwo,@line,sc_startday,out_cal,sc_endday,out_cal, BLUE_)
    Plot(calwo,@line,sc_startday,in_cal,sc_endday,in_cal, RED_)
//    Plot(carbwo,@line,0,30,sc_endday,30, BLUE_)
//    Plot(carbwo,@line,0,55,sc_endday,55, RED_)
   }

  if (ws == 1) {
DBPR"$ws $swo $kdays \n"
   Plot(swo,@line,0,150,kdays-10,250, BLUE_)
   }


  }
//---------------------------------------------------------
proc  drawMonths(ws)
 {
  // as either Months Jan,Feb, ... Dec  

  // or quarter and cross-quater days
  // Candlemass Feb 2
  // Lady Day   March 25
  // Beltane (may day) May 1
  // MidSummer   June 24
  // Lughnasaid  Aug 1
  // Michlemas   Sept 29
  // Samhain     Oct 31
  // Christmas   Dec 25
  //
  // Equinoxes Dec 21, March 21, June 21, Sep 21 - winter ,vernal, midsummer, fall

   int sd
   int k
   int yd
   int wd
   int wm = 0

   int wwo = gwo
   float lty = 0
   float qfwd = 0.0
 
   if (ws == 1) {
       wwo = swo
   }

   RS=wogetrscales(wwo)

// just plot at mid - the date

   mid_date = (RS[3] - RS[1])/2 + RS[1]
   q1_date = (RS[3] - RS[1])/4 + RS[1]
   q3_date = 3*(RS[3] - RS[1])/4 + RS[1]

   jd= mid_date +bday
   the_date = julmdy("$jd")

DBPR"%V$mid_date $jd $the_date \n"

   AxText(wwo, 1, the_date, mid_date, -0.25, BLUE_)

   jd= q1_date +bday
   the_date = julmdy("$jd")
   AxText(wwo, 1, the_date, q1_date, -0.25, BLUE_)
   jd= q3_date +bday
   the_date = julmdy("$jd")
   AxText(wwo, 1, the_date, q3_date, -0.25, BLUE_)

 }
//---------------------------------------------------------------

proc  drawGrids( ws )
{
// DBPR" $ws \n"

 if (ws == 0) {

 //DBPR"drawing Grids for screen 0 \n"

  //SetGwob(extwo,@axnum,1,0,kdays,7,1)

  //SetGwob(gwo,@axnum,2,155,205,10,5)

  axnum(gwo,2)

  //sWo(gwo,@axnum,4)
  //sWo(gwo,@axnum,1)

  //sWo(calwo,@axnum,2,500,5500,500,100)
  sWo(calwo,@axnum,2)
  sWo(extwo,@axnum,2)

  //sWo(extwo,@axnum,2,0,sc_endday,20,10)

  Text(gwo,  "Weight lbs",-4,0.7,4,-90)
  Text(extwo,"Exercise mins",-4,0.7,4,-90)
  Text(calwo,"Cals In/Out",-4,0.7,4,-90)

 }
 else {

  axnum(swo,2)

  //sWo(swo,@axnum,2,150,bp_upper,50,10)
  //sWo(carbwo,@axnum,2,0,carb_upper,50,10)

  //sWo(carbwo,@axnum,2)
  sWo(xwo,@clipborder,@save)

 }
  sWo(allwo,@showpixmap,@save)

  sWo(allwo,@clipborder)
}
//---------------------------------------------------------------------------------

#define ALL_LINES 1

proc drawScreens()
{


  if ( wScreen == 0) {

       sWo(wedwo,@clearclip,@save,@clearpixmap,@clipborder,"black")

       sWo(extwo,@clipborder,@save)
  
      //DrawGline(wedgl)
     
  if (ALL_LINES) {

      DrawGline(ext_gl)
      DrawGline(gw_gl)

      DrawGline(calc_gl)
      DrawGline(calb_gl)

      //DrawGline(carb_gl)
     // DrawGline(ave_ext_gl)

      DrawGline(wt_gl)
   }

      drawGoals(0)

      drawGrids(0) 

   //   setgwob(wedwo,@showpixmap)

      sWo(allwo,@clipborder,"black")

      drawMonths(0)

      //Text(carbwo,"Carbs", 0.8,0.8,1)

      Text(calwo,"Calories", 0.8,0.8,1)

      Text(extwo,"ExerciseTime", 0.8,0.8,1)

      //DrawGline(pwt_gl)

      DrawGline(wt_gl)
   

      //DrawGline(carb_gl)
      DrawGline(wt_gl)
     }

      if ( wScreen == 1) {

DBPR" Drawscreen 1  BP!!\n"
 
      drawGoals(1)
      drawGrids(1)
      drawMonths(1)

      DrawGline(bp_gl)

      setgwob(swo,@showpixmap)
       sWo(allwo,@clipborder,"green")
//      sWo(swo,@clipborder,"green")
      }

    sWo(fewos,@redraw)

}
//-----------------------------------------------------------------------------------------






Graphic = CheckGwm()
 if (!Graphic) {
     X=spawngwm()
  }



/////////////////////////////  SCREEN --- WINDOW ////////////////////////////////////////////////////////////
vptitle = "WED"

    vp =  cWi(@title, "WED",@resize,0.01,0.05,0.95,0.9,0)

    vp1 = cWi(@title,"XED",@resize,0.01,0.05,0.90,0.9,1)

    sWi(vp,@resize,0.1,0.1,0.9,0.8,@clip,0.1,0.1,0.7,0.9,@redraw)

    int allwin[] = {vp,vp1}

    sWi(allwin,@drawon,@pixmapoff,@save,@bhue,"white")


/////////////////////////////  WOBS /////////////////////////////////////////////////////////////////////

    sc_startday = sc_endday - 120

    gwo=createGWOB(vp,@graph,@name,"WTLB",@value,0,@clipborder)

    calwo=createGWOB(vp,@graph,@name,"CAL",@value,0,@clipborder,"black")

    extwo=createGWOB(vp,@graph,@name,"EXT",@value,0,@clipborder,"black")

    //carbwo=createGWOB(vp,@type,"GRAPH",@name,"CARB_COUNT",@color,"white")

    //int wedwo[] = { gwo, extwo, calwo, carbwo }

      int wedwo[] = { gwo, extwo, calwo  }

DBPR"%V$wedwo \n"

    // vtile before set clip!

    wo_vtile(wedwo,0.03,0.08,0.97,0.97,0.02)   // vertically tile the drawing areas into the main window

    cx = 0.08 ;    cX = 0.95 ; cy = 0.2 ; cY = 0.97


    sWo(wedwo,@clip,cx,cy,cX,cY, @color,"white")

    sWo(wedwo,@border,@clipborder,"black",@drawon)

    sWo(gwo,@scales,sc_startday,150,sc_endday+10,220,@savescales,0) 

    sWo(extwo,@scales,sc_startday,0,sc_endday+10,360,@savescales,0)

    sWo(calwo,@scales,sc_startday,0,sc_endday+10,4500,@savescales,0)

//    sWo(carbwo,@scales,sc_startday,0,sc_endday+10,1200)
//    sWo(extwo,@axnum,1,sc_startday,sc_endday,7,1)

    sWo(extwo,@axnum,1)

    swo= cWo(vp1,@type,"GRAPH",@name,"BenchPress",@color,"white")
    
    int xwo[] = { swo }

    wo_vtile(xwo,0.01,0.05,0.97,0.97)   // vertically tile the drawing areas into the main window

    sWo(xwo,@clip,cx,cy,cX,cY,@color,"white", @clipborder,"black")

//DBPR" $DVEC[0:10] \n"

//DBPR" %5\s\nR$WTVEC \n"

//DBPR" %5\s->\s,\s<-\nR$CARBV \n"

//DBPR" %10\s\nr$WTPMV \n"


//////////////////////////// SCALES //////////////////////////////////////////
DBPR" Days $k \n"

    bp_upper = 400.0
    carb_upper = 400
 
   //  defaults are ?  @save,@redraw,@drawon,@pixmapon

    sc_startday = sc_endday - 120

    sWo(swo,@scales,sc_startday,110,sc_endday,bp_upper)

DBPR"SCALES %V$sc_startday $sc_endday $bp_upper\n"

    //sWo(carbwo,@scales,sc_startday,0,sc_endday,carb_upper)

DBPR"SCALES %V$sc_startday $sc_endday $carb_upper\n"

    //int allwo[] = {gwo,swo,carbwo,calwo,extwo}
    int allwo[] = {gwo,swo,calwo,extwo}

//<<"%V $allwo \n"

    sWo(allwo,@save,@redraw,@drawon,@pixmapon)


//////////////////////////// GLINES & SYMBOLS //////////////////////////////////////////
DBPR"\n%(10,, ,\n)$DVEC \n"
DBPR"\n%V$PWTVEC[0:20] \n"
   pwt_gl = -1
// pwt_gl  = cGl(@wid,gwo,@TXY,DVEC,PWTVEC,@color,"green",@ltype,"line")

DBPR"%V$pwt_gl \n"


 //ext_gl  = cGl(@wid,extwo,@TXY,DVEC,EXTV,@color,BLUE_,@ltype,"symbols","diamond")

   ext_gl  = cGl(extwo,@TXY,DVEC,EXTV,@color,BLUE_,@ltype,"symbols","diamond")

//DBPR"%V$ext_gl \n"

  sGl(ext_gl,@symsize,0.75,@symhue,GREEN_)

 //wt_gl   = cGl(@wid,gwo,@TXY,DVEC,WTVEC,@color,RED_,@ltype,"symbols","diamond")
  wt_gl    = cGl(gwo,@TXY,DVEC,WTVEC,@color,RED_,@ltype,"symbols","diamond")

//DBPR"%V$wt_gl \n"

  sGl(wt_gl,@symbol,"triangle",1.2, @fill_symbol,0,@symsize,0.75,@symhue,RED_)

  if ((wt_gl == -1)  || (ext_gl == -1)) {
    exit_si()
  }

// wtpm_gl = cGl(gwo,@type_XY,DVEC,WTPMV,@color,BLUE_,@ltype,"symbols","diamond")

 gw_gl   = cGl(gwo,@TXY,WDVEC,GVEC,@color,BLUE_)

 bp_gl   = cGl(swo,@TXY,DVEC,BPVEC,@color,RED_,@ltype,"symbols",@name,"benchpress")

DBPR"%(10,, ,\n)$BPVEC\n"

// carb_gl = cGl(@wid,carbwo,@type_XY,DFVEC,CARBV,@color,"brown",@ltype,"symbols","diamond",@symhue,"brown")


//DBPR"%V$carb_gl \n"

 //if (wtpm_gl == -1 || gw_gl == -1 || bp_gl == -1) {
if ( gw_gl == -1 || bp_gl == -1) {
   exit_si()
 }

 calb_gl = cGl(calwo,@TXY,DVEC,CALBURN,@color,BLUE_,@ltype,"symbols","diamond")

 calc_gl = cGl(calwo,@TXY,DFVEC,CALCON,@color,RED_,@ltype,"symbols","triangle",@symhue, BLUE_)

 ave_ext_gl  = cGl(extwo,@TXY,DVEC,AVE_EXTV,@color,RED_,@ltype,"line")

 se_gl   = cGl(extwo,@TXY,DVEC,SEVEC,@color,"green",@ltype,"symbols","diamond")

//  int allgl[] = {wtpm_gl,wt_gl,gw_gl,bp_gl,ext_gl,se_gl,calb_gl, calc_gl, pwt_gl}

  int allgl[] = {wt_gl,gw_gl,bp_gl,ext_gl,se_gl,calb_gl, calc_gl}

  int wedgl[] = {wt_gl,gw_gl, ext_gl, calb_gl, se_gl, calc_gl}

DBPR"%V$allgl \n"

  sGl(allgl,@missing,0,@symbol,"diamond",5)

  sGl(ext_gl,@symbol,"diamond",1.2, @fill_symbol,0)
//  sGl(wt_gl,@symbol,"triangle",1.2, @fill_symbol,1)
  sGl(wt_gl,@symbol,"triangle",1.2, @fill_symbol,0)
  sGl(se_gl,@symbol,"diamond",1.2)
  //sGl(carb_gl,@symbol,"triangle",1.2,@fill_symbol,0)
  sGl(calb_gl,@symbol,"diamond",1.2,@fill_symbol,0)
  sGl(calc_gl,@symbol,"triangle",@symsize,1.2,@symhue,BLUE_)
  sGl(bp_gl,@symbol,"inverted_triangle",1.2,@missing,0)

  zinwo=cWo(vp,@BN,@name,"ZIN",@color,"hotpink")
  zoomwo=cWo(vp,@BN,@name,"ZOUT",@color,"cadetblue")

  yrdecwo= cWo(vp,@BN,@name,"YRD",@color,"violetred")
  yrincwo= cWo(vp,@BN,@name,"YRI",@color,"purple")
  qrtdwo=  cWo(vp,@BN,@name,"QRTD",@color,"violetred")
  qrtiwo=  cWo(vp,@BN,@name,"QRTI",@color,"purple")




  int fewos[] = {zinwo,zoomwo, yrdecwo, yrincwo, qrtdwo, qrtiwo }

  wo_htile( fewos, 0.03,0.01,0.43,0.08,0.05)

  nobswo= cWo(vp,@BV,@name,"Nobs",@color,"Cyan",@value,0)

  xtwo= cWo(vp,@BV,@name,"xTime",@color,"violetred",@value,0)

  xbwo= cWo(vp,@BV,@name,"xBurn",@color,"violetred",@value,0)

  xlbswo= cWo(vp,@BV,@name,"xLbs",@color,"violetred",@value,0)
  
  int xwos[] = { nobswo, xtwo, xbwo, xlbswo }


  

  wo_htile( xwos, 0.45,0.01,0.83,0.08,0.05)

  sWo(xwos,@style,"SVB",@redraw)

//  CURSORS

lc_gl   = cGl(gwo,@type,"XY",@color,"orange",@ltype,"cursor")

rc_gl   = cGl(gwo,@type,"XY",@color,BLUE_,@ltype,"cursor")


////////////////////////////////////// PLOT  ////////////////////////////////////////////

DBPR" $allgl \n"

//  
//  DrawGline(ext_gl)
//  DrawGline(allgl)


  sWo(gwo,@showpixmap,@save)
  sWo(calwo,@showpixmap)
//  sWo(carbwo,@showpixmap)

//////////////////////// UTIL PROCS /////////////////////////////

proc adjustYear(updown)
{

// find current mid-year
// decrement - and set rx,RX to jan 1, dec 31 of that year
// then label 1/4 days

   RS=wogetrscales(gwo)

// just plot at mid - the date
   mid_date = (RS[3] - RS[1])/2 + RS[1]

   jd= mid_date +bday
   the_date = julmdy("$jd")

   // which year?
   yrs = sele(the_date,-1,4)
   yrd = atoi(yrs)
//DBPR"%V$jd $the_date $yrs $yrd \n"
   if (updown > 0)
    yrd++

   if (updown < 0)
    yrd--

   st_jday = julday("01/01/$yrd")
   ed_jday = julday("12/31/$yrd")

   rx = st_jday - bday
   rX = ed_jday - bday

   sWo(wedwo,@xscales,rx,rX,@savescales,0)

   sWo(swo,@xscales,rx,rX) 

   sWo(gwo,@scales,rx,150,rX,220,@savescales,0)

   drawScreens()
}

//////////////////////////////////////////////////////////////////////
proc adjustQrt(updown)
{
// find mid-date 
// adjust to a 90 day resolution
// shift up/down by 30

   RS=wogetrscales(gwo)

// just plot at mid - the date
   mid_date = (RS[3] - RS[1])/2 + RS[1]

   jd= mid_date +bday
   the_date = julmdy("$jd")

   if (updown > 0) {
     rx = mid_date -30
     rX = mid_date +60
   }
   if (updown < 0) {
     rx = mid_date -60
     rX = mid_date +30
   }

   sWo(wedwo,@xscales,rx,rX,@savescales,0)

    sWo(gwo,@scales,rx,150,rX,220,@savescales,0)
 
   sWo(swo,@xscales,rx,rX,@savescales,0)
 
   drawScreens()
}
//========================================================

proc showWL()
{

       RS=wogetrscales(gwo)

       rx = RS[1]
       rX = RS[3]
long ws
long we

       ws = rx + bday
       we = rX + bday

       computeWL( ws, we)
}
//========================================================

proc computeWL( wlsday, wleday)
{
// use input of juldays
// find the number of exe hours
// read the number of cals burnt during exercise
// compute the number of lbs burnt
   int i

   Nsel_exemins = 0
   Nsel_exeburn = 0

   Nxy_obs = 0

   Nsel_lbs = 0.0


   for (i = 0; i < Nobs ; i++) {

     if (LDVEC[i] >= wlsday) {

        Nxy_obs++

        Nsel_exeburn += EXEBURN[i]
        Nsel_exemins += EXTV[i]
//<<"%V $i $Nsel_exeburn $Nsel_exemins \n"
     }

     if (LDVEC[i] > wleday) 
             break; 
   }

   Nsel_lbs = Nsel_exeburn/ 4000.0

  xhrs = (Nsel_exemins/60.0)

<<"%V$Nxy_obs %6.2f $Nsel_exemins $(Nsel_exemins/60.0) $Nsel_exeburn $Nsel_lbs $xhrs\n"

  sWo(nobswo,@value,Nxy_obs,@update)

  //sWo(xtwo,@value,"%4.1f$(Nsel_exemins/60.0)",@update)
  sWo(xtwo,@value,xhrs,@update)
  sWo(xbwo,@value,"%6.2f$Nsel_exeburn",@update)
  sWo(xlbswo,@value,"%4.1f$Nsel_lbs",@update)


}

////////////////////////WONAME CALLBACKS///////////////////////////////////////
proc QRTD()
{
  adjustQrt(-1)

  showWL()

}

proc QRTI()
{
  adjustQrt(1)

  showWL()

}

//////////////////////////////////////////////////////////////////////////////////

proc YRD()
{
   adjustYear(-1)
}
//--------------------------------------------------
proc YRI()
{
    adjustYear(1)
}
//--------------------------------------------------


proc ZIN()
{

       sWo(wedwo,@xscales,lcpx,rcpx) 

       sWo(swo,@xscales,lcpx,rcpx) 

       drawScreens()

       showWL()

}
//--------------------------------------------------

proc ZOUT()
{

float RS[10]

       RS=wogetrscales(gwo)

       rx = RS[1]
       rX = RS[3]
       rx /= 2.0
       rX *= 2.0

       if (rX > maxday) {
          Rx = maxday
       }

       sWo(gwo,@scales,rx,150,rX,220) 

       sWo(gwo,@redraw,@update)
       sWo(swo,@xscales,rx,rX) 

       DrawGline(wt_gl)

       showWL()


}

//---------------------------------------------
proc WTLB()
{

    DBPR" setting cursors $button $Rinfo\n"

       if (button == 1) {
         lcpx = Rinfo[1]
         sGl(lc_gl,@cursor,lcpx,0,lcpx,300)
        }

       if (button == 3) {
         rcpx = Rinfo[1]
         sGl(rc_gl,@cursor,rcpx,0,rcpx,300)
       }

}

////////////////////////KEYW CALLBACKS///////////////////////////////////////
proc EXIT()
{
  exit_gs()
}
//-------------------------------------------
proc REDRAW()
{
  drawScreens()
}
//-------------------------------------------
proc RESIZE()
{
  drawScreens()
}
//-------------------------------------------
proc SWITCHSCREEN()
{
  if (msgw[0] @= "SWITCHSCREEN") { 
     wScreen = atoi(msgw[1])
DBPR"Setting %V$wScreen msgw[1]\n"
      drawScreens()
  }
}
///////////////////////////////////////////////////////////////////////////////////////

//setdebug(0)

int wScreen = 0
float Rinfo[30]

woname = ""
E =1

//DBPR"%(7,, ,\n)$CALBURN \n"
//DBPR"%(7,, ,\n)$CALCON \n"

int m_num = 0
int button = 0



   drawScreens()



   Keyw = ""
   lcpx = 50.0
   rcpx = 100.0

   sGl(lc_gl,@cursor,lcpx,0,lcpx,300)

   sGl(rc_gl,@cursor,rcpx,0,rcpx,300)

   drawScreens()



   while (1) {

        m_num++

        msg  = E->waitForMsg()
DBPR"got message\n $msg \n"
        msgw = split(msg)
        Keyw = E->getEventKeyw()
DBPR"$m_num $msg $Keyw \n"
       button = E->getEventButton()
DBPR"%V$button \n"
       woname = E->getEventWoname()
DBPR"%V$woname \n"
       Rinfo = E->getEventRinfo()
DBPR"%V$Rinfo\n"
       Evtype = E->getEventType()    

       if (Evtype @= "PRESS") {
        if (!(woname @= "")) {
DBPR"calling function via $woname !\n"
            $woname()
        }
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
