setdebug(0)

proc sumarg ( v, u)
{
<<"%V  $v $u \n"

  z = v + u

  v = z + u
  return z

}


int n = 2
int m = 3


k = sumarg(n,m)


<<"%V $n $m $k \n"


 n = 7
 m = 14


k = sumarg(n,m)


<<"%V $n $m $k \n"

 if ( k == 21) {
<<" correct !\n"
 }

float x = 16.30
float y = 23.70

 w = sumarg(x,y)
<<"%V %6.4f $x $y $w \n"

  if ( w == 40.0 ) {
<<" correct !\n"
 }

 n = 79
 m = 47

k = sumarg(n,m)

<<"%V $n $m $k \n"



 n = 20
 m = 28

k = sumarg(n,m)

<<"%V $n $m $k \n"


stop!