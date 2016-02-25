
// vector vector opeq  
//setdebug(1,"pline")
checkIn()

proc foo()
{

  Y *= T


<<"in proc $Y\n"


}


   Y = vgen(FLOAT_,10,0,1);


<<"Y $Y\n"

  Y *= 2;

<<"$Y\n"

checkNum(Y[2],4)

  T = vgen(FLOAT_,10,0,1);


<<"$T\n"
checkNum(T[2],2)

  Y *= T

checkNum(Y[2],8)

<<"$Y\n"

 foo()

checkNum(Y[2],16)

<<"$Y\n"

 foo()

checkNum(Y[2],32)
<<"$Y\n"

 Y *= T
checkNum(Y[2],64)

<<"$Y\n"

foo()

checkNum(Y[2],128)

checkOut()