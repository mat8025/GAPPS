


proc powN(x, n)
{
// computes x^n via recursion
  t = 1.0

  if (n == 1) {
       return x;
  }
   else {

     m = n -1


//ttyin("about to recurse !! \n")
      r = x
<<"%V$n $r \n"
      t = powN(r,m) * r

     //<<"exit $_cproc %V $(typeof(t)) $t $pf * $mpf \n"
  }
     return t
}

float Sum = 1

proc polyN(p, x, n)
{
//static float sum = 0;
  t = 0.0
  r = 1.0
  if (n == 1) {
       return x;
  }
   else {

     m = n -1

      r = p * x
//     sum += r
     Sum += r
<<"%V$n $p $r $sum\n"
      t = polyN(r,x,m) + r

  }
     return t
}


 y = 0.0

 x= 2

 k = 5

 y = powN(x,k)

<<"%V$x $k $y \n"

 k = 3 ; Sum = x
 
 y = polyN(x,x,k)

<<"%V$x $k $y $Sum\n"


 k = 4 ; Sum = x

 y = polyN(x,x,k)

<<"%V$x $k $y $Sum\n"


 k = 5 ; Sum = x

 y = polyN(x,x,k)

<<"%V$x $k $y $Sum\n"


 k = 6 ; Sum = x

 y = polyN(x,x,k)

<<"%V$x $k $y $Sum\n"

stop!