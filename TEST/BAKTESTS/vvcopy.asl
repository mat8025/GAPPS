///
///  vvcopy
///

/{/*

vvcopy(&A[0],&B[0],n,{s1,s2,condition,cond_value,offset})
copys n locations of array B to corresponding locations in array A.
s1 and s2 are step sizes default is 1.
Also the copy can be conditional (condition set to ">","<",">=","<=","!=")
for a comparision of array value and cond_value, for the copy operation
to take place, i.e. the array data can be filtered via a condition
returns number of values copied into array B.

/}*/

checkIn()

N= 10;

//A= vgen(CHAR_,N,0,1)
B= vgen(INT_,N,0,1)
A = B;
<<"A: $A\n"
<<"B: $B\n"

A = 0;
checkNum(A[3],0)
<<"A: should be 0 $A\n"
A = B
checkNum(A[3],3)
A[0:-1:] = 0;

<<"A: should be 0 $A\n"
checkNum(A[3],0)
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

checkNum(A[3],47)

checkOut()



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
