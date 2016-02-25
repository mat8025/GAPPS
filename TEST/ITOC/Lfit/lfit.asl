openDll("stat")

X = vgen(FLOAT_,10,0,1)
Y = vgen(FLOAT_,10,-3,2)


LF= Lfit(X,Y)

<<"$LF\n"


LF= Lfit(X,M)

<<"$LF\n"

<<" not enuf functions\n"
LF= Lfit(X)

<<"$LF\n"


stop!