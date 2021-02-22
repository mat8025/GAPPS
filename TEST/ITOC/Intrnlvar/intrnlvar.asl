///
///
///

#include "debug"
debugON()

chkIn(_dblevel)


filterFuncDebug(REJECT_,"SprocSM","ProcArgs","getLsiv")



int poo_call = 0;
proc poo(int a,int b)

{

 c = a * b
 poo_call++;
 <<" in $_proc $_pargc args  : $a * $b = $c\n"

<<"%V $poo_call $foo_call \n"
 
 <<"%V $_pstack \n"
!a
 sz = Caz(_pstack)

 pc = poo_call;
 if (sz < 8) {
   foo(a,c) ;   // exit when p_stack reached limit
   <<"return after foo_call @ %V $pc $poo_call\n"
!a   
  }
  <<"$pc after limit of proc calls\n"
}
//=======================
int foo_call = 0;
proc foo(int a,int b)

{
 <<"IN $_proc $_pargc args  $foo_call\n"
 foo_call++;
c = a * b
 <<" foo $a * $b = $c\n"
<<"%V $poo_call $foo_call \n"
<<"%V $_pstack \n"
!a
 fc = foo_call;
 poo(a,c)
  <<"return after poo calls %V $fc $foo_call\n"
  <<" should pop thru the call stack!\n"
}


<<"%V $_clarg \n"
<<"%V $_lstate \n"

poo(2,3)

<<"%V $_pstack \n"
<<"%V $_lstate \n"
<<"Hey what is going on?\n"
<<"%V $_lstate \n"
