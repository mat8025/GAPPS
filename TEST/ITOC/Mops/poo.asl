#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

// test proc
<<" including poo !! \n"


proc poo()
{
// increments global k
// does calc and returns that value   

   k++
   a= k * 2

<<"  $_cproc %v $k $a\n" 

}


include "noo"


<<" finished including poo !! \n"

#end








