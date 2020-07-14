//%*********************************************** 
//*  @script wex_read.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.5 B Boron                                                    
//*  @date Tue Jan  1 09:19:14 2019 
//*  @cdate Fri Jan 01 08:00:45 2010 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%

_DB = 1;

last_known_wt = 208.8;
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

 //  <<[_DB]"$fword $dok\n"

   return dok
}
//===========================================================

proc fillInObsVec()
{

 
 if (kd >= 0) {

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

   CARDIO[Nobs] = ( walk + hike + run + cycle + swim )
   STRENGTH[Nobs] = (yardwrk + wex)

//<<"$k $EXTV[Nobs]  \n"

  if (wday > yday) {
      //tot_exetime += EXTV[Nobs]
      
      tot_exetime = tot_exetime + EXTV[Nobs]
//<<"%V $tot_exetime  $Nobs  $EXTV[Nobs] \n"
   }

   SEVEC[Nobs] =  wex
   
   BPVEC[Nobs] =  atof(col[j++])

// any extra activities ?

   tex = EXTV[Nobs]

   exer_burn =   walk * w_rate; 
   exer_burn += hike * h_rate
   exer_burn += run * run_rate
   exer_burn +=  cycle * c_rate
   exer_burn += swim * swim_rate
   exer_burn += yardwrk * yard_rate
   exer_burn += wex * wex_rate



 //  exer_burn +=	 (swim * swim_rate + yardwrk * yard_rate + wex * wex_rate)

   EXEBURN[Nobs] =  exer_burn

   if (wday > yday) {
     tot_exeburn += exer_burn
//<<[_DB]"%V$wday $yday $(typeof(wday)) $wday %4.1f$exer_burn  $walk $run $cycle\n"
     Nxy_obs++;
   }

   wrk_sleep  = (sleep_burn + (16 * 60 - tex) * office_rate )  

   CALBURN[Nobs] =  wrk_sleep + exer_burn

 //<<[_DB]"$kd $(Nobs+1) $wday %6.1f $WTVEC[Nobs] $exer_burn $wrk_sleep $CALBURN[Nobs] $CARBV[Nobs]\n"
      Nobs++;
      }
   }
}
//====================================================//


long kd;
svar col;


proc readData()
{

  int tl = 0;

  col= RX[tl];

//<<"$col\n"

  day = col[0];

//<<"%V $day $Nrecs\n"

// data has already been read into Record array RX
     RX->info(1)
      
   

  while (tl < Nrecs) {

  //tl->info(1)     // ? bad
  

      col= RX[tl];

 //<<"<$tl> $RX[tl]\n"



//<<"<$tl> $(typeof(col)) $col \n"

//<<"$col \n"
//col->info(1)
    day = col[0];
 //   day->info(1);

   wday = julian(day) 

//   wday->info(1)
    
    if (!got_start) {
        sday = wday
        got_start = 1;
    }

    kd = wday - bday;
//<<"%V $wday $day $kd\n"

    lday = kd;

//<<[_DB]"%V$day $wday  $k \n"
// bug need a print statement here - or the else does not get used
//<<[_DB]"%V$day $wday  $kd \n"



   if (kd < 0) {
       <<" $kd neg offset ! \n";
   
   }


//<<[_DB]" what day $k\n"
   // will need separate day vector for the food carb/protein/fat/calorie totals
   // -( we count/estimate those) 
   // variables are plotted against dates (juldays - birthday)

    fillInObsVec();

    tl++;
//<<"%V $tl\n"
   if (tl >= Nrecs) {
    //if (tl >= 4) {
       break;
    }

}



<<"$Nrecs there were $tl $Nobs measurements \n"
     return tl;
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
    CARBCON[j+1] = 0.0;  

<<[_DB]"$NCCobs $CCDV[j] $CALCON[j] $CARBCON[j] \n"

   NCCobs++;

   }
}
//====================================================//


proc readCCData()
{

  tl = 0;

//svar ccol;


  while (tl < NCCrecs) {


    //ccol = RCC[tl];

//<<[_DB]"$RCC[tl]\n"
//<<[_DB]"$tl  $NCCobs $NCCrecs\n"

    //day = ccol[0];

    wday = RCC[tl][0];

    //wday = julian(day) 

    kd = wday - bday;

    lday = kd;
  j = NCCobs;
  
  CCDV[j] = kd;  // julian day - bday - #daysofar

  cals = atof(RCC[tl][1]);
  CALSCON[j] = cals;
  carbs = atof(RCC[tl][2]);
  CARBSCON[j] = carbs;
  CARBSCON[j+1] = 0;    
//<<[_DB]"%V $j $cals $CALSCON[j]\n"
   NCCobs++;     

    tl++;
    if (tl >= NCCrecs) {
        break;
    }

 }

  //for (j= 0; j <= NCCrecs; j++) {
  //<<[2]"$j $CCDV[j] $CALSCON[j] $CARBSCON[j]\n"
  //}
}
//=======================================//