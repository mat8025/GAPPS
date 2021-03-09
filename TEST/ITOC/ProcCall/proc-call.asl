/* 
 *  @script proc-call.asl 
 * 
 *  @comment  test proc within proc -- chain 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.29 C-Li-Cu]                                
 *  @date 03/07/2021 15:57:14 
 *  @cdate 1/1/2021 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 



#include "debug"
debugON()


filterFuncDebug(REJECT_,"SprocSM","ProcArgs","getSivs","CopySivTable","checkLoop","findSiv")
filterFuncDebug(REJECT_,"getLSiv")

chkIn(_dblevel)

proc sumargs (int v, int u)
{
<<"args in %V  $v $u \n"
int z;
   z = v + u;
    sz = Caz(_pstack)
   <<"%V $sz $_pstack \n"
 if (sz < 10) {
   woo(z,u);
 }
<<" ret $z\n"
  return z;
}
//=======================//

proc roo (int val)
{
 n = val;
 Chain_val = n;
 <<"$_proc $val $n\n
   <<"$_pstack \n""
 sumargs(n,val);
}
//=======================//


proc woo (int k, int m)
{
    n = k +m ;
    Chain_val = n;
   <<"$_proc $k $n $m\n"
   <<"$_pstack \n"
    q=hoo(n, m)
    return q;
}
//=======================//
proc moo (int k, int m)
{
int in_m= m;
   n = k +m ;
   Chain_val = n;
 <<"$_proc $k $n $m\n"
    q=woo(n,k)
 <<"$_pstack \n"
 <<"%V  $in_m   $m\n"
  return q;
}
//=======================//

proc hoo (int k, int m)
{
   n = k +m ;
   Chain_val = n;
 <<"$_proc $k $n $m %Chain_val\n"
    <<"$_pstack \n"
   q = zoo(n,m)
   return q;
}
//=======================//
proc zoo (int k, int m)
{
    n = k +m ;
    Chain_val = n;
       <<"$_pstack \n"
 <<"$_proc $k $n $m\n"
   return n;
}
//=======================//


int n = 2;
int m = 3;

int Chain_val = 0;


 t= moo(n,m)

<<"%V $t\n"

<<"%V $Chain_val\n"

chkN(Chain_val,4,GT_)

chkOut()




 exit()
 w= sumargs(2,3)

<<"%V $w\n"


 w= sumargs(3,4) + 10


<<"%V $w\n"


