#! /usr/local/GASP/bin/sip
#/* -*- c -*- */
# vector and matrix math

set_debug(0,"step")

OpenDll("math")
failures = 0

proc stop(){<<" %v $failures \n";set_si_error(1);exit_si();}



I = Igen(10,1,1)

<<" $I \n"


J = Mdimn(I,1,10)

<<" $J \n"

bd = Cab(J)
<<" $bd \n"

K= ReflectCol(J)

<<" $K \n"

K= Reflect(J)

<<" $K \n"

J = Mdimn(I,2,5)

<<" $J \n"

bd = Cab(J)
<<" $bd \n"

K= ReflectCol(J)

<<" $K \n"

K= Reflect(J)

<<" $K \n"




stop()