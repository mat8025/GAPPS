
setdebug(1)

checkIn()
V= vgen(FLOAT_,10,0,1)

<<"%V6.1f $V\n"


T = V + 1.0

<<"(V+1) %6.1f$T \n"

checkNum(T[1],2)

T = 2+ V 

<<"(V+2) %6.2f$T \n"

checkNum(T[1],3)

T = (2+ V)/4.0 

<<"(2+V/4.0) %6.2f$T \n"

checkNum(T[1],0.75)


// FIX XIC fail
H = (4.0 * (V+1))
<<"%V%6.1f $H\n"

T = (2+ V)/(4.0 * (V+1)) 

checkNum(T[1],0.375)

<<"%6.4f$T \n"

<<"$(Caz(T)) $(Cab(T))\n"

checkOut()
  