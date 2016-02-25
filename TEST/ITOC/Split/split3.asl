
svar S
S = "what is going on 1 2 3"

<<" $(typeof(S)) \n"
<<"$S \n"

  S->split()

<<" $S \n"

 w0 = S[0]
 w1 = S[1]
 w2 = S[2]
 w5 = S[5]

<<"%V $w0 \n$w1 \n$w2 \n$w5 \n"


stop!
;