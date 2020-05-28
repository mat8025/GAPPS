#! /usr/local/GASP/bin/asl
OpenDll("math")

N = $2

<<" N cuberoot table \n"

 k = 1.0
float a


 while ( k <= N ) {

   if ( k > N ) { 
    break
   }

    a= cbrt (k)


 <<" cuberoot of  $k  =  $a \n"

   k++

 }

<<"\n DONE %V $k  $N \n"

STOP!

///////////////////////////////
