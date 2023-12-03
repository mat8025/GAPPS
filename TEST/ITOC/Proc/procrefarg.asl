
///
/// procrefarg
#include "debug"

   allowErrors(-1) ; // keep going;

   if (_dblevel >0) {

     debugON();


     }

   chkIn(_dblevel);

   showUsage("How to use ref args") ;



   int sumarg (int& v, int& u)
   {



     <<"ptr args int %V  $v $u \n";

     v.pinfo();

     u.pinfo();


     int z;

     z.pinfo();

     z = v + u;

     z.pinfo();

     v.pinfo();

     u.pinfo();

     <<"%V$v + $u = $z\n";

//   v++;

     v = v +1;

     <<" changing first arg to %V$v\n";

     v.pinfo();

     u = u * 2;

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

   <<"should be calling summarg int args vers with  ref args\n";

 /// TBF  p = sumarg(&n,&m); // should give error call ptr for proc ref
  fileDB(ALLOW_,"spe_proc")
    p = sumarg(n,m);
   <<"returned %V $n $m $p \n";

   chkN(p,5);

   chkN(n,3);

   chkN(m,6);


    chkOut()

   exit()

