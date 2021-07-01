///
///
///

#include "debug.asl";


if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)


void swapP (ptr x, ptr y)
{

   t = $x;
   t2 = $y;
<<"$_proc PTR args  : %V$x $y $t\n"

   t->info(1)

   t2->info(1)

<<"%V $t  \n"
<<"%V $t2  \n"

//<<"%V $t  $(typeof(t))\n"

  x->info(1)

  $x = t2;
 <<"%V$x \n"

  x->info(1)
 
  $y = t;
  
 <<"%V $y \n"

<<" OUT: %V $x $y $t $t2\n"

}
//====================

int k = 3;
int m =4;


 kp = &k;

 kp->info(1)

 mp= &m;

 mp->info(1)



 swapP (kp, mp)

<<" %V$k $m \n"

  chkN(k,4)
  
  chkN(m,3)

<<"%V$k $m  \n"

float r= 3.0;
float q= 4.0;


rp = &r;

qp = &q;

swapP (rp, qp)



<<"%V$r $q  \n"


float u= 3.0;
float v= 4.0;

// won't call 
swapP (&u, &v)

<<"%V$u $v  \n"