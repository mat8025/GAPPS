#! /usr/local/GASP/bin/asl



// test matrix join operator @<

// 
//
//
// 3 x 4

n = 12

A= Igen(n,1,1)

<<" $A \n"


//B  = Igen(6,(n+1),1)
B  = Igen(n,13,1)

<<" $B \n"



C = A @+ B

<<" $C \n"



Redimn(A,3,4)
Redimn(B,3,4)

<<"\n $A \n"

<<"\n $B\n"


C = A @+ B

<<"\n $C \n"

D = B @^ A

<<"\n $D \n"


E = A @< B

<<"\n%v\n $E \n"

STOP("\nDONE \n")