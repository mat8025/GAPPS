#! /usr/local/GASP/bin/asl

// test svar indexing

S = "once upon a time in the Kingdom of Arthur ruler of the Britons"
<<" $S \n"
P = split(S)

<<" $P \n"

N=Caz(P)

<<" $N words \n"

W=split("once upon a time in the Kingdom of Arthur ruler of the Britons")

<<" $W \n"

N=Caz(W)

<<" $N words \n"

 val = W[0]
<<"0 $val \n"


 val = W[1]
<<"1 $val \n"

 vi = 3

 val = W[vi]
<<"$vi $val \n"

 lval = val[0]{0:3}

<<" %v $lval \n"

  lval = sele(val,0,3)

<<" %v $lval \n"

<<" DONE \n"
STOP!
