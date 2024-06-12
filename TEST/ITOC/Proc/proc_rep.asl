///
///  proc_rep
/// 

//N = atoi(_clarg[1])


//setDebug(1,@keep,@trace)
//filterFuncDebug(ALLOWALL_);
//filterFileDebug(ALLOWALL_,"declare_type","array_subset","storetype","ds_store","ds_vector");

#include "debug"


chkIn();

N = 200;
int K = 1;

<<" START $K $N \n"

  if ( K < N) {
<<" $K < $N \n"
  }

 a = 2
 y = a

<<" $y = $a \n"

proc voo()
{
// increments global k
// does calc and returns that value
static int voon = 0;
int a;
   K++;
   a= K * 2;
   b = noo();
   voon++;
<<"  $_proc %V $K $a $b $voon\n"

   return a;
}
//===========================

proc noo()
{
static int noon = 0;
int a;
   K++;
   a= K * 4
   b = foo();
   noon++;
<<" in $_proc %V $K $a $b $noon\n" 
    return a; 
}
//===================

proc foo()
{
static int foon = 0;
int a;
   K++;
   a= K * 4;
   b = woo();
   foon++;
<<" in $_proc %V $K $a $b $foon\n" 
    return a; 
}
//===================

proc woo()
{
static int woon = 0;
int a;
   K++;
   a= K * 4;

   woon++;
<<" in $_proc %V $K $a $woon\n" 
    return a; 
}
//===================



int ok = 0
int bad = 0
int ntest = 0

 K = 0;

<<"%V $K $N\n"
init_mem = memused();
last_mem = memused();

 while ( K < N) {

    totmem = memused();
    memleak = totmem - last_mem
<<" before poo call %V $K $totmem $memleak \n"
    last_mem = totmem
     voo()

//<<" ln 1 after voo call \n"
//<<" ln 2  after voo call \n"

// <<" voo a is $a k is now $k\n"
  

 }

 if (K >= N)
     ok++
 else 
     bad++

 ntest++

 if ( K == N) {
<<"OK $K == $N\n"
 }

 chkN(K,N)
 chkN(K,N,GTE_)
 
<<" DONE %V $K $N  $init_mem $totmem\n"

 pcc= (100.0 * ok)/ntest
<<"%-24s :: :success $ok failures $bad  %6.1f $pcc\% \n"

chkOut();

exit()


////  TODO/FIX /////////////
// does not move to statement after proc call
// immediate statement after proc return is not executed
// .axe fails
