// mark a section - that never gets XIC'ed
// so the code is reinterpreted each pass/loop


setdebug(1)
for ( i = 0; i < 3 ; i++) {
A = 5

B = 4

C = A+ B

<<"%V $A + $B = $C \n"
}
for ( i = 0; i < 3 ; i++) {

xic(0)

D = 5

E = 4

G = D * E

<<"%V $D * $E = $G \n"

xic(1)

}




H = 5

I = 4

J = H / I

<<"%V $H / $I = $J \n"


stop!





