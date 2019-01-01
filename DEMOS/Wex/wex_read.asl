//%*********************************************** 
//*  @script wex_read.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sat Dec 29 09:00:45 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%





last_known_wt = 205;
last_known_day = 0;

float tot_exeburn =0
float tot_exetime = 0

Nobs = 0;
nxobs = 0;

int Nxy_obs = 0

long wday;
//=========================================


proc isData()
{
   dok = 1

   fword=""

   sscan(S,'%s',&fword) // get first word -non WS

   if (scmp(fword,"#",1)) {
       dok = 0;
   }

 //  <<"$fword $dok\n"

   return dok
}
//===========================================================

proc fillInObsVec()
{

 
 if ((kd >= 0)) {

   j = 1;

   mywt = atof(col[j++]);

   if (mywt > 0) {
   
    LDVEC[Nobs] = wday;
    DVEC[Nobs] = kd;

    WTVEC[Nobs] = mywt;

//<<[_DB]"$k  $DVEC[Nobs]  $WTVEC[Nobs] \n"

    if (WTVEC[Nobs] > 0.0) {
      last_known_wt = WTVEC[Nobs]
      last_known_day = wday -bday;
    } 
    else {
     WTVEC[Nobs] = last_known_wt;
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

//<<[_DB]"$k $EXTV[Nobs] $walk $run \n"

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
     Nxy_obs++;
   }

   wrk_sleep  = (sleep_burn + (16 * 60 - tex) * office_rate )  

   CALBURN[Nobs] =  wrk_sleep + exer_burn

 //<<"$kd $(Nobs+1) $day %6.1f $WTVEC[Nobs] $exer_burn $wrk_sleep $CALBURN[Nobs] $CARBV[Nobs]\n"
      Nobs++;
      }
   }
}
//====================================================//


int kd;
svar col;


proc readData()
{

  tl = 0;


  while (1) {

      tl++;

      col= RX[tl];
      
 //<<"<$tl> $RX[tl]\n"

<<[_DB]"<$tl> $(typeof(col)) $col \n"

//<<[_DB]"$col \n"

    day = col[0];

    wday = julian(day) 

    if (!got_start) {
        sday = wday
        got_start = 1;
    }


    kd = wday - bday;

    lday = kd;

//<<[_DB]"%V$day $wday  $k \n"
// bug need a print statement here - or the else does not get used
//<<"%V$day $wday  $kd \n"



   if (kd < 0) {
       <<" $k neg offset ! \n";
       break;
   }


//<<" what day $k\n"
   // will need separate day vector for the food carb/protein/fat/calorie totals
   // -( we count/estimate those) 
   // variables are plotted against dates (juldays - birthday)

    fillInObsVec();
    if (tl >= (Nrecs-1)) {
       break;
    }
}

//=======================================

<<[_DB]"$Nrecs there were $Nobs measurements \n"
}
//==============================================//

int NCCobs =0;

proc fillInCCObsVec()
{
 
 if ((kd >= 0)) {

  j = NCCobs;

  CCDV[j] = kd;  // julian day - bday - #daysofar
  CALCON[j] =  atof(col[1]);
  CARBCON[j] = atof(col[2]);  

<<"$NCCobs $CCDV[j] $CALCON[j] $CARBCON[j] \n"

   NCCobs++;

   }
}
//====================================================//


proc readCCData()
{

  tl = 0;

//svar ccol;
/{
  for (j= 0; j < NCCrecs; j++) {
    CALSCON[j] = 28+j;
    CARBSCON[j] = 52+j;    
   <<"$j $CALSCON[j]\n"
  }
/}

  while (1) {


    //ccol = RCC[tl];

//<<"$RCC[tl]\n"
//<<"$tl  $NCCobs $NCCrecs\n"

    //day = ccol[0];

    day = RCC[tl][0];

    wday = julian(day) 

    kd = wday - bday;

    lday = kd;
  j = NCCobs;
  
  CCDV[j] = kd;  // julian day - bday - #daysofar

  cals = atof(RCC[tl][1]);
  CALSCON[j] = cals;
  carbs = atof(RCC[tl][2]);
  CARBSCON[j] = carbs;  
//<<"%V $j $cals $CALSCON[j]\n"
   NCCobs++;     

    tl++;
    if (tl >= NCCrecs) {
        break;
    }

 }

  for (j= 0; j < NCCrecs; j++) {
  <<"$j $CCDV[j] $CALSCON[j] $CARBSCON[j]\n"
  }
}
//=======================================//