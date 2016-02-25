// vops  ----
CheckIn()
setdebug(1)

 PFIV = Igen(10,0,1)

<<"$PFIV \n"

CheckNum(PFIV[0],0)
CheckNum(PFIV[9],9)



 PFIV = PFIV + 2

<<" $PFIV \n"



CheckNum(PFIV[0],2)

checkOut()
stop!

 PFIV += 3

<<" $PFIV[::] \n"

CheckNum(PFIV[0],5)


PFIV[3] = 4

<<" $PFIV[::] \n"

//<<" $PFIV[0] \n"
//<<" $PFIV[3] \n"
// FIXME
PFIV[3] = -3

<<" $PFIV[::] \n"


 PFIV *= 2

<<" $PFIV[::] \n"
CheckNum(PFIV[0],10)




 PFIV = PFIV * 2

<<" $PFIV \n"
CheckNum(PFIV[0],20)

 PFIV /= 4

<<" $PFIV \n"
CheckNum(PFIV[0],5)

CheckOut()

stop!