///
setdebug(1,"pline","trace","step")

I = vgen(INT_,10,0,1)

<<"$I \n"

//<<"$(typeof(I)) $(infoof(I)) \n"
//H = I;
//<<"$H\n"

p = &I[3];

<<"$p \n"

<<"p is $(typeof(p)) $(infoof(p)) \n"

int G[10]


nc= vvcopy(I,G,ALL_);

<<"$nc elements copied\n"

<<"%V $G\n"


nc= vvcopy(&I[3],G, ALL_);

<<"$nc elements copied\n"

<<"%V $G\n"

nc= vvcopy(p,G, ALL_);

<<"$nc elements copied\n"


<<"%V $G\n"
//fflush(_Jf)
exit()

 p = 56;

<<"$I \n"

 p = vgen(INT_,3,-1,1)

<<"$I \n"

J= p;

<<"%V $J\n"



exit()
int a = 2

<<"%v $a \n"

    d = &a
    d = 3

<<"%v $a \n"

<<"%v $d \n"

<<"d is $(typeof(d)) $(infoof(d)) \n"