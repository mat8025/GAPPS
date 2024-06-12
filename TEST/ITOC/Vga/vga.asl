///
///
///

/*
 generate a vector from arg list
DV=vga(0,1,2,3.3,4,b,V)
generates a double vector using a list of args numbers or variables.
A vector of numeric values  is a valid argument.
*/

#include "debug"

if (_dblevel >0) {
   debugON()
}
  
chkIn()


  b = 72

  IV= vgen(INT_,10,16,1)

  A = vga(0,1,2,3,4,b,IV)

  A->info(1)

<<"$A\n"



  chkN(A[0],0)
    chkN(A[3],3)
        chkN(A[5],72)
        chkN(A[6],16)	

AL=testargs(1,2,3)

<<"%(1,,,\n)$AL\n"


AL=testargs(1,2,3,{1,2,3,4})

<<"%(1,,,\n)$AL\n"


 sum = Sum({1,2,3,4,5,6});

<<"%V $sum\n"

sum->info(1)

chkN(sum,21)

chkOut()
