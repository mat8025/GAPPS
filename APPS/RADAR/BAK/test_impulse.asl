
N = 300


float A[N] 

T = vgen(FLOAT,N,0,1) 

A[120:-1] = 1000

TA = vZipper(T,A)


<<"%(2,, ,\n)$TA\n"



stop!