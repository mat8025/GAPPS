//%*********************************************** 
//*  @script proc_ra.asl 
//* 
//*  @comment test ref arg 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.98 C-He-Cf]                               
//*  @date Tue Dec 22 21:54:07 2020 
//*  @cdate 4/1/2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

//#include "debug";

//if (_dblevel >0) {
//   debugON()
//}


chkIn(_dblevel)

//void Refarg (int& v)


void Refarg (int v)
{
<<"IN %V  $v $n \n"
   v->info(1)
  // v++; // fail
      v = v + 1; // ok
    //v = v + 5; // ok
  <<"  %V $v  $n\n"   
   //  v *= 2; // fail
     v =  v * 2; // fail
<<"  %V $v $n\n"        
     v++;
  <<"OUT  %V $v  $n\n"   
}
//=====================

int n = 3;

<<"%V pre $n  \n"

 Refarg(n);


chkN(n,3)

<<"%V post value call $n  \n"








// reset
   n = 3;

<<"%V pre $n  \n"

  Refarg(&n);


<<"%V post reference $n  \n"



  p = &n

p->info(1)

  q = $p;

q->info(1)



<<"%V  post $n  \n"
chkN(n,9)
chkOut()

exit();



///////////////////////////////////////////////////////////
/*
TBD  - check ptr arg
void refarg (ptr v)
{

<<"IN %V  $v  \n"
   v->info(1)

   pre_v = $v;
   
   pre_v->info(1)

//   $v++;
//sdb(1,@trace)

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

*/