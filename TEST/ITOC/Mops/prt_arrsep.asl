#! /usr/local/GASP/bin/asl
#/* -*- c -*- */



//SetDebug(0,"run")


R= Fgen(1000,0,1.456789)
//<<" $(Cab(R)) \n"


 T= R + 33
//<<" $T,\n"
k = 0
Redimn(R,200,5)

//<<" $R[0][*], \n"
j = 2
<<"$j   %|a%5.2f$R[j][*] \n"


  for (j = 0; j < 5 ; j++) {

     k++ 

<<"$j %|a%5.2f$R[j][*]\n"

<<"$j %,a%3.2f$R[j][*] \n"

    <<" $k \n"
  }

<<" $k \n"

STOP("DONE \n")