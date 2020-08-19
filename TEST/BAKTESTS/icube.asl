
// test iteration

double x
double y
double s
double z


 s = 0.000000000001

// x = _clarg[1]

 x = 729;
 dx = fabs(x)

<<" $(typeof(x)) $x $dx \n"



   r= x/3.0


     s *= x

<<" $s  $x \n"



int k = 1

   while (1) {
 
     y = fabs(x - r * r * r)

    <<" %V $k $r $y  < $s\n"

    if (y < s) 
      break 

    k++

    nr = 0.5 * ( (x/(r * r) + r)

  <<" %V $nr = 0.25 * ( $x / $r  + $r + $r ) \n"

    r = nr

    if (k > 20)
       break

   }

 <<" $x cube root is $r \n"





///////////////////////////////
