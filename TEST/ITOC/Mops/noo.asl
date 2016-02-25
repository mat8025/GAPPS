#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

// test proc
<<" including noo !! \n"


proc noo()
{
// increments global k
// does calc and returns that value   

   k++
   a= k * 2

<<"  $_cproc %v $k $a\n" 

}




<<" finished including noo !! \n"

#end








