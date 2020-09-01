
include "debug.asl";

sdb(_dblevel,@~trace)

if (_dblevel >0) {
   debugON()
}

filterFuncDebug(ALLOW_,"Setup","opera_f","Cmath","storeScalar","storeSiv","Pluseq","l_3",\
"l_1","l_2","l_4","l1_store","l1_opera","resolveResult","Variable","setLho","setRho","findSiv",\
"checkProcVars","FindVar","Get","Number","primitive","primitive_store_var","getExp");

filterFuncDebug(ALLOWALL_,"Setup")


chkIn(_dblevel)






proc refarg (ptr v)
{

<<"IN %V  $v  \n"
   v->info(1)

   pre_v = $v;
   
   pre_v->info(1)

//   $v++;
sdb(1,@trace)

<<"%V $n\n"
n->info(1)

   post_v = $v;

<<"equate to $v %V $post_v \n"

  post_v = 2 + $v;
  chkN(post_v,6)
<<"sum %V $post_v \n"
  n->info(1)
  post_v = $v + 5;

<<"sum2 %V $post_v \n"
  chkN(post_v,9)
  
   $v = $v +1;
   
   post_v = $v;
  chkN(post_v,5)
   z = $v;

<<"OUT %V $z $v $pre_v $post_v \n"


}
//=======================//
int n = 4;
int m = 84;

   vm = n;

   pvm = vm + 7;

<<"%V $vm $pvm \n"

   chkN(pvm,11);
   h = n;
   w= h++ + h++;

<<"%V $w  $h \n"

   chkN(w, (n*2 +1));
   
   pre_n = n;


//      refarg(w);

w->info(1)

<<"%V pre $n  \n"

   refarg(&n);

<<"%V  post $n  \n"

<<"%V proc modifies? $pre_n !=  $n \n"

  chkN(n,5)

//chkOut()
  pre_m = m;
  m = 4;
  refarg(&m);

<<"%V $m  \n"
  post_m = m;
 // chkN(post_m,pre_m+1)

<<"%V proc does not modifies arg? $pre_m == $m \n"

chkOut()

