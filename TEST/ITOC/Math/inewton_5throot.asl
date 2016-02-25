OpenDll("math")
// test iteration

CheckIn()

double x
double y
double s
double z

double rans = 9.000

 s = 0.000001

 //x = getArgD()


    x = rans * rans * rans * rans * rans

 dx = fabs(x)

<<" $(typeof(x)) $x $dx \n"



   r= x/5.0

<<"%V $r \n"

  //   s *= x

   z = x
   s *= z
   
<<" $s  $x $z\n"



int k = 1

float m = 1.0/5.0
<<"%V$m \n"

   while (1) {
 
     y = fabs(x - r * r * r * r * r)

    <<"%V$k $r $y  \n"

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


 CheckFNum(rans,r,3)

 CheckOut()

STOP!




///////////////////////////////
