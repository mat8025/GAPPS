
opendll("math")

sf = 16000

f = 3000

pi = 4.0 atan(1.0)
//  2pift

dt = 1.0/sf

<<"%V$dt \n"

T = vgen(FLOAT,5*sf,0,dt)

<<"%(10,, ,\n)6.5f$T[0:99] \n"

D = T * 2 * pi * f 


<<"%(10,, ,\n)$D[0:99] \n"


S = sin(D)


<<"%(10,, ,\n)$S[0:99] \n"

short V[]


  V = S * 20000

<<"%(10,, ,\n)$V[0:99] \n"


A=ofw("tone_${f}.pcm")

wData(A,V)
cf(A)

float F[]

 F =vsmooth(V,5)
<<" smoothed \n"
<<"%(10,, ,\n)$F[0:99] \n"

 V= F

A=ofw("tone_${f}sm5.pcm")

wData(A,V)
cf(A)

