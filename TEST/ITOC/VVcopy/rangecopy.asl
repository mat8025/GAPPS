//%*********************************************** 
//*  @script range-copy.asl 
//* 
//*  @comment test range subscript copy
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.100 C-He-Fm]                               
//*  @date Sat Dec 26 23:33:26 2020 
//*  @cdate 2/26/2021
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%



#include "debug"

if (_dblevel >0) {
  debugON()
}


chkIn()

N= 10;

A= vgen(INT_,N,0,-1)

B= vgen(INT_,N,0,1)
C=B

chkN(B[4],4)

<<"C $C\n"
<<"B $B\n"
<<"A $A\n"

B[4:8:] = A[1:5]
// should replace eles 4-8 of B with 1-5 of A
<<"$B\n"

A->info(1)
B->info(1)


<<"B $B\n"
<<"A $A\n"

chkN(B[4],A[1])
chkN(B[8],A[5])

chkOut()