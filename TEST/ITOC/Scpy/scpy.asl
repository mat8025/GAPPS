/* 
 *  @script scpy.asl 
 * 
 *  @comment test scpy SF 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.64 C-Li-Gd] 
 *  @date 12/02/2021 11:22:23          
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
; //


<|Use_=
   scpy(&M[0],&T[0],{n})
   returns len of string copied, (from second to first parameter)
   used for char arrays
   but can also copy the string contained by an sivar
   the maximum number of characters to be copied can also be set.
   e.g.
   scpy(&M[0],&w1) or  scpy(&w1,&M[0])
   scpy(&M[1],&T[2],4)
|>

/////
#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   filterFileDebug(REJECT_,"exp","tok","~ds_storestr.cpp");

   chkIn(_dblevel);

   int ki = 3;

   char lc;

   char M[32];

   char A[32];

   char T[32];

   char R[32];

   char nsv[];

   M.pinfo();

   sz=Caz(M);

   <<"%v$sz\n";

   <<"%I $M\n";

   fname = "scpy.asl";

   A=ofr(fname);

   if (A == -1) {

     <<"can't find $fname \n";

     exit();

     }

   int IV[] = vgen(INT_,10,22,1);

   <<"IV: $IV \n";

   for (i= 0; i < 3; i++) {

     <<"$i $IV[i]\n";

     chkN(IV[i],(22+i));

     }

   for (i= 0; i < 4; i++) {

     NL = readline(A,-1,1);

     nc = Caz(NL);

     sl = Slen(NL);

     <<"%V $nc $sl  $NL\n";

     scpy(nsv,NL);

     kc = nsv[0];

     lc = nsv[1];

     <<"%c $kc $lc $nsv[1]\n";

     //<<[2]"nsv[0],[1]  $nsv[0]  $nsv[1]\n";

     if (nsv[1] == '*') {

       <<"found a star $nsv[1]\n";

       }

     }

   cf(A);

   scpy(M,"hola que tal");

   <<"%I $M\n";

   <<"%s <|$M|>\n";

   A= -67;

   chkStr(M,"hola que tal");

   _S ="io sto bene";

   <<"S= $_S\n";
//!i _S

   chkStr(_S,"io sto bene");
//scpy(&S,"hola que tal");// crash

   scpy(_S,"hola que tal");//

   <<"S= $_S\n";

   _S.pinfo();

   chkStr(_S,"hola que tal");

   <<"%I $_S\n";

   <<"%d $M\n";

   scpy(T,M,10);

   <<"%d $T\n";

   <<"%s $T\n";

   chkN(T[1],M[1]);

   <<"$A\n";

   scpy(&A[5],M,10);

   M.pinfo();

   <<"M %d $M\n";

   <<"A %d $A\n";

   chkN(A[5],M[0]);

   <<"A %s $A\n" ; // bug?;

   scpy(&A[ki],M,10);

   <<"$A\n";

   chkN(A[ki],M[0]);

   scpy(R,M,10);

   <<"R %s $R\n";

   scpy(&R[2],&M[3],10);

   R.pinfo();

   <<"R %s $R\n";

   chkR(R[2],M[3]);

   <<"R %d $R[0:9:1]\n";

   r2 = R[0:9:1];

   <<"%V$r2\n";

   r2.pinfo();

   scpy(R,&M[ki],10);

   <<"R %d $R[::]\n";

   <<"R %s $R\n";

   chkR(R[0],M[ki]);

   ki++;

   scpy(&R,&M[ki],10);

   <<"R %d $R[::]\n";

   <<"R %s $R\n";

   chkR(R[0],M[ki]);

   char num[5];

   scpy(num,&M[2],3);

   chkN(num[0],M[2]);

   <<"%d $num \n";

   M[20] = 88;

   M[20] = 'X';

   M[21] = 'Y';

   M[22] = 'Z';

   <<" %d $M\n";

   scpy(&num[1],&M[20],3);

   chkR(num[1],M[20]);

   <<"%d $num \n";

   <<"%d $num[1]  $M[20] \n";

   chkOut();

//===***===//
