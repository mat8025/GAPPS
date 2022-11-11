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
;//----------------<v_&_v>-------------------------//;                                                                                 

float xhrs = 0;
float Ndiet_lbs = 0.0;
float Nsel_calsinout = 0.0;

void computeWL(long wlsday, long wleday)
{
/// use input of juldays
/// find the number of exe hours
// read the number of cals burnt during exercise
// compute the number of lbs burnt

int i;
   float ccals,bcals;
   Nsel_exemins = 0;
   Nsel_exeburn = 0.0;
   Nsel_calsinout = 0.0;

   Nxy_obs = 0;

   Nsel_lbs = 0.0;
//<<"$_proc %V $wlsday $wleday  $Nobs\n"
   Ndiet_lbs = 0.0;

   for (i = wlsday; i < wleday ; i++) {

        Nxy_obs++;

        Nsel_exeburn += EXEBURN[i];
        Nsel_exemins += EXTV[i];

        ccals = CALSCON[i];

        bcals = CALBURN[i];
	
        Nsel_calsinout +=  (ccals - bcals);

//<<"$i Exeburn $Nsel_exeburn Mins $Nsel_exemins   \n"
//<<"$i CIO $Nsel_calsinout in $ccals out $bcals \n"
      if (i > Nobs)
         break;

   }

   Nsel_lbs = Nsel_exeburn/ 4000.0;
   Ndiet_lbs = Nsel_calsinout/ 4000.0;   

   xhrs = (Nsel_exemins/60.0);

//<<"%V$Nxy_obs %6.2f $Nsel_exemins $(Nsel_exemins/60.0) $Nsel_exeburn $Nsel_calsinout $Nsel_lbs $xhrs\n"

}
//=========================
float PWT7 = 0.0;
float PWT14 = 0.0;
float PWT = 0.0; // tomorrow

float predictWL()
{
float pw;
Vec<float> pwl(10);
pwl[0] = 0.0;
pwl[1] = 1.0;
float xv[5];
float yv[5];
int i;
int k = Yday-2; // 

//<<"$Yday $k\n"

  if (Yday > 5) {
    for (i =0; i < 3; i++) {   
       xv[i] =  i;
       yv[i] =  WTVEC[k];

 //     <<"$i $k  $WTVEC[k] $xv[i] $yv[i]\n"; // TBF
       k++;
   }
//   <<"%V $xv\n"
//   <<"%V $yv\n"
   
   pwl = Lfit(xv,yv,3);
//   <<"pwl $pwl \n"
   // next day prediction

    pw = yv[0] + (pwl[1] *3);
    PWT7 = yv[0] + (pwl[1] * 9);
    PWT14 = yv[0] + (pwl[1] * 16);
  }
#if ASL
<<"tomorrow's wt will be $pw +7 $PWT7  +14 $PWT14\n"
#endif
  return pw;
}

//[EM]=================================//
//<<"Included compute module\n"
