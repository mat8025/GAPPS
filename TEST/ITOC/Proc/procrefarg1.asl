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
    v->info(1);

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
int o = 3;

int pre_m = 3;

  n->info(1);

  k = refarg(&n);

  n->info(1);
<<"%V $k $n  \n"

<<"%V proc returns $k \n"

  CheckNum(n,3)

  CheckNum(k,4)

  checkStage()

  m->info(1);

  k = refarg(&m);

  m->info(1);
  
<<"%V $k $m  \n"

  CheckNum(m,4)

  CheckNum(k,(pre_m*2))


  checkStage()

  o = 5;

  o->info(1);
  
  k = refarg(o);

  o->info(1);
 
<<"%V $k $o  \n"

<<"%V proc returns $k \n"

  CheckNum(o,5)

  CheckNum(k,o*2);


  checkStage()

  n = 5;

  n->info(1);

  k = refarg(n);

  n->info(1);

<<"%V $k $n  \n"

<<"%V proc returns $k \n"

  CheckNum(n,5)

  CheckNum(k,n*2);

  m = 45;

  m->info(1);

  k = refarg(m);


  m->info(1);
  
<<"%V $k $m  \n"
<<"%V proc returns $k \n"

  CheckNum(m,45)

  CheckNum(k,m*2);

  checkOut()

