#! /usr/local/GASP/bin/asl

int ok = 0
int bad = 0
int ntest = 0

uint N
uint M

  N = $2

  M = $3



 C= (M && N)

<<" $M && $N $C \n"


 C= (M & N)

<<" $M & $N $C \n"


 C= (M < N)

<<" $M < $N $C \n"

 C= (M <= N)

<<" $M <= $N $C \n"


 C= (M > N)

<<" $M > $N $C \n"

 C= (M >= N)

<<" $M >= $N $C \n"

 C= (M == N)

<<" $M == $N $C \n"

 C= (M != N)

<<" $M != $N $C \n"




STOP!
