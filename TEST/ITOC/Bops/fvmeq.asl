
setdebug(1);

checkin()


na = argc()

if (na >= 1) {
 for (i = 0; i < argc() ; i++) {
<<"arg $i $_clarg[i] \n"
 }
}

//setdebug(1)
F =vgen(FLOAT_,10,0,1)

<<"%V $F \n"


CheckFNum(F[1],1.0,6)
CheckFNum(F[9],9.0,6)

<<" vec -= 1.5 \n"

  F -= 1.5

<<"%V $F \n"

CheckFNum(F[1],-0.5,6)
CheckFNum(F[9],7.5,6)

 F += 1.5

<<"%V $F \n"

CheckFNum(F[1],1.0,6)
CheckFNum(F[9],9.0,6)


 F *= 2.0

<<"%V $F \n"

CheckFNum(F[1],2.0,6)
CheckFNum(F[9],18.0,6)

 F /= 2.0

<<"%V $F \n"

CheckFNum(F[1],1.0,6)
CheckFNum(F[9],9.0,6)


CheckOut()

stop!