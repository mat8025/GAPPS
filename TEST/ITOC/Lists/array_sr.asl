setdebug(0)
chkIn()

I = vgen(INT_,10,0,1)

<<"%V$I \n"

K = I[2:8]

<<"%V$K\n"

 chkN(K[0],2)

K = I[6:1]

<<"%V$K\n"

 chkN(K[0],6)
 chkN(K[1],5)
 chkN(K[5],1)

 chkOut()

stop!