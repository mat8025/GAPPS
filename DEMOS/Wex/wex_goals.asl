///
///        long-term and current weight loss goals 
///


GoalWt = 175;  // ideal -- just so slighty tubby
NextGoalWt = 185;
StartWt = 199;

targetday = julian("09/09/2018") -bday;


//  SET  START AND END DATES HERE

long sday = julian("08/10/2018") -bday // start date
      gsday = sday;
      gday =  targetday;    // next goal day 


got_start = 0

long yday = julian("01/01/2018")   // this should be found from data file
long eday = julian("12/31/2018")  // this should be found from data file
today = julian("$(date(2))");



      ngday = gday - gsday;

k = eday - sday;

if ( k < 0) {
 DBPR" time backwards !\n"
 exit_gs()
}


kdays = k

DBPR"%V$kdays \n"

<<"%V$yday  $eday $today  $(date(2))\n"

///////////////////////////////////