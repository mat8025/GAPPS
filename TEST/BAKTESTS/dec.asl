
 A = {1,2,3,4,5, 6,7,8,9,10}

A[5] = 47
//A->redimn(10)
<<"%V$A\n"
//<<"size $(Caz(A)) bounds $(Cab(A))\n"
<<"size $(Caz(A))\n"
<<"$A[1::2]\n"



float B[] = {1,2,3,4,5,6,7,8,9,10}

<<"%V$B\n"
<<"$(Caz(B))\n"

float Leg[100]

Leg[3] = 3

stop!

//int A[]= {{1,2,3,4,5}, {6,7,8,9,10}}

// A = {{1,2,3,4,5}, {6,7,8,9,10}}

 A = {1,2,3,4,5, 6,7,8,9,10}


A->redimn(10)
<<"$A\n"
<<"$(Caz(A)) $(Cab(A))\n"


stop!


 Y = vgen(INT_,10,0,5)

 <<"$Y\n"


 X= A[1::2]

 <<"$X\n"

 sum = 0
 i = 0
 while (i <= 10) {   sum += i;   i++ ; }
<<"$i $sum\n"