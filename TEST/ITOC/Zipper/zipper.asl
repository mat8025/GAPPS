//%*********************************************** 
//*  @script zipper.asl 
//* 
//*  @comment test SF zipper interleave vecs 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.3.2 C-Li-He]                                
//*  @date Wed Dec 30 11:26:01 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

/*
Zipper()

/////
V=zipper(Vec1,Vec2)
zipper, interleaves one vector with another  V3=zipper(V1,V2)
*/

chkIn()

I= vgen(INT_,10,0,2)
J= vgen(INT_,10,1,2)
chkN(I[0],0)

chkN(J[0],1)

K= zipper(I,J)


<<"$I\n"
<<"$J\n"
<<"$K\n"

chkN(K[0],0)
chkN(K[1],1)

chkOut()