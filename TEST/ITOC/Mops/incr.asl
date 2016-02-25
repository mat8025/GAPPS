#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
// test pinc/decr
svar targ
k = 0
na = get_argc()
 ac=2

 k = ac
<<" $k $ac \n"

 k = ac++

<<" $k $ac \n"

 k = ac++

<<" $k $ac \n"



STOP("DONE \n")



SetDebug(0)
 while (ac < na) {

// <<" $ac \n"
 targ = $ac
  sz = Caz(targ)
 ac++
  if ( targ @= "fixer") {

   k = 1

 <<" doing  if? $ac $k \n"
  }
  

 <<" did we do if? $ac $k \n"
 }


STOP("DONE \n")
