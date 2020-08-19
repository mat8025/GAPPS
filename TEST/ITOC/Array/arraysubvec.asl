setdebug(1)

chkIn()

// test array indexing

N = 20

 YV = Igen(N,21,1)

<<" %V$YV \n"

 vi = 5

<<"%V$vi\n"

int P[10]

  P[1] = 1
  P[2] = 3
  P[3] = 8
  P[4] = 16

<<"%V$P\n"

 
 S = YV[P]

<<"%V$S\n"

 chkN(S[1],YV[1])

 chkN(S[2],YV[3])

 chkN(S[3],YV[8])

// even better

 C = igen(2,1,1)
<<"$C\n"

 W = YV[P[C]]

<<"$W\n"

 chkOut()


STOP!
