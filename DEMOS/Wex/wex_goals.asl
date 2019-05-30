//%*********************************************** 
//*  @script wex_goals.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sat Dec 29 08:56:45 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///
///        long-term and current weight loss goals 
///


GoalWt = 175;  // ideal -- flying weight

NextGoalWt = 180;

StartWt = 210;

targetday = julian("05/26/2019") -bday;


//  SET  START AND END DATES HERE

long sday = julian("05/01/2019") -bday // start date
      gsday = sday;
      gday =  targetday;    // next goal day 


got_start = 0

long yday = julian("01/01/2019")   // this should be found from data file
long eday = julian("05/30/2019")  // this should be found from data file
today = julian("$(date(2))");



      ngday = gday - gsday;

k = eday - sday;

if ( k < 0) {
 DBPR" time backwards !\n"
 exit_gs()
}


kdays = k

<<[_DB]"%V$kdays \n"

<<[_DB]"%V$yday  $eday $today  $(date(2))\n"

///////////////////////////////////