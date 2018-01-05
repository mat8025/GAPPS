///
///        long-term and current wieght loss goals 
///


GoalWt = 175;  // ideal -- just so slighty tubby
NextGoalWt = 190;
StartWt = 203;

targetday = julday("02/01/2018") -bday;


//  SET  START AND END DATES HERE

long sday = julday("01/01/2018") // start date

got_start = 0

long yday = julday("01/01/2018")   // this should be found from data file
long eday = julday("12/31/2018")  // this should be found from data file
today = julday("$(date(2))");

      gsday = julday("01/01/2018") -bday;
      gday =  julday("02/01/2018") -bday;    // next goal day 

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