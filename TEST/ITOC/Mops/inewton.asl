#! /usr/local/GASP/bin/asl


ok=OpenDll("math")
// test iteration

double x
double y
double s
double z





 s = 0.00000000001

 x = $2

 dx = fabs(x)

<<" $(typeof(x)) $x $dx \n"



   r= x/2.0


     s *= x

<<" $s  $x \n"



int k = 1

   while (1) {
 
     y = fabs(x - r * r)

    <<" %V $k $r $y  \n"

    if (y < s) 
      break 

    k++

    nr = 0.5 * (x/r + r)

  <<" %V $nr = 0.5 * ( $x / $r  + $r ) \n"

    r = nr

    if (k > 30)
       break

   }

 <<" $x square root is $r \n"

STOP!




///////////////////////////////
