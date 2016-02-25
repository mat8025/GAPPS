
// test iteration

setap(100)

pan x
pan y
pan s
pan z

pan rans = 9.000

 s = 0.0000000001

<<"%p$s \n"

 x = getArgN()

<<"%I$x\n"


 //   x = rans * rans * rans * rans * rans

 dx = fabs(x)

<<" $(typeof(x)) $x $dx \n"


// what is a good initial guess

   r= x/25.0
   int k = 1


// too big
   while (1) {

   y = (x - r * r * r * r * r)

   <<"$k $r $y\n"
   if (y > 1.0) 
      break

   r /= 10.0

   k++
   }


// too small
   k = 1
   while (1) {

   y = (x - r * r * r * r * r)

   <<"$k $r $y\n"
   if (y < 0.0) 
      break

   r *= 2

   k++
   }





<<"%V$r \n"

  //   s *= x

   z = x


   
<<"%V$s  $x $z\n"



  k = 1

float m = 1.0/5.0

<<"%V$m \n"

   while (1) {
 
  //   y = fabs(x - r * r * r * r * r)

     y = (x - r * r * r * r * r)

    if (y < 0.0) {
        y *= -1.0
    }


    <<"%V$k $r $y $s\n"

    if (y < 0.000001) 
      break 

    k++

    nr = m * (x/(r*r*r*r) + 4*r)

  <<" %V $nr $r $x \n"

    r = nr

    if (k > 50)
       break

//  iread(";> $r")
   }

 <<" $x 5th root is $r   $(r*r*r*r*r)\n"


// CheckFNum(rans,r,3)

// CheckOut()

STOP!




///////////////////////////////
