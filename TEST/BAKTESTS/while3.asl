#! /usr/local/GASP/bin/spi


N = $2

int k = 0
int j = 0

 while ( k < N) {

   k++

    j = 0

 <<" outer %V $k  $j \n"


    while (j < N) {
      j++

 <<" inner %V $k  $j\n"

    }



 }

<<" DONE %V $k $j $N \n"

STOP!


///////////////////////////////
