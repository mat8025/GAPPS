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

//////////////

A=ofr("rec.dat")


S=ReadRecord(A,@type,"record")

<<"$S\n"
<<"$(typeof(S))\n"
wr=typeof(S)

<<"$wr\n"
L=testargs(wr)

<<"$L\n"

L=testargs(typeof(S),1)

<<"$L\n"

//pa(typeof(S));

<<"$(typeof(S))\n"

<<"%V $(caz(S))  $(Cab(S))\n"

<<"the type via testargs\n"
testargs(3,typeof(S));

<<"$S[0]\n"

<<"$S[1]\n"
<<"$S[1][0]\n"
<<"$S[1][2]\n"

<<"$(Caz(S[1]))\n"

stop!
