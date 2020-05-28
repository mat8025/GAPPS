# test ASL function findval
CheckIn()

setdebug(0)
I= Igen(20,0,1)


<<" $I \n"

<<" $I[3:7] \n"

;


int fi = 0

   found= findval(I,6,&fi,0,1)

<<"$found $fi \n"

CheckNum(fi,6)

   found= I->findval(7,&fi,0,1)

CheckNum(fi,7)

<<"$found $fi \n"


   found= I->findval(17,&fi,15,-1)


<<"$found $fi \n"


   found= I->findval(17,&fi,-1,-1)


<<"$found $fi \n"



F= Fgen(20,0,1)


<<" $F \n"

<<" $F[3:7] \n"


   found= findval(F,6,&fi,0,1)

<<"$found $fi \n"

   found= F->findval(7,&fi,0,1)

<<"$found $fi \n"

CheckOut()

;