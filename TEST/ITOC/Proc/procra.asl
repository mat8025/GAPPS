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

#include "debug";

if (_dblevel >0) {
  debugON()
}


chkIn(_dblevel)

//void Refarg (int& v)
showUsage("Demo  of proc ref arg")
 fileDB(ALLOW_,"spe_proc,spe_args")
 
void Roo (int& v)
{
<<"IN %V $_proc  $v $n \n"
   v.pinfo()

<<" should be a ref int arg   -- v\n"      

  // v++; // fail
      v = v + 1; // ok

  <<"  %V $v  $n\n"   
   //  v *= 2; // fail
     v =  v * 2; // fail
<<"  %V $v $n\n"        
//     v++;  // TBF --- ref arg incr
   v = v +1;

<<"OUT  %V $v  $n\n"   

}
//=====================

void Roo (int* v)
{
<<"%V $_proc  $v $n \n"
      v.pinfo()
<<" should be a ptr arg   -- &v does v point thru call var?\n"      
  // v++; // fail
      $v = $v + 1; // ok
    //v = v + 5; // ok
  <<"  %V $v  $n\n"   
   //  v *= 2; // fail
     $v =  $v * 3; // fail
<<"  %V $v $n\n"        
    // v++;
   $v = $v +1;     
  <<"OUT  %V $v  \n"   
}
//=====================

 db_action =0


int n = 3;

<<"%V pre $n  \n"

 Roo(n);

ans=ask(DB_prompt,db_action)

 chkN(n,9)

<<"%V post value call $n  \n"


// reset
   n = 3;

<<"%V pre $n  \n"

  Roo(&n);

<<"%V post reference $n  \n"
ans=ask(DB_prompt,db_action)

  n.pinfo()

chkN(n,13)

p = &n

  p.info()

  q = $p;

  q.pinfo()

<<"%V  post $n  \n"

//n->info(1)

chkN(q,n)

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