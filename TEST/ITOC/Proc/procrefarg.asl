///
/// procrefarg

setdebug(1,"pline","~step","trace")


CheckIn()

proc sumarg ( v, u)
{
<<"args in %V  $v $u \n"

   z = v + u;

<<"%V$v + $u = $z\n"

   v++;
<<" changing first arg  %V$v\n"

//   v = 3
//<<" changing first arg  %V$v\n"

   u = u * 2

<<" changing second arg  %V$u \n"

<<"args out %V$v $u \n"

  return z

}


int n = 2;
int m = 3;

 pre_m = m
 pre_n = n

<<"%V$n \n"

    n++;

<<"%V$n \n"

    n--;

<<"%V$n \n"


<<"Scalar args \n"
<<"calling %V $n $m \n"

  k = sumarg(&n,&m);

<<"post %V $n $m \n"

<<"%V proc returns $k \n"

  CheckNum(n,3)

  if (n == 3) {
<<" correct !\n"
  }
  else {
<<" badness !\n"
  }



  CheckNum(m,6)

  if (m == 6) {
<<" correct !\n"
  }
  else {
<<" badness !\n"
  }

  CheckNum(k,5)

  if (k == 5) {
<<" correct !\n"
  }
  else {
<<" badness !\n"
  }



 n = 7
 m = 14


k = sumarg(&n,&m)


<<"%V $n $m $k \n"



float x = 13.3
float y = 26.7

 w = sumarg(&x,&y)
<<"%V $x $y $w \n"

 CheckFNum(w,40.0,6)

 n = 79;
 m = 47;

k = sumarg(n,m)

<<"%V $n $m $k \n"



 n = 20
 m = 28

k = sumarg(n,m)

<<"%V $n $m $k \n"

 CheckOut()

stop!

//////////// TBD ////////////
// BUG XIC version  -- won't find ref argument
