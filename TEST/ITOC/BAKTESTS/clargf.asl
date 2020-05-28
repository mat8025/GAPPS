#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
//  
setPCW("writeexe","writepic")
 v = $2
<<" $v \n"

 na = argc()
 <<" %v $na \n"


 while (1) {

    na = AnotherArg()
    f = GetArgF()

<<" $na $f \n"
    if (na <= 0)
         break

 }

ttyin()

STOP!





 svar av
 for (i = 2; i < na ; i++) {
   av = $i
  <<" $i $av  $(typeof(av))\n"



 }



STOP("DONE \n")

