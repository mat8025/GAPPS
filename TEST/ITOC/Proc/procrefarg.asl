///
/// procrefarg

setdebug(1,@pline,@~step,@trace)
filterFuncDebug(ALLOWALL_);
filterFileDebug(ALLOWALL_,"declare_type","array_subset","storetype","ds_store","ds_vector");



CheckIn()

proc sumarg ( v, u)
{
<<"args in %V  $v $u \n"

   z = v + u;

<<"%V$v + $u = $z\n"

   v++;
<<" changing first arg  %V$v\n"

   u = u * 2;

<<" changing second arg  %V$u \n"

<<"args out %V$v $u \n"

  return z;

}
//=======================//

int n = 2;
int m = 3;

 pre_m = m;
 pre_n = n;

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

  CheckNum(m,6)

  CheckNum(k,5)

//

 n = 7;
 m = 14;


 k = sumarg(&n,&m)

  CheckNum(n,8)
  CheckNum(m,28)
  CheckNum(k,21);
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



 n = 20;
 m = 28;

k = sumarg(n,m)

<<"%V $n $m $k \n"

 CheckOut()



//////////// TBD ////////////
// BUG XIC version  -- won't find ref argument
