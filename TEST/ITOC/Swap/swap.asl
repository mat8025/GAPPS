//%*********************************************** 
//*  @script swap.asl 
//* 
//*  @comment check ref arg via swap 
//*  @release CARBON 
//*  @vers 2.57 La Lanthanum [asl 6.2.46 C-He-Pd]                          
//*  @date Sun May 10 12:59:32 2020 
//*  @cdate 9/6/99 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///  demo ptr/ref args
///

#include "debug.asl";


if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)



int add (int x, int y)
{

<<"$_proc IN : %V$x $y \n"
  q = x;
<<"%V$q  $(typeof(q))\n"  
  t = x + y;
<<"%V$t  $(typeof(t))\n"

<<" OUT: %V$x $y $t\n"
   return t;
}
//====================


proc swapP (ptr x, ptr y)
{

  float t = $x;
  float t2 = $y;
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


void swap (int x, int y)
{

  t = x;
  t2 = y;
<<"$_proc INT : %V$x $y $t $t2\n"

<<"%V $t  $(typeof(t))\n"
  x = y;
 <<"%V $x \n"
  x = t2 
  y = t;
  
 <<"%V $y \n"

<<" OUT: %V $x $y $t $t2\n"

}
//====================

/*
/// TBF - REF parameter
void swapR (int& x, int& y)
{

  t = x;

<<"$_proc IN : %V$x $y $t\n"

<<"%V$t  $(typeof(t))\n"
  x = y;
 <<"%V$x \n"
  y = t;
 <<"%V$y \n"

<<" OUT: %V$x $y $t\n"

}
//====================
*/




 int k = 4;
 int m = 3;

 int ans = 0;

 ans = add(k, m)

<<" $ans \n"

 chkN(ans,7)

<<"%V$k $m  ref\n"
 swap (&k, &m)
 
<<" %V$k $m \n"



 chkN(k,3)
 chkN(m,4)



<<"%V$k $m  \n"


chkOut()
exit();

 swapP (&k, &m)

<<" %V$k $m \n"

  chkN(k,4)
  
  chkN(m,3)

<<"%V$k $m  value\n"

chkStage()


<<" via main \n"


 int w = 0

// a swap
 k = 3;
 w = m
 m = k
 k = w

<<"%V $k $m $w\n"

chkN(m,3)

int a = 6;
int b = 9;

<<" via proc \n"
<<"%V $a $b \n"

 //swap(&a,&b)

 //chkN(a,9)

<<"%V$a $b \n"

 //chkStage()


 swapP(&a,&b)

 chkN(a,9)
 chkN(b,6)

<<"%V$a $b \n"

 chkStage("ptrs")
 

a = 7
b = 11


<<"%V $a $b \n"

a->info(1)

for (g = 0; g < 4; g++) {
 <<"preswap %V $g $a $b \n"
  swapP(&a,&b)
 <<"postswap %V $g $a $b \n"
 
}


<<"%V $a $b \n"

a->info(1)

 chkN(a,7)


k = 47;
m = 79;


<<" diff vars %V$k $m\n"
 k->info(1)
 

//  swapR(k,m)
  
k->info(1)



for (g = 0; g < 3; g++) {

  swapP(&k,&m)

<<"%V$g $k $m \n"

}

 k->info(1)


<<" orig vars %V$a $b\n"
a->info(1)
for (g = 0; g < 3; g++) {

 swapP(&a,&b)

a->info(1)
<<"%V $a $b \n"
//<<"%V $g $a $b \n"
}



 chkN(a,11)

chkStage()


float r = 3.0;
float q = 4.0;

 chkN(r,3.0)

<<"%V $r $q\n"

   swapP(&r,&q)

 chkN(r,4.0)


<<"%V $r $q\n"

   swapP(&r,&q)

 chkN(r,3.0)



   r = _PI ;
   
<<"pre- swap? %V $r $a\n"

   swapP(&r,&a)

<<"post- swap? %V $r $a\n"

// ref parameters?
// not working

//  swapR(r,q)

//<<"swap ? %V $r $q\n"

 chkOut()


