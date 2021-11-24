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

   allowErrors(-1) ; // keep going;

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   chkIn(_dblevel);
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


   int sumarg (int v, int u)
   {

     <<"args int %V  $v $u \n";

     v.pinfo();

     u.pinfo();


     int z;

     z.pinfo();

     z = v + u;

     z.pinfo();

     v.pinfo();

     u.pinfo();

     <<"%V$v + $u = $z\n";
!z
//   v++;

     v = v +1;

     <<" changing first arg to %V$v\n";

     v.pinfo();

     u = u * 2;

     <<" changing second arg to %V$u \n";

     u.pinfo();

     <<"args out %V$v $u $z\n";
!z

     return z;

     }
//=======================//

   proc sumarg (float vf, float uf)
   {

     <<"args float  %V  $vf $uf \n";
     float z;
     z = vf + uf;

     <<"%V$vf + $uf = $z\n";
   //v++;

     vf = vf +1;

     <<" changing first arg to %V$vf\n";
!z

     uf = uf * 2;

     <<" changing second arg to %V$uf \n";

     <<"args out %V$vf $uf $z\n";

     return z;

     }
//=======================//

   int n = 2;

   int m = 3;

   pre_m = m;

   pre_n = n;

   <<"%V$n \n";

   n++;

   <<"%V$n \n";

   n--;

   <<"%V$n \n";

   p = 0;

   <<"IN %V $n $m $p \n";

   <<"should be calling summarg int args vers with  ref args\n";

   p = sumarg(&n,&m);

   <<"returned %V $n $m $p \n";

   chkN(n,3);

   chkN(m,6);


   <<"should be calling summarg int args vers with  val args\n";

   <<"IN %V $n $m $p \n";

   int o = 4;

   int q = 7;

   p = sumarg(o,q);

   <<"returned %V $n $m $p \n";

   chkN(o,4);

   chkN(q,7);

//chkOut()

   chkN(p,11);

   float x = 13.3;

   float y = 26.7;

   chkR(x,13.3,3);

   chkR(y,26.7,3);

   w = sumarg(&x,&y);

   <<"%V $x $y $w \n";

   chkR(x,14.3,3);

   chkR(y,53.4,3);

   chkR(w,40.0,6);

   <<"Scalar args \n";

   n = 2;

   m = 3;

   <<"calling %V $n $m \n";

   int k = 0;

   k = sumarg(&n,&m);

   <<"post %V $n $m $k\n";

   <<"%V proc returns $k \n";

   chkN(n,3);

   chkN(m,6);

   <<"%V $k\n";
//  chkN(k,5)

   chkN(5,k);
//

   n = 7;

   m = 14;

   k = sumarg(&n,&m);

   <<"%V $n $m $k \n";

   chkN(k,21);

   chkN(n,8);

   chkN(m,28);

   n = 54;

   m = 49;

   <<"ref arg n $n  val m $m\n";
!z

   k = sumarg(&n,m);

   chkN(n,55);

   chkN(m,49);

   chkN(k,103);

   <<"%V $n $m $k \n";

//   chkOut();

   n = 79;

   m = 47;

   k = sumarg(n,&m);

   chkN(n,79);

   chkN(m,94);

   chkN(k,126);

   <<"%V $n $m $k \n";

   n = 20;

   m = 28;

   k = sumarg(&n,m);

   chkN(n,21);

   chkN(m,28);

   chkN(k,48);

   <<"%V $n $m $k \n";

//   chkOut();


   int Hoo( int a, int b)
   {

     <<"$_proc  $a $b\n";

     a.pinfo();
     a = a +1;

     b.pinfo();
     b = b +1;
     c = a + b;

     c.info();
     return c;

     }

   n = 2;

   m = 3;

   r= Hoo(n,m);

   <<"%V $r $n $m\n";

   chkR (r,7);

   r= Hoo(m,n);

   <<"%V $r $n $m\n";

   r= Hoo(&n,m);

   <<"%V $r $n $m\n";

   chkR (r,7);

   chkR (n,3);

   r= Hoo(n,&m);

   <<"%V $r $n $m\n";

   chkR (r,8);

   chkR (n,3);

   chkR (m,4);

   r= Hoo(&n,&m);

   <<"%V $r $n $m\n";

   chkR (r,9);

   chkR (n,4);

   chkR (m,5);

   chkOut();

///////////////// TBD //////////////////
// should work? if call as Hoo(x,y) or Hoo(&x,&y)
// difference is &x makes it a ref argument so it can be modified inside of proc
// else modification does not carry to calling scope
//
// xic version fails - fix
//
//////////// TBD ////////////
// BUG XIC version  -- won't find ref argument

//===***===//
