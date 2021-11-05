/* 
 *  @script mat_sum.asl 
 * 
 *  @comment test matrix sum function 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.58 C-Li-Ce]                               
 *  @date 11/03/2021 12:03:14 
 *  @cdate 11/03/2021 12:03:14 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

;//----------------------//;

<|Use_= 
Demo  of test matrix sum function 
/////////////////////// 
|>


#include "debug" 
if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn(_dblevel)

#define CPP 1
#include "xxx"

   chkIn(_dblevel);

   int A[] = {16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4 ,15, 14, 1};

  A.Redimn(4,4);

  <<"$A\n";

  <<"A = $A\n";

  VSA = Sum(A);

  

  <<"$VSA \n";
///

  T= mtrp(A);

  T.pinfo();

  <<"T \n";

  <<"$T\n";

  X= Sum(T);

  <<"tsum of T \n";

  X.pinfo();

  <<"$X \n";

  V1 = Sum(A);

  <<"V1 $(Cab(V1))\n";

  <<"$V1\n";

  <<"$A\n";

  B=mtrp(A);

  <<"\n$A\n";

  <<"\n$B\n";

  V1.pinfo();

  V = Sum( mtrp(A) );

  

  V.pinfo();

  <<"V1 $V1\n";

  <<"V $V\n";

  V.pinfo();

  val = V[0];

  <<"V $V\n";

  val1 = V1[0];

  <<"$V1[0] $V1[1]\n";

  <<"$V[0] $V[1]\n";

  <<"$val $val1\n";

  val = V[1];

  V.pinfo();

  <<"V $V\n";

  val1 = V1[1];

  <<"$val $val1\n";

  <<"V1 $V1\n";

  chkN(V[0],34);

  chkN(V1[0],34);
//assert((V1[0] == 34),"(V1[0] == 34)");
//assert((V[0] == 34),"Sum(mtrp(A)) bug");

  chkOut();
