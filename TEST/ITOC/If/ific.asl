#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

rh = -1
rh = $2
<<"%v $rh \n"

SetDebug(0,"run")


  if (rh < 0.0)
<<"%v $rh  < 0 \n"

  if (rh < 0.0) {
      rh = 0.0
   }

<<"%v $rh \n"
<<" XXXXXXXXXXXXXXXXXXXXXXXX \n"

 for (rh = -5 ; rh < 5 ; rh++) {


   if (rh < 0.0)
    <<"%v $rh  < 0 \n"

   if (rh > 0.0)
    <<"%v $rh  > 0 \n"

   if (rh == 0.0)
    <<"%v $rh == 0 \n"


   if (rh > 2.0) 
       break

  <<" at end \n"

 }

<<"out of for %v $rh \n"

  if (rh < 0.0) {
      rh = 0.0
   }
<<"%v $rh \n"

 STOP("DONE \n")

