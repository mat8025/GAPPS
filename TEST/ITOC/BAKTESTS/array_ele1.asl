
setdebug(1)

proc array_sub( rl)
{

<<"%6.2f$rl %I$rl\n"
kp = 1
jp1 = 2
jp2 = 3

  rl[kp] = rl[jp1] - rl[jp2];
  fp= rl[kp]

<<"just ele %6.2f $rl[kp] \n"
<<"fp $fp %I$fp\n"
}


double Real[10]

Real = dgen(10,0,1)

<<"%6.2f $Real  \n"

 k = 1
 j1 = 2
 j2 = 3

 Real[k] = Real[j1] - Real[j2];

  f= Real[k]

<<"just ele %6.2f $Real[k] \n"
<<"f $f %I$f\n"


 array_sub(Real)

 


