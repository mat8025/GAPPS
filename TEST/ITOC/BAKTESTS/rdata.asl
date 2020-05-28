

A=ofr(_clarg[1])


D=rdata(A,FLOAT_)

<<"$D\n"

B=ofr(_clarg[1])

E=rdata(B,"float")

<<"$E\n"


 redimn(D,5,2)



C=ofw("first.mat")


wmat(C,D)


stop!