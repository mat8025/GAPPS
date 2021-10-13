//%*********************************************** 
//*  @script procrefarg.asl 
//* 
//*  @comment test proc ref & arg 
//*  @release CARBON 
//*  @vers 2.37 Rb Rubidium                                               
//*  @date Wed Jan  9 21:40:10 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
<|Use_=
Demo  of proc ref arg
///////////////////////
|>


///
/// procrefarg
#include "debug"







if (_dblevel >0) {
   debugON()
     <<"$Use_\n"   
}


chkIn(_dblevel)

allowErrors(-1) ; // keep going



/*
proc sumarg (ptr v, ptr u)
{
<<"args in %V  $v $u \n"
float z;

 v->info(1)
 u->info(1)

   z = $v + $u;

<<"%V $v + $u = $z\n"

   $v = $v +1;

<<" changing first arg to %V $v\n"


   v->info(1)

   lu = $u
<<"%V $lu \n"   
   $u = (lu * 2)

   //$u = $u * 2;
  // $u *= 2;


<<" changing second arg to %V $u \n"
u->info(1)
<<"args out %V $v $u $z\n"

<<" should return $z\n"

  return z;

}
//=======================//
*/

proc sumarg (int v, int u)
{
<<"args in %V  $v $u \n"
float z;
   z = v + u;

<<"%V$v + $u = $z\n"

//   v++;

      v = v +1;
<<" changing first arg to %V$v\n"

   u = u * 2;

<<" changing second arg to %V$u \n"

<<"args out %V$v $u $z\n"

  return z;
}
//=======================//

proc sumarg (float v, float u)
{
<<"args in %V  $v $u \n"
float z;
   z = v + u;

<<"%V$v + $u = $z\n"

   //v++;
      v = v +1;
<<" changing first arg to %V$v\n"

   u = u * 2;

<<" changing second arg to %V$u \n"

<<"args out %V$v $u $z\n"

  return z;
}
//=======================//



int n = 2;
int m = 3;

 pre_m = m;
 pre_n = n;

<<"%V$n \n"

    n++;

<<"%V$n \n"

    n--;

<<"%V$n \n"

p = 0;

<<"IN %V $n $m $p \n"

 p = sumarg(&n,&m)
 
<<"OUT %V $n $m $p \n"


chkN(n,3)

chkN(m,6)




float x = 13.3;
float y = 26.7;

chkR(x,13.3,3)

chkR(y,26.7,3)

 w = sumarg(&x,&y)
 
<<"%V $x $y $w \n"

chkR(x,14.3,3)

chkR(y,53.4,3)

chkR(w,40.0,6)



<<"Scalar args \n"
 n = 2;
 m = 3;
<<"calling %V $n $m \n"

int k = 0;

 k = sumarg(&n,&m);

<<"post %V $n $m $k\n"

<<"%V proc returns $k \n"

   chkN(n,3)

  chkN(m,6)

<<"%V $k\n"

//  chkN(k,5)

   chkN(5,k);

//

 n = 7;
 m = 14;

  k = sumarg(&n,&m)

<<"%V $n $m $k \n"

  chkN(k,21);



  chkN(n,8);
  chkN(m,28);



 n = 54;
 m = 49;

 k = sumarg(&n,m)

  chkN(n,55)
  chkN(m,49)
  chkN(k,103);
<<"%V $n $m $k \n"



chkOut()


 n = 79;
 m = 47;


k = sumarg2(n,&m)

  chkN(n,79)
  chkN(m,94)
  chkN(k,126);
<<"%V $n $m $k \n"



 n = 20;
 m = 28;

k = sumarg(&n,m)

  chkN(n,21)
  chkN(m,28)
  chkN(k,48);

<<"%V $n $m $k \n"


//%*********************************************** 
//*  @script proc_refarg.asl 
//* 
//*  @comment test ref/val arg proc call 
//*  @release CARBON 
//*  @vers 1.9 F Fluorine [asl 6.2.45 C-He-Rh]                             
//*  @date Sat May  9 16:15:25 2020 
//*  @cdate Sat May  9 16:07:07 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

Proc Hoo( int a, int b)
{
<<"$_proc  $a $b\n"
a->info(1)
   a = a +1;
b->info(1)
   b = b +1;
   c = a + b;
c->info(1)
  return c;

}

int n = 2;
int m = 3;


  r= Hoo(n,m)

<<"%V $r $n $m\n"


 chkR (r,7)

  r= Hoo(m,n)

<<"%V $r $n $m\n"


  r= Hoo(&n,m)

<<"%V $r $n $m\n"

 chkR (r,7)
 chkR (n,3)



  r= Hoo(n,&m)

<<"%V $r $n $m\n"

 chkR (r,8)
 chkR (n,3)
 chkR (m,4)



  r= Hoo(&n,&m)

<<"%V $r $n $m\n"

 chkR (r,9)
 chkR (n,4)
 chkR (m,5)


chkOut()


///////////////// TBD //////////////////
// should work? if call as Hoo(x,y) or Hoo(&x,&y)
// difference is &x makes it a ref argument so it can be modified inside of proc
// else modification does not carry to calling scope
//
// xic version fails - fix
//




//////////// TBD ////////////
// BUG XIC version  -- won't find ref argument
