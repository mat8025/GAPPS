//%*********************************************** 
//*  @script diagonal.asl 
//* 
//*  @comment test mdiag, diagonal  - vector +> square matrix 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Sat Dec 26 09:02:12 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


//take a vector and make it as leading diagonal of a square matrix other elements are zero

#include "debug.asl";



if (_dblevel >0) {
   debugON()
}


chkIn()


//V = {1,2,3,4,5,6,7}


V= vgen(INT_,7,1,1)
<<"$V\n"

V->info(1)




P= Diagonal(V)
!i P
<<"$P\n"

P->info(1)

Q = mrevRows(P)

<<"Q revrows\n"
<<" $Q\n"


Q = mrevcols (P)

<<"Q revcols \n"
<<" $Q\n"

R= mdiag(V)

R->info(1)

<<"$R\n"

chkN(R[0][0],1)

chkN(R[0][1],0)

chkN(R[1][1],2)

chkN(R[6][6],7)


chkOut()