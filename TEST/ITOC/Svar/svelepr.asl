CheckIn()

setdebug(1)

//kd=!!"rm -f goal1"
//<<"%V$kd \n"

!!"rm -f goal1"

Svar W;


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



//sleep(1)

goal_fn = "goal1"

rsz=fstat(goal_fn,"size")
<<"\nfile size $rsz \n"


A=ofw(goal_fn)
<<" %V$A\n"
if (A == -1) {
<<"error write file open\n")
exit()
}


<<[A]"%(4,,\s,\n) $W"
fprintf(A,"%(4,,\s,\n) $W")
<<[A]"\n whats going on\n"
fprintf(A,"via fprintf\n")
fflush(A);
cf(A)



//sleep(1)

rsz=fstat(goal_fn,"size")
<<"\nfile size $rsz \n"
if (rsz ==0) {

sleep(5);
}

rsz=fstat("goal1","size")
<<"\nfile size $rsz \n"

B=ofr(goal_fn)

if (B == -1) {
 <<"error read file open\n")
 exit()
}

// FIXME -- should not need explicit svar declare
//svar V;

 V=readfile(B)

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
<<"%V$Z[4] \n"



CheckStr("hey",Z[0]);

CheckStr("make",Z[4]);

<<"$Z[4] \n"

cf(A)

CheckOut()

