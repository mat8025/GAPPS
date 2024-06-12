
///
/// procptrarg
#include "debug"

   allowErrors(-1) ; // keep going;

   if (_dblevel >0) {

     debugON();


     }

   chkIn();

 showUsage("How to use ptr args") ;

  ask = 1;


 int sumarg (int vi, int ui)
   {

     <<"val args int %V  $vi $ui \n";

     vi.pinfo();

     ui.pinfo();


     int zi;

     zi.pinfo();

     zi = vi + ui;

     zi.pinfo();

     vi.pinfo();

     ui.pinfo();

     <<"%V$vi + $ui = $zi\n";

//   v++;

     vi = vi +1;

     <<" changing first arg to %V$vi\n";

     vi.pinfo();

     ui = ui * 2;

     <<" changing second arg to %V$ui \n";

     ui.pinfo();

     <<"args out %V$vi $ui $zi\n";


     return zi;

     }
//=======================//

 float sumarg (float vf, float tf)
   {

     <<"val args int %V  $vf $tf \n";

     vf.pinfo();

     tf.pinfo();


     float zf;

     zf.pinfo();

     zf = vf + tf;

     zf.pinfo();

     vf.pinfo();

     tf.pinfo();

     <<"%V$vf + $tf = $zf\n";

//   v++;

     vf = vf +1;

     <<" changing first arg to %V$vf\n";

     vf.pinfo();

     tf = tf * 2;

     <<" changing second arg to %V$tf \n";

     tf.pinfo();

     <<"args out %V$vf $tf $zf\n";


     return zf;

     }
//=======================//


   int sumarg (int* v, int* u)
   {

/// this should be doing int ptr syntax ?
///   z = $v + $u

     <<"ptr args int %V  $v $u \n";

     v.pinfo();

     u.pinfo();


     int z;

     z.pinfo();

     z = $v + $u;

     z.pinfo();

     v.pinfo();

     u.pinfo();

     <<"%V$v + $u = $z\n";

     askit(ask)

//   v++;


     $v = $v +1;

     <<" changing first arg to %V$v\n";

     v.pinfo();

     $u = $u * 2;

     <<" changing second arg to %V$u \n";

     u.pinfo();

     <<"args out %V$v $u $z\n";


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

   <<"should be calling summarg int args vers with  ptr &n args\n";

   p = sumarg(&n,&m);

   <<"returned %V $n $m $p \n";

   chkN(p,5);

   chkN(n,3);

   chkN(m,6);

 <<"should be calling summarg int args vers with  val args\n";
   p = sumarg(n,m);


   chkN(p,(n+m));
   chkN(n,3);

   chkN(m,6);

   <<"returned %V $n $m $p \n";






    chkOut()

   exit()
