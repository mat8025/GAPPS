/* 
   *  @script mat_mul.asl
   *
   *  @comment test matrix multiply
   *  @release CARBON
   *  @vers 1.1 H Hydrogen [asl 6.3.58 C-Li-Ce]
   *  @date 11/03/2021 08:16:29
   *  @cdate 11/03/2021 08:16:29
   *  @author Mark Terry
   *  @Copyright © RootMeanSquare  2010,2021 →
   *
   *  \\-----------------<v_&_v>--------------------------//
 */ 
   ;//----------------------//;
   
<|Use_= 
   Demo  of test matrix multiply
/////////////////////// 
|>
   
#include "debug" 
   if (_dblevel >0) {
     debugON();
     <<"$Use_ \n";
     }
   
   chkIn(_dblevel);
   
   
//int A[][] = { 3,1,2, 2,1,3 }
  
  
  int A[] = { 3,1,2, 2,1,3 }
  
  A->redimn(2,3);
  
  <<"%(3,, ,\n)$A\n\n";
  
  
  int B[] ={ 1,2, 3, 1, 2, 3}
  
  B->redimn(3,2);
  
  <<"%(2,, ,\n)$B\n\n";
  
  
  C = A * B;
  
  
  <<"%(2,, ,\n)$C\n";
  
  
  ok=chkN(C[0][0],10);
  
  <<"%V$ok\n";
  
  ok=chkN(C[1][1],14);
  
  <<"%V$ok\n";
  
  D = B * A;
  
  
  <<"%(3,, ,\n)$D\n\n";
  
  <<" $(Cab(D)) $(Caz(D))\n";
  
  <<"%V$D[0][1] \n";
  
  
  ok=chkN(D[0][1],3);
  
  <<"%V$ok\n";
  
  <<"%V$D[0][0] \n";
  
  ok=chkN(D[0][0],7);
  
  <<"%V$ok\n";
  
  <<"%V$D[1][1] \n";
  
  i = D[1][1];
  
  <<"$i $D[1][1]\n";
  
  ok=chkN(D[1][1],4);
  
  <<"%V$ok\n";
  
  <<"%V$D[2][2] \n";
  
  i = D[2][2];
  
  <<"$i $D[2][2]\n";
  
  ok=chkN(D[2][2],13);
  
  <<"%V$ok\n";
  
  
  chkOut();
