///
///
///

setdebug(1,@pline,@~step,@trace,@showresults,1,@pause)
filterFuncDebug(ALLOWALL_,"proc","opera_ic");
filterFileDebug(ALLOWALL_,"ic_","proc");


CheckIn(2)

proc refarg (v)
{

<<"IN %V  $v  \n"

   z = v * 2;

<<"%V $v * 2 = $z\n"

   v++;
   
<<" changing first arg to %V$v\n"


<<"OUT %V $v  $z \n"

  return z;

}
//=======================//
int n = 2;
int m = 3;


  k = refarg(&n);

<<"%V $k $n  \n"

<<"%V proc returns $k \n"

  CheckNum(n,3)

  CheckNum(k,4)

  checkStage()

  k = refarg(&m);

<<"%V $k $n  \n"


  CheckNum(m,4)

  CheckNum(k,6)


  checkStage()

  n = 5;
  k = refarg(n);

<<"%V $k $n  \n"

<<"%V proc returns $k \n"

  CheckNum(n,5)

  CheckNum(k,10);



checkOut()

