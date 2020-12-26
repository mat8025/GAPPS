
svar S
S->info(1)
S = "what is going on 1 2 3"
// bug it has increased size to two elements - should be one
S->info(1)


<<" $(typeof(S)) \n"
<<"$S \n"
sz=Caz(S)
<<"%v$sz \n"
 S->Split()

<<" $S \n"

 w0 = S[0]
 w1 = S[1]
 w2 = S[2]
 w5 = S[5]

<<"%V $w0 \n$w1 \n$w2 \n$w5 \n"
