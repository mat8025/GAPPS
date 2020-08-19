
setdebug(1,"trace")

Svar R = "how did we get here";

<<"%V $R[0]\n"

Svar S = Split("how did we get here");


<<"%V $S[0]\n"



T = Split("how did we get here");

<<"%V $T[0]\n"





 S[8] = "dandy"

<<"%V $S[8]\n"

 S[0] = "howdy"


<<"%V $S[0]\n"



// S = Split("how did we get here");


sz = Caz(S)
<<"S %V $sz\n"

<<" $(typeof(S))\n"

<<"$S\n"

 r00 = S[0];

 r01 = S[1];

 r80 = "just fine"

// S[8] = "dandy"

<<" $(typeof(S))\n"

<<"%V $r00 $r01 $r80 $S[8]\n"

sz = Caz(S)

<<" $(typeof(S)) $sz\n"

<<"%V $sz\n"

//////////////////////////////




 T = Split("how did we get here");


sz = Caz(T)
<<"T %V $sz\n"

bd = Cab(T)
<<"T %V $bd\n"

<<" $(typeof(T))\n"

<<"$T\n"

 t00 = T[0];

 t01 = T[1];

 r80 = "just fine"

 T[8] = "dandy"

<<"T %V $t00 $t01 $r80\n"

sz = Caz(T)

<<" $(typeof(T)) $sz\n"

<<"%V $sz\n"


exit()

svar M[] = {"how did we get here"}


<<"$M\n"

 r00 = M[0];

 r01 = M[1];

 r80 = "just fine"


<<"%V $r00 $r01 $r80\n"

msg = "how did we get here"
<<"$msg \n"