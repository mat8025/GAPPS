chkIn()

setdebug(0)

k= 4
n = 6

int J[10]

 J[4] = k * 2

<<"%I$J \n"

 chkN(J[4],8)

short S[10]

 S[4] = k 

<<"%d$S \n"

 S[4] = k * 2

 chkN(S[4],8)

<<"%d$S \n"

char C[10]

 C[4] = k 

<<"%d$C \n"

 C[4] = k * 2

<<"%d$C \n"

 chkN(C[4],8)

float F[10]

 F[4] = k 

<<"%6.2f$F \n"

 F[4] = k * 2

<<"%6.2f$F \n"

 chkR(F[4],8,6)

double D[10]

 D[4] = k 

<<"%6.2f$D \n"

 D[4] = k * 2

<<"%6.2f$D \n"

 chkR(D[4],8,6)


//int J[10]


 J[0] = 77

<<"$J \n"



 J[k] = 27

<<"%I$J \n"



 J[n] = k

<<"%I$J \n"

 J[n] = k * 2

<<"%I$J \n"

 chkN(J[n],8)

 chkOut()

STOP!


// works for int not other types?
//int K[10][3]
double K[10][3]


//char K[10][3]
//short K[10][3]
//float K[10][3]

<<" $(Cab(K)) \n"

 K[0][0] = 77

<<"%r%I $K \n"

k= 4
j = 1
 K[k][0] = 27

<<"%I $K \n"

n = 6

 K[n][0] = k

<<"%r%I $K \n"

 K[n][0] = k * 2

<<"%r$K \n"

 K[n+1][j] = k * 4

<<"%r$K \n"


<<" ${K[n+1][j]} \n"



STOP!