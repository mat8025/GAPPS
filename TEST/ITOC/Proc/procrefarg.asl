
///
/// procrefarg
#include "debug"

   allowErrors(-1) ; // keep going;
   
if (_dblevel > 0) {
  debugON()
}

   chkIn(_dblevel);

   showUsage("How to use ref args") ;
   DB_action = 0;

db_allow = 1
ans=ask(DB_prompt,DB_action)

allowDB("ic,spe_,svar,str_,parse,pex",db_allow);

//   if (_dblevel <= 1) {

//  }

<<"%V $DB_action \n"
   int sumarg (int& v, int& u)
   {

     <<"ref args int %V  $v $u \n";

     v.pinfo();

     u.pinfo();


     int z;

     z.pinfo();

     z = v + u;

     z.pinfo();

     v.pinfo();

     u.pinfo();

     <<"%V $z = $v + $u \n";

//   v++;

     v = v +1;

     <<" changing first arg to %V $v\n";

     v.pinfo();

     u = u * 2;

     <<" changing second arg to %V $u \n";

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
  allowDB("spe_proc,ic_")

  p = sumarg(n,m);
  
   <<"returned %V $n $m $p \n";
  ans=ask(DB_prompt,DB_action)


   chkN(p,5);

   chkN(n,3);

   chkN(m,6);

p = sumarg(n,m);

chkN(n,4);
  chkN(m,12);


    chkOut()

   exit()

