// make up a tone group



 A = 220

 C= A * (1+4/12.0)

 E = A * (1+7/12.0)


 Sf = 16000.0


int npts = 5*Sf;


T = tone(Sf,npts,20000,A,1.0,0,C,0.9,0,E,0.8,0)

//T = tone(Sf,npts,20000,A,1.0,0)

//<<"$T[0:100]\n"


 short R[]

 R = T
n =1
fb=ofw("chord.txt")
<<[fb]"%($n,\s,\,,\n)$R\n"
cf(fb)

w = ofw("chord.raw")

 wdata(w,R)
