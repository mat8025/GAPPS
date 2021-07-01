


#include "debug"
debugON()


filterFuncDebug(REJECT_,"SprocSM","ProcArgs","getSivs","CopySivTable","checkLoop","findSiv")
filterFuncDebug(REJECT_,"getLSiv")

chkIn(_dblevel)



proc woo (str k, str m)
{
    n = scat(k,m);
    <<"$_proc $k $n $m\n"
    q=hoo(n, m)
    return q;
}
//=======================//
proc moo (str k, str m)
{
   n =  scat(k,m);
 <<"$_proc $k $n $m\n"
    q=woo(n,k)
    return q;
}
//=======================//

proc hoo (str k, str m)
{
   n = scat(k,m);
 <<"$_proc $k $n $m\n"
   q = zoo(n,m)
   return q;
}
//=======================//
proc zoo (str k, str m)
{
    n = k +m ;
 <<"$_proc $k $n $m\n"
   return n;
}
//=======================//


str n = "hi ";
str m = "bye ";




 t= moo(n,m)

<<"%V $t\n"

// now with Str args






 exit()
 w= sumargs(2,3)

<<"%V $w\n"


 w= sumargs(3,4) + 10


<<"%V $w\n"


