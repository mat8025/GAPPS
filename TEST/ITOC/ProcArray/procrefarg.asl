
chkIn()

int sumarg (int v, int  u)
{
<<"args in %V  $v $u \n"

   z = v + u

<<"%V  $v + $u = $z\n"
   v++
<<" changing first arg  %V $u \n"
   u = u * 2
<<" changing second arg  %V $u \n"
<<"args out %V  $v $u \n"
  return z

}


int n = 2
int m = 3

 pre_m = m
 pre_n = n


<<"Scalar args \n"
<<"calling %V $n $m \n"

  k = sumarg(n,m)

<<"post %V $n $m \n"

<<"%V proc returns $k \n"

  chkN(n,2)
  chkN(m,3)

  chkN(k,5)

  k = sumarg(&n,&m)

  chkN(n,3)
  chkN(m,6)

  chkN(k,5)

chkout()

exit()


 n = 7
 m = 14


k = sumarg(n,&m)


<<"%V $n $m $k \n"



float x = 13.3
float y = 26.7

 w = sumarg(&x,y)
<<"%V $x $y $w \n"

 chkR(w,40.0,6)

 n = 79
 m = 47

k = sumarg(&n,m)

<<"%V $n $m $k \n"



 n = 20
 m = 28

k = sumarg(&n,m)

<<"%V $n $m $k \n"

 chkOut()


//////////// TBD ////////////
// BUG XIC version  -- won't find ref argument