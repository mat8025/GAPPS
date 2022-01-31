
//%*********************************************** 
//*  @script wex_compute.asl 
//* 
//*  @comment  
//*  @release CARBON

//*  @vers 1.1 H Hydrogen                                                 
//*  @date Sat Dec 29 09:06:02 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%

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
<<"$_proc %V $wlsday $wleday  $Nobs\n"

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

<<"%V$Nxy_obs %6.2f $Nsel_exemins $(Nsel_exemins/60.0) $Nsel_exeburn $Nsel_lbs $xhrs\n"

}
//=========================

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
       <<"$i $k $LDVEC[k] $WTVEC[k] $xv[i] $yv[i]\n"; // TBF
    }
   <<"%V $xv\n"
   <<"%V $yv\n"
   
   pwl = Lfit(xv,yv);
   <<"pwl $pwl \n"
   // next day prediction

    pw = pwl[0] + (pwl[1] *5);

  }

<<"tomorrow's wt will be $pw \n"
          return pw;
}

//[EM]=================================//
<<"Included compute module\n"
