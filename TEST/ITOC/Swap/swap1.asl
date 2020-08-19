


include "debug.asl"; 
debugON();


chkIn()

filterFuncDebug(ALLOWALL_,"proc");
filterFileDebug(ALLOWALL_,"ic_op");

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

 swap(&k,&m);

<<"post %V $k $m \n"

 chkN(k,2)
 chkN(m,1);

chkOut()