#! /usr/local/GASP/bin/asl

// test svar indexing
// following lit declaration - needs ic coding


int P[] = { 3, 8, 14, 20, 1000,,,,8}

<<" $P \n"

<<" %v  $(Caz(P)) \n"


long l = 12345
int i = 77
short s = 56

 n=foo(1,2.0,"onec",P,i,l,s)

<<" %v $n \n"

<<" $(Typeof(i)) $(Typeof(l)) $(Typeof(s))\n"

<<" $(Sizeof(i)) $(Sizeof(l)) $(Sizeof(s))\n"

S = "once upon a time in the Kingdom of Arthur - Ruler of the Britons"
<<" $S \n"



W= split(S)

<<" %v $W \n"

<<"%v  ${W[1:3]} \n"

W= splitp(S,P)

<<" <${W[0]}> <${W[1]}> <${W[2]}>  <${W[3]}>\n"

<<" $W \n"
<<" DONE \n"
STOP!

 vi = 1
 val = W[vi]
<<"$vi $val \n"

 n=foo(1,[1,2,3,4,5])

<<" %v $n \n"

<<" DONE \n"
STOP!
