#! /usr/local/GASP/bin/asl


N = $2

<<" N cube table \n"

 k = 1

 while ( k <= N ) {

   if ( k > N ) { 
    break
   }

//<<" out of if $k \n"


  a= k * k * k

 <<" cube of %6.0f $k  =  $a \n"

   k++

 }

<<"\n DONE %V $k  $N \n"

STOP!

///////////////////////////////
