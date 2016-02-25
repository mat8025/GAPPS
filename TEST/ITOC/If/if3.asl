#! /usr/local/GASP/bin/spi




int k = $2
N = $3

<<" comparing $k with $N \n"

         if ( k > N ) 

         <<" $k > $N \n"
         else if (k == N) 

         <<" elseif1 $k == $N \n"

         else if (k >= (N -1)) {

         <<" elseif2 $k >= $N -1 \n"

         }
         else {

         <<" else $k < $N \n"
         }




<<" DONE $k $N \n"

STOP!


///////////////////////////////
