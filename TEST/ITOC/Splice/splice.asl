
//setdebug(1)
I = vgen(INT_,10,1,1)

K = I

<<"%V$I \n"


I[1] = 47
<<"%V$I \n"


R = vReverse(I)
<<"%V$R \n"



R = vReverse(R)
<<"%V$R \n"

R = vReverse(R)
<<"%V$R \n"






K = vgen(INT_,10,10,-1)



J = vSplice(I,K,4)

<<"%V$I \n"
<<"%V$K \n"
<<"%V$J \n"



J = vSplice(I,vReverse(K),4)

<<"%V$J \n"



R = vReverse(K)
<<"%V$R \n"
<<"%V$K \n"