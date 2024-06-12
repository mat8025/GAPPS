


#include "debug.asl"; 



chkIn()

//filterFuncDebug(ALLOWALL_,"proc");
//filterFileDebug(ALLOWALL_,"ic_op");

proc swap (ptr x, ptr y)
{

  t = x;
  t2 = y;
<<"$_proc IN : %V$x $y $t\n"

<<"%V $t  $(typeof(t))\n"
  
  x = t2;
 <<"%V$x \n"
  y = t;
  
 <<"%V $y \n"

<<" OUT: %V $x $y $t $t2\n"

}
//====================

int k = 1;
int m = 2;

<<"pre %V $k $m \n"
// won't  call

 swap(&k,&m);

<<"post %V $k $m \n"

 chkN(k,2)
 chkN(m,1);

chkOut()

/*
 TBF  - ptr as proc arg definition acts as template
 to call via int k
 proc(&k)
 have to allow int ref arg to match to ptr arg
 that would also allow a float ref arg  to match


*/