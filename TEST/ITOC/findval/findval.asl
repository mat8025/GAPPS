# test ASL function findval
chkIn()

setdebug(0)
I= Igen(20,0,1)


<<" $I \n"

<<" $I[3:7] \n"

;


int fi = 0

   found= findval(I,6,&fi,0,1)

<<"$found $fi \n"

chkN(fi,6)

   found= I->findval(7,&fi,0,1)

chkN(fi,7)

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

chkOut()

;