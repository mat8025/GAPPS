/* 
 *  @script mat.asl 
 * 
 *  @comment matrix ops 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.57 C-Li-La]                               
 *  @date 10/27/2021 13:03:14 
 *  @cdate 10/27/2021 13:03:14 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//----------------------//;
<|Use_= 
Demo  of matrix ops 
/////////////////////// 
|>

#include "debug" 
if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn(_dblevel)

allowErrors(-1) ; // keep going




int A[] = {2,3,4,-6,3,1};

<<" $(Cab(A)) $(Caz(A)) \n"

<<"%V$A \n"


Mat M(INT_,5,4);

//Mat T(M);

       M = 78;
       M[2][3] = -47;
!i M


      T= Mtrp(M);

      //M<-Transpose();

!i T

    X= M * T;

!i X

chkT(1)

Siv v;

!i v

testargs(v);

chkOut()