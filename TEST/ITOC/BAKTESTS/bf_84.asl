///
///
///

setdebug(1,"pline")

checkIn()

float z = exp(1.0)

<<"%V$z\n"

float Y[] = vgen(FLOAT_,10,0,1);  // works

<<"Y $Y\n"

checkFnum(Y[1],1)
checkFnum(Y[9],9)

 //Z[] = vgen(FLOAT_,10,0,1);  // fails
 Z = vgen(FLOAT_,10,0,1);  // works

<<"Z $Z\n"

checkFnum(Z[1],1)
checkFnum(Z[9],9)





checkOut();

