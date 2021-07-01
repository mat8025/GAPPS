


<|Use_=
Demo  of str;
///////////////////////
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


chkIn()








   A= "how"

<<"$A\n"
<<"$(typeof(A))\n"

   if (A @= "how") {
     <<" fine\n"
      ok = 1
   }
   else {
<<" scmp not working \n"
   }
<<"%V$ok\n"
<<"<|$A|>\n"

ok->info(1)
A->info(1)


chkStr(A,"how")


chkOut()