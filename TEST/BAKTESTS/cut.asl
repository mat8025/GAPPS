// test cut array

CheckIn()

int I[] ;

I= Igen(20,0,1)

<<"$I \n"

C = Igen(4,12,1)

<<"$C \n"

I->cut(C)

<<" $I \n"

CheckNum(I[12],16)


//float F[]

F= Fgen(20,0,1)
sz = Caz(F)
<<"$sz $F \n"
//<<"%,j%{5<,\,>\n}%6.1f$F\n"

<<"%6.1f$F\n"

C = Igen(4,12,1)

<<"%V $C \n"

F->cut(C)




<<"%6.1f$F \n"
CheckFNum(F[12],16,6)


I[3:8]->cut()

//<<" $I[::] \n"
<<" $I \n"

CheckNum(I[3],9)

<<"$I[0:-1:2]\n"

Y = I

<<"Y $Y = $I \n"

Y = I[0:8:1]

<<" $Y \n"




F[3:8]->cut()

<<" %6.1f$F[::] \n"
CheckFNum(F[3],9,6)

F[3]->cut()

<<" %6.1f $F[::] \n"

CheckOut()

;