
xhrs = 0;

proc computeWL( wlsday, wleday)
{
// use input of juldays
// find the number of exe hours
// read the number of cals burnt during exercise
// compute the number of lbs burnt

int i

   Nsel_exemins = 0
   Nsel_exeburn = 0

   Nxy_obs = 0

   Nsel_lbs = 0.0


   for (i = 0; i < Nobs ; i++) {

     if (LDVEC[i] >= wlsday) {

        Nxy_obs++

        Nsel_exeburn += EXEBURN[i]
        Nsel_exemins += EXTV[i]
//<<"%V $i $Nsel_exeburn $Nsel_exemins \n"
     }

     if (LDVEC[i] > wleday) 
             break; 
   }

   Nsel_lbs = Nsel_exeburn/ 4000.0

  xhrs = (Nsel_exemins/60.0)

//<<"%V$Nxy_obs %6.2f $Nsel_exemins $(Nsel_exemins/60.0) $Nsel_exeburn $Nsel_lbs $xhrs\n"




}


