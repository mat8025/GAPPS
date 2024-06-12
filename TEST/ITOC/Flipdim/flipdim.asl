/* 
 *  @script flipdim.asl 
 * 
 *  @comment test flipdimn reverse along a dimn 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.55 C-Li-Cs] 
 *  @date 10/12/2021 14:40:57 
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                             



<|Use_=
flipDim(A,dim)
flips (reverses) multidimension along a dimension
|>

#include "debug.asl";



if (_dblevel >0) {
   debugON()
      <<"$Use_\n"
}


chkIn()

allowErrors(-1)

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
  t=R<-flipDim(0)
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
