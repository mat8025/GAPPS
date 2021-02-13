//%*********************************************** 
//*  @script arraystore.asl 
//* 
//*  @comment  test array store 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Fri May  1 07:35:20 2020 
//*  @cdate Fri May  1 07:35:20 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)

A= vgen(FLOAT_,10,0,1)


B = A

I=Cmp(A,B,"==")

<<"$I\n"

chkN(I[1],1)

C = B * 2;

I=Cmp(A,C,"==",1)

<<"$I\n"

chkN(I[1],0)

D= reverse(B)
<<"$D\n"
I=Cmp(B,D,"==")

chkN(I[0],-1)

I=Cmp(B,D,"!=",1)

<<"$I\n"

chkN(I[1],1)
chkN(I[9],1)

<<"$A\n"
<<"$B\n"
<<"$C\n"

chkOut();

