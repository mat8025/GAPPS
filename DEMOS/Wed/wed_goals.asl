///
///        long-term and current wieght loss goals 
///


GoalWt = 175;  // ideal -- just so slighty tubby
NextGoalWt = 180;
StartWt = 203;

targetday = julday("12/08/2017") -bday;


//  SET  START AND END DATES HERE

long sday = julday("4/1/2017") // start date

got_start = 0

long yday = julday("1/1/2017")   // this should be found from data file
long eday = julday("12/31/2017")  // this should be found from data file
today = julday("$(date(2))");

      gsday = julday("12/15/2017") -bday;
      gday =  julday("12/25/2017") -bday;    // next goal day 

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