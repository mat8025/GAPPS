

setdebug(0)

A=ofw("pr.log")

float F[]

F = Fgen(20,0,1)

<<"%v6.2f$F \n"

<<"%v6.2f=$F \n"


<<"%v=$F[2:7] \n"

<<"%v= $F[2:7] \n"

<<[A]"$F[2:7] \n"

cf(A)

A=ofr("pr.log")

V=readline(A)

<<" $V \n"

 T= split(V)
<<" $T \n"
<<"%V$T[1]   $T[5]\n"

float G[]

G= atof(T[1:5])

sz = Caz(G)
<<"%v $sz %v $G \n"

stop!




i = 3
j = 9


<<"%6.2f %v = $F[i:j] \n"

stop!
i++
j++

<<"$F[i:j] \n"


#{
// FIXME
float G[] = Igen(20,0,1)

<<" $G \n"


<<"$G[2:7] \n"
#}

;
