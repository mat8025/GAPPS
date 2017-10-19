///
///  vvcopy
///

/{/*

vvcopy(&A[0],&B[0],n,{s1,s2,condition,cond_value,offset})
copys n locations of array A to corresponding locations in array B.
s1 and s2 are step sizes default is 1.
Also the copy can be conditional (condition set to ">","<",">=","<=","!=")
for a comparision of array value and cond_value, for the copy operation
to take place, i.e. the array data can be filtered via a condition
returns number of values copied into array B.

/}*/



N= 10;

A= vgen(CHAR_,N,0,1)
B =A;
B= 0;


n = N;
nc=vvcopy(A,B,n);
<<"$nc ALL\n"
<<"A: $A\n"
<<"B: $B\n"

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
