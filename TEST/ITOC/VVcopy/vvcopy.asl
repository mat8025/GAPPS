/* 
 *  @script vvcopy.asl                                                  
 * 
 *  @comment test vvcopy SF                                             
 *  @release Boron                                                      
 *  @vers 1.4 Be Beryllium [asl 5.95 : B Am]                            
 *  @date 04/01/2024 13:08:18                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


<|Use_ =
  vvcopy(A,B,n,{condition,cond_value},{stepA,stepB},{offsetA,offsetB})
  copies n locations of array B to corresponding locations in array A.
  s1 and s2 are step sizes default is 1.
  Also the copy can be conditional
  (condition set to GT_,LT_,GTE_,LTE_,EQ_,NEQ_,ALWAYS_)
  or (condition set to ">","<",">=","<=","!=")
  for a comparison of array value and cond_value,
  for the copy operation
  to take place, i.e. the array data can be filtered via a condition.
  Additionally the steps and offsets into the arrays can be set
  e.g.
  vvcopy(A,B,n,GTE_,0,1,2,5,6);
  where the access starts at element 6 of B and steps by two.
  the first successful compare (number GTE to 0)  goes into element 5 of vector A.		\
  goes into element 5 of vector A.;
  and the next into element 6, ...
  There is an internal check to prevent accessing or writing beyond
  the arrays, but the success of the operation requires programming
  inspection with respect to array size.
  Returns number of values copied into array A.
|>

#include "debug"

  if (_dblevel > 0) {

  debugON();

  <<"$Use_\n";

  }
   chkIn();

  db_allow = 0;



  B= vgen(INT_,100,0,1);

  chkN(B[0],0);

  chkN(B[99],99);

  <<"%V$B\n";

  C= B[10:19:1];

  N= 10;

  A= vgen(INT_,N,0,-1);

  B= vgen(INT_,N,0,1);

  C=B;

  <<"A: $A\n";

  <<"B: $B\n";

  <<"C: $C\n";

  <<"$A[1] $B[1]\n";

  r = ( B[1] == 1);

  chkT(1);

  vvcopy(B,A);

  <<"B: $B\n";

  chkN(B[1],A[1]);

  B=C;

  <<"B: $B\n";

  B[3] = 7;

  A[0] = 14;

  A[1] = 17;

  <<"B: $B\n";

  if (db_allow) {

  allowDB("spe,rdp,array,parse,svar,ic",1);

  }

allowDB("spe,array,pex",1)
//wdb=dbAction(DBSTEP_)
  <<"A: $A\n";
  <<"B: $B\n";


  vvcopy(&B[3],A,5);

  <<"B: $B\n";

  B.pinfo();


  <<"B: $B\n";

  <<"B: $B[::]\n";

  <<"B: $B[1:5:1]\n";

  <<"A: $A\n";

  <<"%V $B[3]  $A[0] \n";

  <<"%V $B[4]  $A[1] \n";
  
 <<"A: $A\n"
 <<"B: $B\n"
 

  chkN(B[3],A[0]);

  chkN(B[4],A[1]);

  //chkOut(-1)
  

//    do the same with vec ops
////////////////////////////////////////////////////////////
//wdb=dbAction(DBSTEP_)
  B = C;

  <<"C $C\n";

 chkV(B,C)
  <<"B $B\n";

  <<"A $A\n";

//!bs  -want margin codes


  B[4:8:] = A[1:5];


  

  <<"B: $B\n";
  
  <<"B: $B[::]\n";

    B.pinfo()

    chkN(B[4],A[1]);


  int ki = 2;

  B=C;

  vvcopy(&B[ki],A,5);

  <<"A: $A\n";
  <<"B: $B\n";

  chkN(B[ki],A[0]);

  B=C;

  ki = 4;

  vvcopy(&B[ki],A,5);

  <<"B: $B\n";

  chkN(B[ki],A[0]);

  int kia = 3;

  ki = 2;

  B=C;

  <<"%V $ki $kia\n";

  vvcopy(&B[ki],&A[kia],4);

  <<"B: $B\n";

  A.pinfo();

  B.pinfo();

  <<"A: $A\n";

  <<"B: $B\n";

  <<"%V $ki $kia\n";

  <<"%V $B[ki] $A[kia] \n";

  chkN(B[ki],A[kia]);

  bval = B[ki];

  aval = A[kia];

  <<"%V $bval $aval\n";

ans =ask("offset OK?",0)

  A.pinfo();

  chkN(bval,aval);

  A = 0;

  chkN(A[3],0);

  <<"A: should be 0 $A\n";

  A = B;  // both A,B shoul reset offs

  <<"B: $B\n";

  <<"A: $A\n";

  chkN(A[3],B[3]);

  A[0:-1:] = 0;

  <<"A: should be 0 $A\n";

  chkN(A[3],0);

  A.pinfo();

  A[3]=79;

  B[3]=47;

  <<"A: $A\n";

  <<"B: $B\n";

  n = N;

  nc=vvcopy(A,B,n);

  <<"$nc ALL\n";

  <<"A: $A\n";

  <<"B: $B\n";

  A.pinfo();

  BL= vgen(INT_,100,0,1);

  chkN(BL[0],0);

  chkN(BL[99],99);

  <<"%V$B\n";

  C= BL[10:19:1];

  R=vvcomp(A,B,n);

  <<"vvcomp %V$R\n";

  A.pinfo();

  chkN(A[3],47);

  BM= vgen(INT_,100,0,1);

  chkN(BM[0],0);

  chkN(BM[99],99);



  <<"%V$BM\n";
  kt = 0;
  js = 1
  for (i = 0; i < 3; i++) {


  //  C= BM[i:19:1];
    C= BM[i:19:js];

    kt++
  <<"<$i><$kt> $C \n";
  ans=ask("%V $i incr?? ",0)
    if (kt > 10)
        break;
  }
//   nc=vvcopy(A,B,20,ALWAYS_,0,1,1,0,10);

  <<"$B\n";

  nc=vvcopy(A,BM,20);

  <<"$nc \n";

  <<"$A\n";

  A.pinfo();

  C= A[1:5:1];

  <<"$C\n";
/*
   chkN(B[0],0)
   chkN(B[99],99)
   <<"%V$B\n"
*/


  BM.pinfo();

  <<"$BM\n";

  C= BM[10:19:1];

  <<"$C\n";
  
  C.pinfo()

  chkN(C[0],10);



  C= BM[20:29:1];

  BM.pinfo();
