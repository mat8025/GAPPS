#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

// test pre/post inc/decr operators


j = 0

<<" %I $j \n"

j++

<<" %I $j \n"

I= Igen(10,0,1)

<<" %I $I \n"

a= I[j]

<<" %I $a \n"

a= I[j++]
<<" %I $a \n"
<<" %I $j \n"

a= I[j++]
<<" %I $a \n"
<<" %I $j \n"
 
 k = j
 while (j < 10) {
 a= I[j++]
<<" %I $j $k $a \n"

 }


STOP!



