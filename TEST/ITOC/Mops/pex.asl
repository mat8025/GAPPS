#! /usr/local/GASP/bin/asl


ver=version()

<<" $(version()) $ver \n"

  k = 1

f = 3.1234567

  for (i = 0; i < 3 ; i++) {

  <<" %v $i \n"
  var = "$i"
  var2 = "${i}_$k"

  <<" $i $var $var2 %6.2f $f\n"
  k++
  f *= k
  }


STOP!
