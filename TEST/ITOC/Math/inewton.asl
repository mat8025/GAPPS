
// test iteration

CheckIn()

double x
double y
double s
double z

double rans = 59.000

 s = 0.000001

 //x = getArgD()

//  x = 3481.0

    x = rans * rans

 dx = fabs(x)

<<" $(typeof(x)) $x $dx \n"



   r= x/2.0

<<"%V $r \n"

  //   s *= x
   z = x
   s *= z
   
<<" $s  $x $z\n"



int k = 1

   while (1) {
 
     y = fabs(x - r * r)

    <<"%V$k $r $y  \n"

    if (y < s) 
      break 

    k++

    nr = 0.5 * (x/r + r)

  <<" %V $nr = 0.5 * ( $x / $r  + $r ) \n"

    r = nr

    if (k > 30)
       break

//  iread(";> $r")
   }

 <<" $x square root is $r   $(r*r)\n"


 CheckFNum(rans,r,3)

 CheckOut()

STOP!




///////////////////////////////
