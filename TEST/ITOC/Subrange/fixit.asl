
setdebug(1,"trace","~step","pline")
#define ASK ans=iread();
checkIn();

L = vgen(INT_,10,0,1);


proc Hey(V[])
//proc Hey(V)
{
<<"V: $V\n"

 V = 18;

<<"V: $V\n"

}
//==========================

Hey(L);

<<"$L\n"

checkNum(L[0],18)
checkNum(L[9],18)

ASK

checkOut()

exit();

