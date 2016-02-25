CheckIn()
//setdebug(1,"step")
I = vgen(INT_,10,0,1)

<<"%V$I \n"

K = I[2:8]

<<"%V$K\n"

 checkNum(K[0],2)

K = I[6:1:-1]

<<"%V$K\n"

 checkNum(K[0],6)
 checkNum(K[1],5)
 checkNum(K[5],1)

K = I[6:1:1]

<<"%V$K\n"

 checkNum(K[0],6)
 checkNum(K[1],7)
 checkNum(K[5],1)

 CheckOut()

stop!