//%*********************************************** 
//*  @script flipdim.asl 
//* 
//*  @comment test flipdimn reverse along a dimn 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Sat Dec 26 11:06:13 2020 
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

/*
flipDim(A,dim)
flips (reverses) multidimension along a dimension
*/

#include "debug.asl";



if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)



// 2D

R = vgen(INT_,12,0,1)
<<"$R\n"

 Redimn(R,3,4)

T= R

<<"R dimns $(cab(R)) = \n"
<<"$R"
<<"flipDim(R,0)\n"
T= flipDim(R,0)

<<"$T"
chkN(T[0][0],R[2][0])
chkN(T[0][1],R[2][1])
<<"flipDim(R,1)\n"
T= flipDim(R,1)

<<"$T\n"
chkN(T[0][3],R[0][0])
chkN(T[0][2],R[0][1])



 S = sum(R)
<<" Sum(R) \n"
<<"$S\n"

<<"$R"
  t=R->flipDim(0)
<<"$R"
<<"%V$t\n"


// 3D

R = vgen(INT_,12,0,1)
<<"$R\n"

 Redimn(R,2,3,2)

<<"%df$R\n"

 flipDim(R,0)

<<"$R\n"


 flipDim(R,1)

<<"$R\n"


 flipDim(R,2)

<<"$R\n"




// 4D
<<" 4D \n"
R = vgen(INT_,24,0,1)
<<"$R\n"


 Redimn(R,2,2,3,2)

<<"$R\n"
T= R

 flipDim(R,0)

<<"$R\n"

R= T

<<"flipping along 1 \n"

 flipDim(R,1)

<<"$R\n"

chkOut()