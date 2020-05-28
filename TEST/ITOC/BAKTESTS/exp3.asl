
A= Igen(10,0,2)

<<"%v $A \n"



B= A


<<"%v $B \n"
<<"%v $A \n"

n = 10
a = 2

// slice

C = A[1:*:2]

<<"%v $C \n"

D = A[9:2:-1]

<<"%v $D \n"

E = A[8:2:-1]

<<"%v $E \n"

F = A[(a+1):(n-3):1]

<<"%v $F \n"

STOP!

// reversed slice

D= A[9:0:-1]

<<" $D \n"

STOP!