
checkIn(_dblevel)

proc refarg (int v)
{

<<"IN %V  $v  \n"
   v->info(1)

   pre_v = v;
   
  pre_v->info(1)

   v++;
   
   post_v =v;

   z =v;
// nv++;
//  v=nv;

<<"OUT %V $z $v $pre_v $post_v \n"


}
//=======================//
int n = 4;
int m = 84;

   h = n;
   w= h++ + h++;

<<"%V $w  $h \n"

   checkNum(w, (n*2 +1));
   
   pre_n = n;


//      refarg(w);

w->info(1)

<<"%V pre $n  \n"

   refarg(&n);

<<"%V  post $n  \n"

<<"%V proc modifies? $pre_n !=  $n \n"

  chkN(n,5)

//checkOut()
  pre_m = m;

  refarg(m);

<<"%V $m  \n"
  post_m = m;
  chkN(post_m,pre_m)

<<"%V proc does not modifies arg? $pre_m == $m \n"

checkOut()

