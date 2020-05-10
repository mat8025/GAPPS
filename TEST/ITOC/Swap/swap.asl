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



checkIn(_dblevel)



proc add (int x, int y)
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


proc swap (ptr x, ptr y)
{

  float t = x;
  float t2 = y;
<<"$_proc IN : %V$x $y $t\n"

<<"%V $t  $(typeof(t))\n"
  //x = y;
  x = t2;
 <<"%V$x \n"
  y = t;
  
 <<"%V $y \n"

<<" OUT: %V $x $y $t $t2\n"

}
//====================

proc swapi (int x, int y)
{

   t = x;
   t2 = y;
<<"$_proc IN : %V$x $y $t\n"

<<"%V $t  $(typeof(t))\n"
  //x = y;
  x = t2;
 <<"%V$x \n"
  y = t;
  
 <<"%V $y \n"

<<" OUT: %V $x $y $t $t2\n"

}
//====================



proc swapR (int& x, int& y)
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





 int k = 4;
 int m = 3;

 int ans = 0;

 ans = add(k, m)

<<" $ans \n"

 checkNum(ans,7)

<<"%V$k $m  ref\n"
 swap (&k, &m)
 
<<" %V$k $m \n"



 checkNum(k,3)
 checkNum(m,4)


 checkout()

<<"%V$k $m  \n"

 swap (&k, &m)

<<" %V$k $m \n"

  checkNum(k,4)
  checkNum(m,3)

<<"%V$k $m  value\n"

checkStage()


<<" via main \n"


 int w = 0

// a swap
 k = 3;
 w = m
 m = k
 k = w

<<"%V $k $m $w\n"

checkNum(m,3)

int a = 6;
int b = 9;

<<" via proc \n"
<<"%V $a $b \n"

 swap(&a,&b)

 checkNum(a,9)

<<"%V$a $b \n"

 checkStage()
 

a = 7
b = 11


for (g = 0; g < 4; g++) {
 <<"preswap %V$g $a $b \n"
  swapi(&a,&b)
 <<"postswap %V$g $a $b \n"
 
}

 checkNum(a,7)

<<" diff vars %V$k $m\n"

for (g = 0; g < 3; g++) {

  swap(&k,&m)

<<"%V$g $k $m \n"

}



<<" orig vars %V$a $b\n"

for (g = 0; g < 3; g++) {

 swap(&a,&b)

<<"%V$g $a $b \n"
}


 checkNum(a,11)

checkStage()


float r = 3.0;
float q = 4.0;

 checkNum(r,3.0)

<<"%V $r $q\n"

   swap(&r,&q)

 checkNum(r,4.0)


<<"%V $r $q\n"

   swap(&r,&q)

 checkNum(r,3.0)


<<"pre- swap? %V $r $q\n"

   swap(r,q)

<<"no swap ? %V $r $q\n"

 checkNum(r,3.0)


   r = _PI ;
   
<<"pre- swap? %V $r $a\n"

   swap(&r,&a)

<<"post- swap? %V $r $a\n"




// ref parameters?
// not working
//   swapR(r,q)

//<<"swap ? %V $r $q\n"

 checkOut()


