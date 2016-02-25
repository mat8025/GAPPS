

T = vgen(FLOAT, 900, 0, 1)

A = vgen(FLOAT, 900, 0, 0)




A[200:320] = 1000


for (i = 0; i < 900; i++) {

<<"$T[i] $A[i]\n"



}


stop!