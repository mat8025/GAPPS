///
///   wed_read
///




last_known_wt = 205;
last_known_day = 0;

tl = 0

float tot_exeburn =0
float tot_exetime = 0

Nobs = 0
nxobs = 0

int Nxy_obs = 0



//=========================================


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
//===========================================================


S= readline(A)

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
       break;
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

DBPR"there were $Nobs measurements \n"
