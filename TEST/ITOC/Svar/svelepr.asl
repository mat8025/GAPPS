CheckIn()

setdebug(1)

Svar W


W[0] = "hey  "


<<"%v $W[0] \n"

 W[1] = "mark"

<<"%v $W[1] \n"

<<"%v $W[0] \n"

 W[2] = "can"

<<" $W \n"

 W[3] = "you"


<<"%v $W[0] \n"

 W[4] = "make"

 W[5] = "your"

 W[6] = "goal"

 W[7] = "weight"

// W[8] = "?"

<<"W $W[0:-1] \n"

<<"%(5,<<\s,\s,\s>>\n)$W[::] \n"
<<"-----------------------\n"
<<"-----------------------\n"

<<"%(4,,\s,\n)$W"

!!"rm -f goal1"

//sleep(1)


A=ofw("goal1")

if (A == -1) {
<<"error write file open\n")
exit()
}

<<[A]"%(4,,\s,\n) $W"

cf(A)


A=ofr("goal1")

if (A == -1) {
<<"error read file open\n")
exit()
}

// FIXME -- should not need explicit svar declare
svar V

 V=readfile(A)

<<" file read as:-\n"
<<"$V \n"


<<"------------- \n"
<<"V is  $(typeof(V)) \n"


<<"just first line: $V[0] \n"
<<"second $V[1] \n"
<<"third $V[2] \n"



// FIXME -- should not need explicit svar declare split should deliver svar
//svar Z
<<"V is $V[0:1:]\n"
<<"___________\n"
Z= "$V"

Z->split()

<<"Z= $Z \n"
<<"Z[0] $Z[0] \n"
<<"Z[1] $Z[1] \n"
<<"Z[2] $Z[2] \n"
<<"Z[3] $Z[3] \n"
<<" $Z[4] \n"




CheckStr("hey",Z[0])
CheckStr("make",Z[4])

<<"$Z[4] \n"

cf(A)

CheckOut()

