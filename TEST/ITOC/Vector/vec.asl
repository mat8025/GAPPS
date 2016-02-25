
setdebug(1)

V= vgen(FLOAT_,10,0,1)

<<"$V\n"


T = V + 1.0

<<"%6.2f$T \n"


T = 2+ V 

<<"%6.2f$T \n"


T = (2+ V)/4.0 

<<"%6.2f$T \n"

// FIX XIC fail
T = (2+ V)/(4.0 * (V+1)) 

<<"%6.2f$T \n"

<<"$(Caz(T)) $(Cab(T))\n"

  