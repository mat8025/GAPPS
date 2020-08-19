

A=ofw("log")

<<[A],"first line in log file\n"


<<[A],"second line in log file\n"


svar W
W[0] = "hey"

 W[1] = "mark"

 W[2] = "can"

 W[3] = "you"

 W[4] = "make"

 W[5] = "your"

 W[6] = "goal"

<<[A]"$W[0:3]\n"
<<[A]"$W[4:-1]\n"
<<[A]"$W[-1:0:-1]\n"
<<"$W[-1:0:-1]\n"






cf(A)

!!"cat log"

