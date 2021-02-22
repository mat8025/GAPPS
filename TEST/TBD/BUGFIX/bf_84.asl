///
///
///

setdebug(1,"pline")

chkIn()

float z = exp(1.0)

<<"%V$z\n"

float Y[] = vgen(FLOAT_,10,0,1);  // works

<<"Y $Y\n"

chkR(Y[1],1)
chkR(Y[9],9)

 //Z[] = vgen(FLOAT_,10,0,1);  // fails
 Z = vgen(FLOAT_,10,0,1);  // works

<<"Z $Z\n"

chkR(Z[1],1)
chkR(Z[9],9)





chkOut();

