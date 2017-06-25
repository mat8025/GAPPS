setdebug(1)

A=ofr("rec.dat")

R=ReadRecord(A,@type,FLOAT_)

<<"$R\n"


<<"%(3,, ,\n)$R\n"
cf(A)


A=ofr("rec.dat")
int vec[] = {0,2}

T=ReadRecord(A,@type,FLOAT_,@selcol,vec)
<<"=============\n"
<<"$T\n"



cf(A)
<<"%(2,, ,\n)$T\n"


T[::][1] = T[::][1]/127.0;
<<"=============\n"
<<"%(2,, ,\n)$T\n"
<<"=============\n"
B=ofw("new.dat")

bd = Cab(T)
<<"%V$bd\n"
<<"=============\n"
<<[B]"%(2,, ,\n)$T\n"

//wdata(B,R)

cf(B);

stop!