//k= B[0]
//!p k

  <<"%V$B\n";
//chkN(B[1],1)
/*
   chkN(B[99],99)
   <<"%V$B\n"
*/


  <<"$C\n";

  chkN(C[0],20);

  <<"%V$A\n";

  BM.pinfo();

  <<"%V$B\n";
// TBF BUG BM has PROC_ARG_REF set ??

  BM.pinfo();

  nc=vvcopy(A,BM,20,ALWAYS_,0,1,1,0,20);

  <<"$nc \n";

  <<"%V$BM\n";

  <<"%V$A\n";

  <<"%V$A[0] $A[1]\n";

  chkN(A[0],20);

  <<"; //////////////////////\n";

  B= 0;

  nc=vvcopy(A,B,n,GTE_,7);

  <<"$nc GT \n";

  <<"A: $A\n";

  <<"B: $B\n";

  <<"; //////////////////////\n";

  B= 0;

  <<"B: $B\n";

  nc=vvcopy(A,B,n,LT_,4);

  <<"$nc LT \n";

  <<"A: $A\n";

  <<"B: $B\n";

  <<"; //////////////////////\n";

  B= 0;

  <<"B: $B\n";

  nc=vvcopy(&A[2],&B[0],n,LT_,4);

  <<"$nc LT \n";

  <<"A: $A\n";

  <<"B: $B\n";

  <<"; //////////////////////\n";

  B= 0;

  <<"B: $B\n";

  nc=vvcopy(&A[2],&B[3],n,LT_,4);

  <<"$nc LT \n";

  <<"A: $A\n";

  <<"B: $B\n";
 //  I = Seli(A,GT_,3);

  I = Sel(A,GT_,3);

  <<"I: $I \n";

  V = Sel(A,I);

  <<"V $V\n";

  T = A[I];

  <<"T $I\n";

  chkT(1);

  chkOut(1);

//==============\_(^-^)_/==================//
