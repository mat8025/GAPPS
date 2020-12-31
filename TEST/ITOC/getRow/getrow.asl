// test getRow

nr = 15
nc = 6

//R = vgen(FLOAT_,(5*6),0,1)
R = vgen(INT_,(nr*nc),0,1)

Redimn(R,nr,nc)

<<"$R\n"

V=getRow(R,2)

<<"$V\n"


V=getRow(R,nr-1)

<<"$V\n"

V=getRow(R,nr-1,1,nc-2)

<<"$V\n"

V=getRow(R,nr-1,1,nc-2,2)

<<"step $V\n"

T= R[nr-1][1:(nc-2):]

<<"$T\n"

T= R[nr-1][1:(nc-2):2]

<<"$T\n"



T= R[2][::]

<<"$T\n"

T= R[2][1:4:]

<<"$T\n"

//T= R[-1:-1:][1:4:]
//
//<<"$T\n"