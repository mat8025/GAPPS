#! /usr/local/GASP/bin/asl

ok=OpenDll("math")
// test iteration

pan x
pan y
pan s
pan z

// FIX - some 10-9 is 0 10-10 is > 0

 z = 0.00000000001

 y = 0.000000000001

 s1 = 0.0001

 s = s1

 s *= .00001

 x = $2

<<" %V $(typeof(x)) $x  $s $z $y\n"

  r= x/2.0

  s = s * x

int k = 1

   while (1) {

     y = fabs(x - r * r)

    <<" %V $k $r $y $s\n"

    if (y < s) 
      break 

    k++

    nr = 0.5 * (x/r + r)

  <<" %V $nr = 0.5 * ( $x / $r  + $r ) \n"

    r = nr

    if (k > 10)
       break

   }

 <<" $x square root is $r \n"

STOP!




///////////////////////////////
