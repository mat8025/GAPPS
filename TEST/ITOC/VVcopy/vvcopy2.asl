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

setDebug(1,@trace,@filter,0)


N= 10;

B= vgen(INT_,N,0,1)
A = B;
A = 0;


n = N;
nc=vvcopy(A,B,n);
<<"$nc ALL\n"
<<"A: $A\n"
<<"B: $B\n"


int IV[2+];


nc=vvcopy(IV,&A[3],7);

<<"%V $nc\n"
<<"IV: $IV\n"

testargs(1,IV,&A[3],7);



int defs[10][20];

df = vgen(INT_,20,1,1)
int row = 5;
<<"%V$df\n"

nc=vvcopy(&defs[row][3],&df,20);


testargs(1,&defs[row][0],&df,20);

<<"/////////////\n"
<<"%(20, , ,\n)$defs[::][::]\n"



exit()
row = 3
nc=vvcopy(&defs[row],&df,20);

<<"/////////////\n"
<<"%(20, , ,\n)$defs\n"