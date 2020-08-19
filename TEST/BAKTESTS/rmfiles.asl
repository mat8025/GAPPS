#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
//  
SetPCW("writepic","writeexe")

 v = $2
<<" $v \n"

 na = argc()
 <<" %v $na \n"


 svar av

 for (i = 1; i < na ; i++) {
   av = $i
  <<" $i $av  $(typeof(av))\n"

!!" ls -l ${av}[a-c]"

<<"\n"

 }



STOP!
