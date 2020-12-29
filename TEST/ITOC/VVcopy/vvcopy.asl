//%*********************************************** 
//*  @script vvcopy.asl 
//* 
//*  @comment test vvcopy SF 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.100 C-He-Fm]                               
//*  @date Sat Dec 26 23:33:26 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///  vvcopy
///

/*

vvcopy(&A[0],&B[0],n,{s1,s2,condition,cond_value,offset})
copys n locations of array B to corresponding locations in array A.
s1 and s2 are step sizes default is 1.
Also the copy can be conditional (condition set to ">","<",">=","<=","!=")
for a comparision of array value and cond_value, for the copy operation
to take place, i.e. the array data can be filtered via a condition
returns number of values copied into array B.

*/

chkIn()

N= 10;

//A= vgen(CHAR_,N,0,1)
B= vgen(INT_,N,0,1)
A = B;
<<"A: $A\n"
<<"B: $B\n"

A = 0;
chkN(A[3],0)
<<"A: should be 0 $A\n"
A = B
chkN(A[3],3)
A[0:-1:] = 0;

<<"A: should be 0 $A\n"
chkN(A[3],0)
A[3]=79
B[3]=47
<<"A: $A\n"
<<"B: $B\n"
n = N;
nc=vvcopy(A,B,n);
<<"$nc ALL\n"
<<"A: $A\n"
<<"B: $B\n"

R=vvcomp(A,B,n);
<<"vvcomp %V$R\n"

chkN(A[3],47)

B= vgen(INT_,100,0,1)


nc=vvcopy(A,B,20,ALWAYS_,0,1,1,0,10);

<<"$nc \n"

<<"$A\n"
chkN(A[0],10)
C= B[10:19:1]


<<"$C\n"
chkN(C[0],10)

C= B[20:29:1]


<<"$C\n"
chkN(C[0],20)

nc=vvcopy(A,B,20,ALWAYS_,0,1,1,0,20);

<<"$nc \n"

<<"$A\n"
chkN(A[0],20)





chkOut()



<<"//////////////////////\n"
B= 0;
nc=vvcopy(A,B,n,GTE_,7);
<<"$nc GT \n"
<<"A: $A\n"
<<"B: $B\n"

<<"//////////////////////\n"
B= 0;
<<"B: $B\n"
nc=vvcopy(A,B,n,LT_,4);
<<"$nc LT \n"
<<"A: $A\n"
<<"B: $B\n"

<<"//////////////////////\n"
B= 0;
<<"B: $B\n"
nc=vvcopy(&A[2],&B[0],n,LT_,4);
<<"$nc LT \n"
<<"A: $A\n"
<<"B: $B\n"


<<"//////////////////////\n"
B= 0;
<<"B: $B\n"
nc=vvcopy(&A[2],&B[3],n,LT_,4);
<<"$nc LT \n"
<<"A: $A\n"
<<"B: $B\n"


I = Seli(A,GT_,3);

<<"I: $I \n"

V = Sel(A,I);

<<"V $V\n";

T = A[I]

<<"T $I\n";
