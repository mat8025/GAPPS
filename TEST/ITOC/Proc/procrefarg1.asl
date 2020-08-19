///
///
///

setdebug(1,@pline,@~step,@trace,@showresults,1,@pause)
filterFuncDebug(ALLOWALL_,"proc","opera_ic");
filterFileDebug(ALLOWALL_,"ic_","proc");


chkIn(2)

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

  chkN(n,3)

  chkN(k,4)

  checkStage()

  m->info(1);

  k = refarg(&m);

  m->info(1);
  
<<"%V $k $m  \n"

  chkN(m,4)

  chkN(k,(pre_m*2))


  checkStage()

  o = 5;

  o->info(1);
  
  k = refarg(o);

  o->info(1);
 
<<"%V $k $o  \n"

<<"%V proc returns $k \n"

  chkN(o,5)

  chkN(k,o*2);


  checkStage()

  n = 5;

  n->info(1);

  k = refarg(n);

  n->info(1);

<<"%V $k $n  \n"

<<"%V proc returns $k \n"

  chkN(n,5)

  chkN(k,n*2);

  m = 45;

  m->info(1);

  k = refarg(m);


  m->info(1);
  
<<"%V $k $m  \n"
<<"%V proc returns $k \n"

  chkN(m,45)

  chkN(k,m*2);

  chkOut()

