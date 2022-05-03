/* 
 *  @script wex_goals.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.4 Be 6.3.78 C-Li-Pt 
 *  @date 01/31/2022 09:04:34          
 *  @cdate Tue Mar 3 07:57:45 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                
///
///        long-term and current weight loss goals 
///
//  SET     START DATE      END DATE  TARGET WEIGHT

// days will days of year not Julian


   
   Goals.Split("04/29/2022 05/31/2022 175");

//<<"Setting goals $Goals\n"

   
   
   Goals2.Split("04/29/2022 05/16/2022 194");
////////////////////==============/////////////////



// move these done 10 when reached -- until we are at desired operating weight!
float   DX_NEW = 200.0;  // never exceed

float   DX_MEW = GoalWt+5;  // max dx effort above


   long tjd =  Julian(Goals[0]) ;
   

   //long sday = julian(Goals[0]) -Jan1 ; // start date

   long Sday = tjd - Jan1;
   

   long tarxday = Julian(Goals[1]) -Jan1;
   targetday = Julian(Goals[1]);

   targetday -= Jan1;
	  
//<<"%V $tjd $Jan1 $Sday $targetday  $tarxday; \n"


   int NextGoalWt = atoi(Goals[2]);

   long Sday2 = Julian(Goals2[0]) -Jan1 ; // start date

   long tday2 = Julian(Goals2[1]) -Jan1;

   int StGoalWt = atoi(Goals2[2]);




   long gsday = Sday;

   long gday =  targetday;    // next goal day;

   int got_start = 0;

   long yday = Julian("01/01/$Year")   ; // this should be found from data file

   long eday = Julian("12/31/$Year");

   jtoday = Julian("$(date(2))");

   int ngday = 7;

   int k = eday - Sday;

   if ( k < 0) {

     cout <<" time backwards !\n";

     exit_si();

     }

   int kdays = k;

;//==============\_(^-^)_/==================//;
