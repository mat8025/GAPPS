//setdebug(1)

chkIn()

I = vgen(INT_,10,0,1)

<<"$I \n"

chkN(I[0],0)

I->shiftL(I[0])

chkN(I[0],1)

<<"$I \n"

I->shiftL(I[0])

chkN(I[0],2)
chkN(I[9],1)

<<"$I \n"


I->shiftL()


<<"$I \n"


I->shiftL(10)


<<"$I \n"


D = vgen(DOUBLE,10,0,1)

<<"%6.2f$D \n"


D->shiftL(10)

chkN(D[0],1)



<<"%6.2f$D \n"


I->shiftR(-1)


<<"$I \n"

chkN(I[0],-1)

chkN(I[9],0)


D->shiftR(-47)

chkN(D[0],-47)

<<"%6.2f$D \n"

D->shiftR(79)

chkN(D[0],79)
chkN(D[1],-47)

<<"%6.2f$D \n"


I->shiftR(-79,5)




<<"$I \n"


I->shiftR()

chkN(I[0],0)

<<"$I \n"

chkOut()