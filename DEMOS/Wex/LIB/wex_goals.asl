//%*********************************************** 
//*  @script wex_goals.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Tue Mar  3 07:57:45 2020 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///
///        long-term and current weight loss goals 
///
//  SET     START DATE      END DATE  TARGET WEIGHT

   Goals = Split("12/01/2021 03/31/2022 175");
////////////////////==============/////////////////

   GoalWt = 175;  // ideal -- flying weight

   StartWt = 214;

   MinWt = 165;

   long sday = julian(Goals[0]) -bday ; // start date

   long targetday = julian(Goals[1]) -bday;

   NextGoalWt = atoi(Goals[2]);

   gsday = sday;

   gday =  targetday;    // next goal day;

   got_start = 0;

   long yday = julian("01/01/2021")   ; // this should be found from data file

   long eday = julian("12/31/2021");

   jtoday = julian("$(date(2))");

   int ngday = 7;

   k = eday - sday;

   if ( k < 0) {

     DBPR" time backwards !\n";

     exit_gs();

     }

   kdays = k;

   _DB =-1;

   <<[_DB]"%V$kdays \n";

   <<[_DB]"%V$yday  $eday $jtoday  $(date(2))\n";

   void computeGoalLine()
   {
 // <<"%V$StartWt $NextGoalWt\n"

     ngday = gday - gsday;

     GVEC[0] = StartWt;  // start  Wt

     GVEC[1] = NextGoalWt;

     ty_gsday = gsday;

     gwt =  NextGoalWt;

     GVEC[ngday-1] = gwt;  // goal wt

     WDVEC[ngday-1] = gsday+ngday;

     k =0;
//  lpd = 1.75/7.0      // 1.75 lb a  week

     lpd = 4.0/7.0;      // 4 lb a  week

     try_lpd = (StartWt - NextGoalWt) / (1.0 * ngday);

     sw = StartWt;

     lw = sw;
// our goal line  wtloss per day!
//<<[_DB]"%V $try_lpd $lpd \n"

     for (i= 0; i < ngday; i++) {
//<<"$(ty_gsday+i) $lw \n"

       GVEC[i] = lw;

       WDVEC[i] = gsday+i;

       lw -= try_lpd;

       if (lw < MinWt)

       lw = MinWt;

       }
///  revised goal line

     sz = Caz(GVEC);

     <<[_DB]" days $sz to lose $(StartWt-gwt) \n";

     sz = Caz(WDVEC);

     <<[_DB]"$sz\n";

     <<[_DB]"%6.1f%(7,, ,\n)$WDVEC\n";

     <<[_DB]"%6.1f%(7,, ,\n)$GVEC\n";

     }
//==================================//

   <<[_DB]"$_include \n";
///////////////////////////////////

//===***===//
