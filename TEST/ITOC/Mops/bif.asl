#! /usr/local/GASP/bin/asl

// use builtin  function - no dll lib

N = $2

// wr = "sqrt"
//<<" N ${wr}root table \n"

//<<" N sqroot table \n"

 k = 1.0

 float a

 j = 2

 while ( k <= N ) {

   if ( k > N ) { 
    break
   }

//<<" out of if $k \n"

  a= flop (k)

 <<" flop of  $k  =  $a \n"

   k++

 }

<<"\n DONE %V $k  $N \n"

STOP!

///////////////////////////////
