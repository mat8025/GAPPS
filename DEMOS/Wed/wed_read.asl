///
///   wed_read
///


last_known_wt = 205;
last_known_day = 0;

tl = 0;

float tot_exeburn =0
float tot_exetime = 0

Nobs = 0;
nxobs = 0;

int Nxy_obs = 0

//=========================================


proc isData()
{
//<<"$S \n"
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


//<<"%V$kd $Nobs\n";
// <<" ";
 
 if ((kd >= 0) && (col[0] @= "WEX")) {

   j = 2;

   mywt = atof(col[j++]);

   if (mywt > 0) {
   
    LDVEC[Nobs] = wday;
    DVEC[Nobs] = kd;

    WTVEC[Nobs] = mywt;

//DBPR"$k  $DVEC[Nobs]  $WTVEC[Nobs] \n"

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


  S= readline(A);

int kd;

  while (1) {

//<<"a";

   S= readline(A);

   tl++;

   if (check_eof(A) ) {
     <<"end of data \n";
     break;
   }

   ll = slen(S)

 //DBPR"$tl $ll  $S \n"
 
//<<"$tl $ll  $S \n"
//<<"b"
   if (ll < 9) {
        continue;
   }

//   sscan(S,'%s',&fword) // get first word -non WS
//<<"%V$ll $fword\n"
//<<"c"

    if (isData()) {
    
//<<"d";

      col= split(S);

//<<"e";

//DBPR"$col \n"

    day = col[1]

    wday = julday(day) 

    if (!got_start) {
        sday = wday
        got_start = 1;
    }


    kd = wday - bday;

    lday = kd;

//DBPR"%V$day $wday  $k \n"
// bug need a print statement here - or the else does not get used
//<<"%V$day $wday  $kd \n"

//<<"x";
//<<" "

   if (kd < 0) {
       <<" $k neg offset ! \n";
       break;
   }

//  <<"z";
//
//<<" what day $k\n"
   // will need separate day vector for the food carb/protein/fat/calorie totals
   // -( we count/estimate those) 
   // variables are plotted against dates (juldays - birthday)
//<<"$kk wex measure $Nobs\n";

    fillInObsVec();

  }
 //<<"$Nobs\n" ; 
 }


<<"there were $Nobs measurements \n"
