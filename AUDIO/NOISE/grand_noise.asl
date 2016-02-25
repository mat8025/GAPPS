
// make 5 secs worth
sf = 16000
short S[]
S = grand(5*sf,0) * 10000
sz = Caz(S)
<<"%V$sz \n"
<<"%(10,, ,\n)$S[0:99] \n"
// FIX
//short N[] = grand(100,0) * 20000
//<<"%(10,, ,\n)$N \n"

A=ofw("noise.pcm")

wData(A,S)
cf(A)

//float F[] = S

float F[] 

 F =vsmooth(S,20)
<<" smoothed \n"
<<"%(10,, ,\n)$F[0:99] \n"

 S= F

A=ofw("noise_sm20.pcm")

wData(A,S)
cf(A)

