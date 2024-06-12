



<|Use_=
Demo  of proc return ;
///////////////////////
|>


                                                                        
#include "debug"

if (_dblevel >0) {
   debugON()
    <<"$Use_\n"   
}

ignoreErrors()
allowErrors(-1)


chkIn()

 Str S = "abcde";

<<"%V $S\n"


 Str _S2 = "abcde";


<<"%V $_S2\n"


<<" Oh No!\n"

proc Foo()
{

<<" Oh Noes!\n"

}



chkT(1)

Foo()

chkT(1)

chkOut()

