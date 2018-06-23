///
///
///

setdebug(1,@pline,@keep,@trace)

svar  S = "una larga noche"

<<"%V $S\n"

<<" $(typeof(S)) $(Caz(S)) \n"

S[1] = "el gato mira la puerta"

S[2] = "espera ratones"

<<"%V $S[2] \n"


 svar E[] = { "the first ten elements are:", "H", "He", "Li", "Be" ,"B" ,"C", "N", "O", "F", "Ne"  }; 


<<"$E\n"
<<"$E[1] \n"

<<"$E[2] \n"

<<"$E[3:6] \n"


 W= E[3:7];

<<"$W\n"

 W[3:4] = E[7:8];


<<"%V$W \n"