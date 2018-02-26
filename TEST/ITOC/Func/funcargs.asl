///
///
///

setdebug(1,"pline","~step")

CheckIn()

 int A[5];

 A= igen(5,0,1)

 B = A * 2

 a = 1.0

 y = Sin(a)

<<"$y \n"


 z = Cos(y)

<<"$z \n"


 w = Cos(Sin(a))

<<" $w \n"

 v= Sin(w)


 u = Sin(Cos(Sin(a)))

 r = Tan(u)

<<" $v $u \n"

 CheckFNum(v,u,6)

 t = Tan(Sin(Cos(Sin(a))))


<<" $r $t \n"

 CheckFNum(r,t,6)

testargs(1,@head,"big",@tail,"tiny",1,2,3,A)

 SV=testargs(@head,"big",@tail,"tiny",1,2,3,A)
//iread();
<<"whats in SV\n"
<<"%V$SV[0] $SV[1] $SV[2]\n"
<<"%(12,,\,,\n)$SV[0:10]\n"

<<"%(1,,,\n)$SV\n"
//<<"%(1,,,)$SV\n"


<<"%V$SV[3] $SV[8] $SV[18]\n"



int b = 79;
int c = 47;

 SV=testargs(1,&a,&b,&c)

<<"whats in SV\n"
<<"%V$SV[0] $SV[1] $SV[2]\n"

<<"%V $a $b $c \n"

 CheckOut()

;
