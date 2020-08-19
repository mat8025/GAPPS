
// test iteration



double x
double y
double s
double z

double rans = 9.000

 s = 0.000001

 x = getArgN()

<<"%I$x\n"


 //   x = rans * rans * rans * rans * rans

 dx = fabs(x)

<<" $(typeof(x)) $x $dx \n"



   //r= x/5.0
    r= x/10.0

<<"%V$r \n"

  //   s *= x

   z = x

   s *= z
   
<<"%V$s  $x $z\n"



int k = 1

float m = 1.0/5.0

<<"%V$m \n"

   while (1) {
 
  //   y = fabs(x - r * r * r * r * r)

     y = (x - r * r * r * r * r)

    if (y < 0.0) {
        y *= -1.0
    }


    <<"%V$k $r $y  $s\n"

    if (y < s) 
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


// chkR(rans,r,3)

// chkOut()

STOP!




///////////////////////////////
