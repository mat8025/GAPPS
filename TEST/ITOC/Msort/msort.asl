//%*********************************************** 
//*  @script msort.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sun Dec 30 21:36:04 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%


#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn();

   M = vgen(INT_,20,0,1);

   <<"$M\n\n";

   chkN(M[3],3);

   M.redimn(5,4);

   <<"$M\n";

   sz=Caz(M);

   chkN(sz,20);

   <<"%V$sz \n";

   bnds=Cab(M);

   <<"%V$bnds \n\n";

   chkN(bnds[0],5);

   chkN(bnds[1],4);

   chkN(M[0][0],0);

   T= mrevrows(M);

   <<"$T\n";

   chkN(T[0][0],16);

   S= msortcol(T,2);

   <<"$S\n";

   chkN(S[0][0],0);

   chkN(S[4][0],16);

   R= mrevcols(M);

   <<"$R\n";

   chkN(R[0][0],3);

   chkN(R[0][3],0);

   R= mxrows(M,1,2);

   chkN(R[1][0],8);

   chkN(R[2][0],4);

   <<"$R\n";

   S= msortcol(S,2);

   <<"$S\n";

   chkN(S[1][0],4);

   chkN(S[2][0],8);

   chkOut();
