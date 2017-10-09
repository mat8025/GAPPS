///
///  bug corrupt interp print --- xic print is OK
///

    svar descr;
    float wt=234.5;     // grams
    float satfat= 8.87;
    int fat= 2;    
    int carbs= 30;
    float prot=1.234;;
    int chol= 3;   // mgrams
    int cals = 101;
    svar unit ; //could be 1/2
    svar amt ;
    svar decsr;

    unit = "cup";
    amt = "1";
    descr = "APPLE PIE  1 PIECE       18       405          60         3        0       158      4.6"

<<"%V$fat\n";
<<"%V$carbs\n";

setdebug(0);


//<<"${descr[0]}: $amt[0] $unit[0] %V$cals $carbs $fat $chol(mg) %4.1f$prot $satfat  $wt  \n"

<<"${descr[0]} $amt[0] $unit[0] %V$cals $carbs $fat $chol(mg) %4.1f$prot $satfat  $wt  \n"
<<"${descr[0]} $amt[0] $unit[0] %V$cals $carbs $fat $chol mg %4.1f$prot $satfat  $wt  \n"


//////////////////////////////////////

proc fd_print()
    {
     //<<"$descr[0]: $amt[0] $unit[0] %V$cals $carbs $fat $chol(mg) %4.1f$prot $satfat  $wt  \n"  // : prevents print why?
     <<"$descr[0] $amt[0] $unit[0] %V$cals $carbs $fat $chol(mg) %4.1f$prot $satfat  $wt  \n"
    }

  fd_print()

  fd_print()


    carbs = 100;
    cals = 405;
    satfat = 4.6;

   fd_print();

////
///  fix to bug in svar->splice --- splice at end current of removed terminating null
///  added null in that case
///