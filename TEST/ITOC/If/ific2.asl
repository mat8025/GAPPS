#! /usr/local/GASP/bin/asl
#/* -*- c -*- */


proc testrh(vrh)
{
 <<"%v $vrh \n"

  if (vrh < 0.0) {

      vrh = 0.0
 <<"setting to zero %v $vrh \n"
   }

//<<" just doit \n"
  return vrh

  
}



rh = -1
rh = $2

<<"%v $rh \n"

 xrh = testrh (rh)
<<"%v $xrh \n"



  for (brh = -3 ; brh <= 3; brh++) {
    xrh = testrh (brh)
    <<"%V $brh -> $xrh\n"
  }

 STOP("DONE \n")

//<<"extra \n"


