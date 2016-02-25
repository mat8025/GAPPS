#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
// test declare word read

Svar W  // string object

k = 33
f = 1.234567


<<"$k\t$f\n"



<<"${k}\t${f}\n"
<<"${k}\t$f\n"

color ="white"

<<" $color \n"


STOP("DONE ")
