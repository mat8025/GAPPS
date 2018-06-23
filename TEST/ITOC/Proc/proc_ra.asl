setdebug(1,@pline,@~step,@trace,@showresults,1)
filterFuncDebug(ALLOWALL_,"proc","opera_ic");
filterFileDebug(ALLOW_,"ic_op","ic_pu","ic_x","proc","opera","ds_siv");


CheckIn()

proc refarg (v)
{

<<"IN %V  $v  \n"

   //v = 79;
   v++;
<<"OUT %V $v  \n"


}
//=======================//
int n = 94;
int m = 84;

   pre_n = n;
   
   refarg(&n);

<<"%V  $n  \n"

<<"%V proc modifies? $pre_n !=  $n \n"

  CheckNum(n,95)
  pre_m = m;
  refarg(m);

<<"%V $m  \n"
  pre_m = m;
  CheckNum(m,pre_m)

<<"%V proc does not modifies arg? $pre_m == $m \n"

checkOut()

