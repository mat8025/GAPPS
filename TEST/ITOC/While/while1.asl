#! /usr/local/GASP/bin/asl


N = $2

int k = 0

 while ( k < N)  k++;

<<" DONE $k $N \n"

 k =0
 int m = 0
 while ( k++ < N) {
   m++
   <<" $k $m \n"

 }


#{
 k = 0
 while ( k < N)   { 
 <<" $k  \n" ; 
  k++ ;
   }
#}

<<" DONE $k $N \n"

STOP!


///////////////////////////////
