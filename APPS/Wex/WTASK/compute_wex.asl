/* 
 *  @script compute_wex.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.2 He 6.3.78 C-Li-Pt 
 *  @date 02/02/2022 07:54:13          
 *  @cdate  
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
//----------------<v_&_v>-------------------------//                                                                                 

float xhrs = 0;
float Ndiet_lbs = 0.0;
float Nsel_calsinout = 0.0;
float Ave_carbs = 0.0;
   void computeGoalLine()
   {

//<<" computeGoalLine()\n"
 //<<"%V$StartWt $NextGoalWt\n"
     int sz;
     long ngday = gday - gsday;
//<<"%V $ngday  $gday - $gsday \n"

     GVEC[0] = StartWt;  // start  Wt

     GVEC[1] = NextGoalWt;

     long ty_gsday = gsday;

     float gwt =  NextGoalWt;

     GVEC[ngday-1] = gwt;  // goal wt

     WDVEC[ngday-1] = gsday+ngday;

     int k =0;
//  lpd = 1.75/7.0      // 1.75 lb a  week

     float lpd = 4.0/7.0;      // 4 lb a  week

     float try_lpd = (StartWt - NextGoalWt) / (1.0 * ngday);

     float lw = StartWt;

// our goal line  wt loss per day!
//<<[_DB]"%V $try_lpd $lpd \n"

     for (i= 0; i < ngday; i++) {
//<<"$(ty_gsday+i) $lw \n"

       GVEC[i] = lw;
//<<"%V $i $ngday $lw \n"
       WDVEC[i] = gsday+i;

       lw -= try_lpd;

       if (lw < MinWt) {
       lw = MinWt;
       }
       if (i > 365) {
            break;
       }
       }
///  revised goal line

   //  sz = Caz(GVEC);

 //    <<[_DB]" days $sz to lose $(StartWt-gwt) \n";

 //    sz = Caz(WDVEC);

 //    <<[_DB]"$sz\n";

 //    <<[_DB]"%6.1f%(7,, ,\n)$WDVEC\n";

 //    <<[_DB]"%6.1f%(7,, ,\n)$GVEC\n";
//ans=query("done computeGoalLine()?");

      //<<" exit computeGoalLine()\n";
     }
     
//==================================//

//void computeWL(long wlsday, long wleday)
void computeWL(int wlsday, int wleday)
{
/// use input of juldays
/// find the number of exe hours
// read the number of cals burnt during exercise
// compute the number of lbs burnt

//<<" computeWL $wlsday $wleday \n"

   int i;

   float ccals,bcals;
   Nsel_exemins = 0;
   Nsel_exeburn = 0.0;
   Nsel_calsinout = 0.0;
   n_obs = 0;

   Nxy_obs = 0;

   Nsel_lbs = 0.0;
   int sday;
   int eday;

  
   // convert to index
   sday = wlsday;
   eday = wleday;

//<<" %V $sday $eday  $Nobs\n"
   Ndiet_lbs = 0.0;
   Ave_carbs = 0.0;

   for (i = sday; i <= eday ; i++) {

        if (WTVEC[i] > 10) {

        Nxy_obs++;
        }
	n_obs++;
        Nsel_exeburn += EXEBURN[i]; // assuming this is zero for non-recorded
        Nsel_exemins += EXTV[i];

        ccals = CALSCON[i];

        bcals = CALBURN[i];
	Ave_carbs += CARBSCON[i];
        Nsel_calsinout +=  (ccals - bcals);

//<<"$i Exeburn $Nsel_exeburn Mins $Nsel_exemins   \n"
//<<"$i CIO $Nxy_obs $Nsel_calsinout in $ccals out $bcals \n"
      if (i > 370)    {
       break;
      }
   }

   Nsel_lbs = Nsel_exeburn/ 4000.0;
   Ndiet_lbs = Nsel_calsinout/ 4000.0;   
   Ave_carbs =  Ave_carbs / (1.0*n_obs);
   
   xhrs = (Nsel_exemins/60.0);

//<<"%V $Nxy_obs %6.2f $Nsel_exemins $(Nsel_exemins/60.0) $Nsel_exeburn $Ndiet_lbs $Nsel_lbs $xhrs\n"

<<"%V $Nxy_obs $Ave_carbs\n"

//<<"  $Ndiet_lbs \n"

//<<" %V  $Nsel_exemins \n"



//<<" %V $xhrs \n"

//<<"  $(Nsel_exemins/60.0) \n"



}
//=========================
float PWT1 = 0.0;
float PWT7 = 0.0;
float PWT14 = 0.0;
float PWT30 = 0.0;
float PWT = 0.0; // tomorrow


float predictWL()
{

double pw;
Vec<double> pwl(10);
pwl[0] = 0.0;
pwl[1] = 1.0;
double xv[5];
double yv[5];
int i;
int k = Yday-5; // 

<<"  predictWL %V $Yday $k\n"

  if (Yday > 5) {
    for (i =0; i < 5; i++) {   
       xv[i] =  i;
       yv[i] =  WTVEC[k];

     <<"$i $k  $WTVEC[k] $xv[i] $yv[i]\n"; // TBF
       k++;
   }
   <<"%V $xv\n"
   <<"%V $yv\n"
   
   pwl = Lfit(xv,yv,5);
  <<"pwl $pwl \n"
   // next day prediction

    pw1 = yv[0] + (pwl[1] *3);

  //  pw = fround((yv[0] + (pwl[1] *3)),2);  // TBF 09/15/23  fround broke
     pw = pw1 
//     pw = (yv[0] + (pwl[1] *3));




    PWT1 = pw;
    PWT7 = (yv[0] + (pwl[1] * 9));
    PWT14 = yv[0] + (pwl[1] * 16);
    PWT30 =  yv[0] + (pwl[1] * 30);

<<"\n Tomorrow's wt will be %6.2f $pw +week $PWT7  + month $PWT30\n"

//ans = query("predict ?? ");
//if (ans == "q") {
//exit(-1)
//}

  }

<<"\n Tomorrow's wt will be %6.2f $pw +week $PWT7  + month $PWT30\n"




  return pw;
}

//[EM]=================================//
//<<"Included compute module\n"
