/* 
 *  @script array_cmp.asl 
 * 
 *  @comment test array Cmp ops 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.60 C-Li-Nd] 
 *  @date 11/19/2021 12:05:44          
 *  @cdate Fri May 1 07:35:20 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                       

<|Use_=
   Demo  of vector store and Cmp ops
   e.g.
   I=Cmp(A,B,"==")
   creates array I  containinf the indices where A and B vecs are equal
   if none I[0] = -1;
///////////////////////
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn(_dblevel);

   A= vgen(INT_,10,0,1);

   B = A;
<<"$A \n"   
<<"$B \n"

 // B.pinfo();
  


//   I=Cmp(A,B,"==");

  I=Cmp(A,B,EQU_);

   <<"Cmp == of A & B gives: $I\n";

   I.pinfo();


   chkN(I[1],1);



   C = B * 2;

   C.pinfo()

  chkN(C[1],2);


<<"%V$C\n"


   I=Cmp(A,C,EQU_,1);

   <<"$I\n";

   chkN(I[1],0);


   D= reverse(B);

   <<"$D\n";
   D.pinfo()

//   I=Cmp(B,D,"==");

      I=Cmp(B,D,EQV_);

   chkN(I[0],-1);

   I=Cmp(B,D,NEQ_,1);

   <<"$I\n";

   chkN(I[1],1);

   chkN(I[9],1);

   <<"$A\n";

   <<"$B\n";

   <<"$C\n";

   chkOut();

//===***===//
