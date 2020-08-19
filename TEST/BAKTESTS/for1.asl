#! /usr/local/GASP/bin/asl

N = 5

tt = $3


<<"%V $tt $N \n"


<<" $N $tt times table  test for statement \n"


  hue = 0
  hue2= 0
  for (k = 1 ; k < 10  ; k++ ) {

//<<" for begin loop val $k < $M \n"

  a= k * tt

 <<" $k * $tt = $a \n"
 
  if (k > N) {
   <<" $k > $N incr hue \n"
  hue = k
  hue2++
  }

 }

<<" DONE %V $k  $N $hue $hue2\n"

//////////////////////////////////////////////////////////////////


