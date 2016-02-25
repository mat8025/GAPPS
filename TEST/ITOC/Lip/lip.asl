

openDll("stat")

checkIn()

X = vgen(FLOAT_,10,0,1)
Y = vgen(FLOAT_,10,-3,2)

<<"$X \n"
<<"$Y \n"


X1 = vgen(FLOAT_,40,0,0.25)
Y1 = vgen(FLOAT_,40,0)

<<"$X1 \n"


lip(X,Y,10,X1,Y1,40)


<<"%6.2f $Y1 \n"

checkFnum(Y1[0],-3)
checkFnum(Y1[1],-2.5)
checkFnum(Y1[36],15)
checkFnum(Y1[39],16.5)

checkOut()