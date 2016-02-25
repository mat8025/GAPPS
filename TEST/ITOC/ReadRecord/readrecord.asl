setdebug(1)

A=ofr("rec.dat")

R=ReadRecord(A,@type,FLOAT)

<<"$R\n"


<<"%(3,, ,\n)$R\n"
cf(A)


A=ofr("rec.dat")
int vec[] = {0,2}

R=ReadRecord(A,@type,FLOAT,@selcol,vec)

<<"$R\n"



cf(A)
<<"%(2,, ,\n)$R\n"


R[::][1] = R[::][1]/127.0

<<"%(2,, ,\n)$R\n"

B=ofw("new.dat")

wdata(B,R)

stop!
