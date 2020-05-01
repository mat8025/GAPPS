//%*********************************************** 
//*  @script swap.asl 
//* 
//*  @comment check ref arg via swap 
//*  @release CARBON 
//*  @vers 2.56 Ba Barium                                                 
//*  @date Thu Jan 10 18:13:45 2019 
//*  @cdate 9/6/99 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///  demo ptr/ref args
///

//#define ASK ans=iread();

#define ASK ;


checkIn()
setdebug(1,@pline,@~step,@~trace,@showresults,1)
filterFuncDebug(ALLOWALL_,"proc");
filterFileDebug(ALLOWALL_,"ic_op");



proc add ( x, y)
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

proc swapi ( x, y)
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

 CheckNum(ans,7)

<<"%V$k $m  ref\n"
 swap (&k, &m)
 
<<" %V$k $m \n"



 CheckNum(k,3)
 CheckNum(m,4)


 checkout()
ASK
<<"%V$k $m  \n"

 swap (&k, &m)

<<" %V$k $m \n"

  CheckNum(k,4)
  CheckNum(m,3)

<<"%V$k $m  value\n"

checkStage()
ASK

<<" via main \n"


 int w = 0

// a swap
 k = 3;
 w = m
 m = k
 k = w

<<"%V $k $m $w\n"

CheckNum(m,3)

int a = 6;
int b = 9;

<<" via proc \n"
<<"%V $a $b \n"

 swap(&a,&b)

 CheckNum(a,9)

<<"%V$a $b \n"

 checkStage()
 ASK

a = 7
b = 11


for (g = 0; g < 4; g++) {
 <<"preswap %V$g $a $b \n"
  swapi(&a,&b)
 <<"postswap %V$g $a $b \n"
 
}

 CheckNum(a,7)

<<" diff vars %V$k $m\n"

for (g = 0; g < 3; g++) {

  swap(&k,&m)

<<"%V$g $k $m \n"
ASK
}



<<" orig vars %V$a $b\n"

for (g = 0; g < 3; g++) {

 swap(&a,&b)

<<"%V$g $a $b \n"
}


 CheckNum(a,11)

checkStage()

ASK
float r = 3.0;
float q = 4.0;

 CheckNum(r,3.0)

<<"%V $r $q\n"

   swap(&r,&q)

 CheckNum(r,4.0)


<<"%V $r $q\n"

   swap(&r,&q)

 CheckNum(r,3.0)


<<"pre- swap? %V $r $q\n"

   swap(r,q)

<<"no swap ? %V $r $q\n"

 CheckNum(r,3.0)


   r = _PI ;
   
<<"pre- swap? %V $r $a\n"

   swap(&r,&a)

<<"post- swap? %V $r $a\n"




// ref parameters?
// not working
//   swapR(r,q)

//<<"swap ? %V $r $q\n"

 CheckOut()


