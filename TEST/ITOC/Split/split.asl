/* 
 *  @script split.asl                                                   
 * 
 *  @comment test split SF                                              
 *  @release Arsenic                                                    
 *  @vers 1.2 He Helium [asl ]                                          
 *  @date 10/22/2023 21:53:50                                           
 *  @cdate Fri Apr 3 19:37:19 2020                                      
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare  -->                                   
 * 
 */ 


#define NULL ""

   chkIn();

   A= split("once upon a time");

   chkStr(A[0],"once");

   chkStr(A[1],"upon");

   chkStr(A[2],"a");

   chkStr(A[3],"time");
// use

   A= split("ONCE,UPON,A,TIME",",");

   chkStr(A[0],"ONCE");

   chkStr(A[1],"UPON");

   chkStr(A[2],"A");

   chkStr(A[3],"TIME");

   sz=Caz(A);

   <<"$sz\n";

   <<" %(1,,,\n)$A\n";

   B= split("4.0,7.3",",");

   sz=Caz(B);

   <<"$sz\n";

   <<"%(1,,,\n)$B\n";

   C= split("4.0 8.0",",");

   sz=Caz(C);

   <<"$sz\n";

   <<"%(1,,,\n)$C\n";

   if (C[0] @= "") {

     <<"no tokens!\n";

     }

   if (C[0] @= NULL_) {

     <<"no tokens!\n";

     }

   D= split("",",");

   sz=Caz(D);

   <<"$sz\n";

   <<"[0] $D[0]\n";

   if (D[0] @= "") {

     <<"no tokens!\n";

     }

   <<"%(1,,,\n)$D\n";

   if (D[0] @= NULL_) {

     <<"no D tokens!\n";

     }

   if (D[0] @= NULL) {

     <<"no D tokens!\n";

     }

   E= split('int a, int b',",");

   sz=Caz(E);

   <<"$sz\n";

   <<"[0] $E[0]\n";

   if (E[0] @= "") {

     <<"no tokens!\n";

     }

   if (E[1] @= "") {

     <<"one token!\n";

     }

   <<"%(1,,,\n)$E\n";

   args = "int A, int B";

   E= split(args,",");

   sz=Caz(E);

   <<"$sz\n";

   <<"[0] $E[0]\n";

   if (E[0] @= "") {

     <<"no tokens!\n";

     }

   if (E[1] @= "") {

     <<"one token!\n";

     }

   <<"%(1,,,\n)$E\n";

   Svar S;

   S.pinfo();

   S = "what is going on 1 2 3";

   S.pinfo();

   <<" $(typeof(S)) \n";

   <<"$S \n";

   sz=Caz(S);

   <<"%v$sz \n";

   S.Split();

   <<" $S \n";

   w0 = S[0];

   w1 = S[1];

   w2 = S[2];
   w3 = S[3];
   w4 = S[4];
   w5 = S[5];

   <<"%V $w0 \n$w1 \n$w2 $w3\n $w4\n $w5 \n";

   chkStr(w1,"what");
      chkStr(w2,"is");
      chkStr(w3,"going");      

   chkOut();

//==============\_(^-^)_/==================//
