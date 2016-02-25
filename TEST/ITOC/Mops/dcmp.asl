#! /usr/local/GASP/bin/asl

int ok = 0
int bad = 0
int ntest = 0

double a
double b

  a = $2

  b =a + 0.0001



 C= (b && a)

<<" $b && $a $C \n"


 C= (b & a)

<<" $b & $a $C \n"

 k = 1
while (1) {

 a *= 10
 b = a  + 0.1

 C= (a < b)

<<" $a < $b $C \n"

 C= (a <= b)

<<" $a <= $b $C \n"


 C= (b > a)

<<" $b > $a $C \n"

 C= (b >= a)

<<" $b >= $a $C \n"

 C= (b == a)

<<" $b == $a $C \n"


 C= (b != a)

<<" $b != $a $C \n \n"


  if (b == a)
    break

 k++
}

<<" $k \n"

STOP!
