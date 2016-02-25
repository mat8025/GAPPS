CheckIn()

// test array indexing

setdebug(0)

N = 20


//int YV[] = Igen(N,21,1)
// YV[] = Igen(N,21,1)
//int YV[]


 YV = Igen(N,21,1)

<<"%v $YV \n"



 vi = 5


int P[10]

  P[1] = 1
  P[2] = 3
  P[3] = 8
 

YV[0] = 74
<<"%v $P \n"

NV = YV @+ P

sz = Caz(NV)

<<"%v $sz \n"

<<"%v $NV \n"


stop!

<<" $YV \n"

<<" $NV[2] \n"

<<" $NV[22] \n"


<<" $YV \n"


YV = YV @+ P

<<" $YV \n"


 S = YV[P]

<<" %v $P \n"
<<" %v $S \n"

 CheckNum(NV[1],YV[1])

 CheckNum(NV[2],YV[2])

 CheckNum(NV[21],P[1])


 CheckOut()


STOP!
