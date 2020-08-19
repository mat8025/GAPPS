
A=ofr("spe_wc")

S=readfile(A)

<<"$S[0]"

<<"$S[1]"

<<"$S\n"

nl = Caz(S)

<<"%V$nl\n"

svar M[10]

T= split(S[0])

<<"$T[1] $T[3]\n"

M[0]    = T[0]
M[3]    = T[3]

<<"$M[0]    $M[3]\n"

<<"$S[1]{3}\n"

<<"$S[1]{5}\n"


M[4] = S[4]

<<"$M[4]\n"

 


svar R[nl]

nb = Cab(R)

<<"%V$nb \n"

<<"$(Cab(R))   $(Caz(R))\n"


R[0][1] = T[0]



R[0][3] = T[3]

<<"$R[0][1] \n"
<<"$R[0][3] \n"

  for (i = 0; i < 10 ; i++) {
    T= split(S[i])
<<"$i $T\n"
    R[i][1] = T[0]
    R[i][1] = T[1]
    R[i][2] = T[2]        
    R[i][3] = T[3]
<<"$R[i][0] $R[i][3]\n"    
  }


  for (i = 0; i < 10 ; i++) {

<<"$R[i][0] $R[i][3]\n"

  }