
setdebug(1,"trace","~step","pline")
#define ASK ans=iread();
chkIn();

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

chkN(L[0],18)
chkN(L[9],18)

ASK

chkOut()

exit();

