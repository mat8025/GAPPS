#! /usr/local/GASP/bin/asl

N = $2

<<" $N \n"

#{

  Test If variations

#}

itest = 1

  if (N > 1 ) 
    <<"$itest $N > 1 \n"

<<" IF 1 \n"
itest++

  if (N > 1 ) 
    <<"$itest $N > 1 \n"
  else
    <<" $N <= 1 \n"

itest++


<<" DONE %V   $N  \n"

//////////////////////////////////////////////////////////////////


