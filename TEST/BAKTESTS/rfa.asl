

setdebug(0)

opendll("math")


y = Sin(1.0)

<<" $y \n"

z = Cos(y)

<<"%v $z \n"

u = Cos(Sin(1.0))

<<" $u == $z  \n"


v = Sin(Cos(1.0))

<<" $v \n"


r = Cos(Sin(Cos(1.0)))

w = Cos(v)

<<" $r == $w \n"

float A[] = {1,2,3,4}

B = Sin(A)

<<" $B \n"

C= Cos(Sin(A))

<<" $C \n"

D = Cos(B)

<<" $D \n"

  D->redimn(2,2)

<<" $D \n"

<<" $(Cab(D)) \n"
  E= Transpose(D)

<<" $E \n"
<<" $(Cab(E)) \n"

 V=Sum(E)

<<" $V \n"

 V=Sum(D)

<<" $V \n"

 F= Sum(Transpose(D))

<<" $F \n"

;