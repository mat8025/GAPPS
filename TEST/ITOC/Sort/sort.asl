
setdebug(atoi(getenv(GS_DEBUG)));


I = vgen(INT_,10,0,2)

<<"$I \n"

I->reverse()

<<"$I \n"

I->sort()

<<"$I \n"

I->reverse()

K =Sort(I)

<<"K: $K \n"
<<"I: $I \n"

K = Isort(I)

<<"$K \n"





K =Sort(I[0:5])

<<"K: $K \n"

<<"$I \n"


M = vgen(INT_,20,0,1)

M->redimn(4,5)

<<"$M\n"

M->Sort()

<<"$M\n"

L= cyclerow(M,1)

<<"$L \n"

<<"$M\n"

L= cyclecol(M,1)

<<"$L \n"

exit()




I->reverse()


<<"$I \n"

I->Sort()

<<"$I \n"

I->reverse()






//<<"$K \n"

I->Sort()




<<"$I \n"