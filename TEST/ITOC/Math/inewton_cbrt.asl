
// test iteration

CheckIn()

double x
double y
double s
double z
double r;

double rans = 47.000;

 s = 0.000001

 //x = getArgD()


  x = rans * rans * rans;
  

  dx = fabs(x);

<<" $(typeof(x)) $x $dx \n"



   r= x/3.0;

<<"%V $r \n"


//iread("->");

//   s *= x

   z = x;
   
   s *= z
   
   
   
<<" $s  $x $z\n"



int k = 1

double m = 1.0/3.0
double nr;

<<"%V$m \n"

   while (1) {
 
     //y = fabs(x - r * r * r)

      y = (x - r * r * r);
      
   if (y < 0.0) {
        y *= -1;
   }

    <<"%V $k $r $y  \n"

    if (y < s) 
      break 

    k++;

    nr = m * (x/(r*r) + 2.0*r)

  <<" %V $nr $r $x \n"
  //<<" $(typeof(nr)) $(typeof(x)) \n"

     r = nr;

    if (k > 60)
       break

//  iread(";> $r")
   }

 <<"cube root of  $x  is $r r^3 ==   $(r*r*r)\n"


 CheckFNum(rans,r,3)

 CheckOut()

STOP!




///////////////////////////////
