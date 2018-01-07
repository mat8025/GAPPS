

checkIN()
V=fgen(5,0,1);

W=fgen(5,5,1);

T=fgen(5,10,1);

R=fgen(5,15,1);

<<"%V %4.1f $V $W $T $R\n"

checkNum(R[4],19)


U = V @+ W @+ T @+ R

<<"%V %4.1f $U \n"

checkNum(U[19],19)

checkOut()


