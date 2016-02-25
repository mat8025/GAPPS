#! /usr/local/GASP/bin/asl

N = $2

<<" $N \n"

 y = 4.0

<<" $y \n"

wlib = "math"

 <<" $wlib \n"

w3 = scat(wlib, "dll")

<<" $w3 \n"

ok=OpenDll(wlib)



 y = cbrt(8.0)

<<" $ok $y \n"

STOP!

///////////////////////////////
