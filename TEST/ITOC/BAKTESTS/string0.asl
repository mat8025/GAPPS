#! /usr/local/GASP/bin/asl

S = $2

<<" string arg is $S \n"

wlib = "math"

 <<" $wlib \n"


w3 = scat(wlib, S)

<<" %V $w3 \n"


STOP!

///////////////////////////////
