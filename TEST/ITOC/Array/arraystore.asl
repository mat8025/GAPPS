
setdebug(1)

checkIn()
A= vgen(FLOAT_,10,0,1)


B = A

I=Cmp(A,B,"==")

<<"$I\n"

checkNum(I[1],1)

C = B * 2;

I=Cmp(A,C,"==",1)

<<"$I\n"

checkNum(I[1],0)

D= reverse(B)
<<"$D\n"
I=Cmp(B,D,"==")

checkNum(I[0],-1)

I=Cmp(B,D,"!=",1)

<<"$I\n"

checkNum(I[1],1)
checkNum(I[9],1)

<<"$A\n"
<<"$B\n"
<<"$C\n"

checkOut();

exit();