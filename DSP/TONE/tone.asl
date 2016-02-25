// make up a tone group



 A = 220

 C= A * (1+4/12.0)

 E = A * (1+7/12.0)


 Sf = 25568.0


 npts = 1500000


T = tone(Sf,npts,20000,A,1.0,0,C,0.9,0,E,0.8,0)

//T = tone(Sf,npts,20000,A,1.0,0)

//<<"$T[0:100]\n"


 short R[]

 R = T

<<"$R[0:100]\n"

w = ofw("chord.raw")

 wdata(w,R)
