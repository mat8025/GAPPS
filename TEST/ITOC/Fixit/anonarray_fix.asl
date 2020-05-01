
///
///
///

include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_","hop_");

setdebug(1,@pline,@~trace)


a =1;
b= 2;
c = 3;

int A[] = {a,b,c};

A->info(1)
<<"$A\n"

proc goo( real V[])
{
<<"$_proc $V\n"

}

proc goo( svar S)
{
<<"$_proc $S[::]\n"
S->info(1)
R= S;
<<"$R\n"
}


V=vgen(INT_,3,0,1)
<<"$V \n"

goo(V)

V[1]=77

goo(V)

real T[] = {4,5,6}

T->info(1)

goo(T)

TS = Split("7,8,9",",")
TS->info(1)
goo(TS)

//goo({4,5,6})

S=testargs(1,V,{4,5,6,})

//<<"%(1,,,\n)$S\n"

printargs(1,V,{4,5,6,})