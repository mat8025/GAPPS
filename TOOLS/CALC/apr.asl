#! /usr/local/GASP/bin/asl


total = 5000.0

apr = 11.4
mfc = 23.0

<<" $total $apr mfc %6.2f $mfc \n"

narp=""

while (1) {

//  total

 nt=ttyin(" Enter TOTAL owed [ $total ]  :")

 if (nt @= "q")
     stop()
// <<" %v $nt \n"
 if ( ! (nt @= ""))
  total = nt
<<" $total \n"
// apr

 napr=ttyin(" Enter APR [$apr ]?:")
// <<" $napr \n"
 if ( ! (napr @= "")) 
    apr = napr

// monthly fc

  mfc = (total/100.0 * apr ) / 12.0

<<" TOTAL $total APR $apr mfc %6.2f $mfc \n"

}
