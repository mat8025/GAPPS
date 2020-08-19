# test ASL function findval
CheckIn()

setdebug(0)

I= Igen(20,0,1)


<<" $I \n"

<<" $I[3:7] \n"

;




   fi = findval(I,6,0,1)

<<" is 6 in vec ? $fi \n"

CheckNum(fi,6)

   fi= I->findval(7,0,1)

CheckNum(fi,7)

<<"is 7 in vec ? $fi \n"





   fi= I->findval(17,-1,-1)


<<"is 17 in vec ? $fi \n"

   fi= I->findval(17,15,-1)


<<"is 17 in vec below 15 ? $fi \n"


   I[4] = 6
   vf = findval(I,6,0,1,1)

<<" $vf \n"


   vf = findval(I,76,0,1,1)

<<" $vf \n"

stop!

F= Fgen(20,0,1)


<<" $F \n"
// FIXME <<" $F[3:7] \n"
<<" $F[3:7] \n"


   fi= findval(F,6,0,1)

<<" $fi \n"

   fi= F->findval(7,0,1)

<<" $fi \n"

CheckOut()

;