Record R[]
Rn =3;
 R[0] = Split("hey does this work at all");
 <<"$R[0] \n"

 R[1] = Split("does this still work ");
 <<"$R[1] \n"

//  R[(Rn+5)][0] = "#"; // array index not computed??
    wri = Rn+5
    <<"%V$wri\n"
    R[Rn+5][0] = "#"; // array index not computed??

<<"$R[::] \n"

Svar S;

S=" MUSHROOMS WHITE                      0.10 CUP 1.54 0.23 0.02 0.22 0.00 0.00 7.00 1.21 0.00 0.20 0.40 1.70 1.30"

<<"$S\n"

T= Split(S);

<<"$T[0] $T[1] $T[2]\n"

<<"$(Caz(T))\n"

<<"$T[4:16]\n"

W=T[4:16];

<<"$W\n"

<<"$(typeof(W)) $(Caz(W))\n"

F = atof(W)

<<"$(typeof(F)) $(Caz(F))\n"

<<"$F \n"

<<"$F[1] $F[2]  $F[5:8] \n"