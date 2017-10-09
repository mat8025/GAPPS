
setdebug(1,"pline")

checkIn()

float z = exp(1.0)

<<"%V$z\n"

//float Y[] = vgen(FLOAT_,10,0,1);  // fails
 Y = vgen(FLOAT_,10,0,1);  // fails


<<"Y $Y\n"

checkFnum(Y[1],1)


checkOut();

