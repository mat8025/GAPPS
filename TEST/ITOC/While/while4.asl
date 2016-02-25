#! /usr/local/GASP/bin/spi

// nested whiles

N = $2

int k = 0
int j = 0
int m = 0

 while ( k < N) {

   k++

    j = 0
    m = 0
 <<" outer %V $k  $j $m\n"


    while (j < N) {
      j++

 <<" inner %V $k  $j $m\n"
        while (m < N) {
      m++

 <<" innermost %V $k  $j $m\n"

        }


    }



 }

<<" DONE %V $k $j $m $N \n"

STOP!


///////////////////////////////
