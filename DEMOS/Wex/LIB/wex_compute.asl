/* 
 *  @script wex_compute.asl 
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

xhrs = 0;

void computeWL(long wlsday, long wleday)
{
/// use input of juldays
/// find the number of exe hours
// read the number of cals burnt during exercise
// compute the number of lbs burnt

int i;

   Nsel_exemins = 0
   Nsel_exeburn = 0.0

   Nxy_obs = 0

   Nsel_lbs = 0.0
//<<"$_proc %V $wlsday $wleday  $Nobs\n"

   for (i = 0; i < Nobs ; i++) {
        aday = LDVEC[i] - bday;
     if (aday >= wlsday) {

        Nxy_obs++

        Nsel_exeburn += EXEBURN[i]
        Nsel_exemins += EXTV[i]
//<<"%V $i $Nsel_exeburn $Nsel_exemins $wlsday  $LDVEC[i]  $bday\n"
     }

     if (aday > wleday) 
             break; 
   }

   Nsel_lbs = Nsel_exeburn/ 4000.0

   xhrs = (Nsel_exemins/60.0)

//<<"%V$Nxy_obs %6.2f $Nsel_exemins $(Nsel_exemins/60.0) $Nsel_exeburn $Nsel_lbs $xhrs\n"

}
//=========================
float PWT7 = 0.0;
float PWT14 = 0.0;
float PWT = 0.0; // tomorrow

float predictWL()
{
float pw;
double pwl[10];
pwl[0] = 0.0;
pwl[1] = 1.0;
double xv[5];
double yv[5];
int k = Nobs -5;
double xs = LDVEC[k];
pw = WTVEC[Nobs-1];

  if (Nobs > 5) {
    for (i =0; i < 5; i++) {   
       xv[i] = LDVEC[k] -xs;
       yv[i] =  WTVEC[k];
       k++;
//      <<"$i $k $LDVEC[k] $WTVEC[k] $xv[i] $yv[i]\n"; // TBF
    }
//   <<"%V $xv\n"
//   <<"%V $yv\n"
   
   pwl = Lfit(xv,yv);
   <<"pwl $pwl \n"
   // next day prediction

    pw = pwl[0] + (pwl[1] *5);
    PWT7 = pwl[0] + (pwl[1] * 12);
    PWT14 = pwl[0] + (pwl[1] * 19);
  }

<<"tomorrow's wt will be $pw +7 $PWT7\n"
          return pw;
}

//[EM]=================================//
//<<"Included compute module\n"
