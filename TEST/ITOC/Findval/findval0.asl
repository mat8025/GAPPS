
<|Use_=
Demo  of findval;
searches vector V for a value comparison (default ==]
fvec = findval(V,val,si,fi,dir,all,cmp)
fvec = findval(V,6,0,-1,1,1,GTE_)

///////////////////////
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


chkIn(_dblevel)


I= Igen(20,0,1)


 <<" $I \n"



   fi = findval(I,6,0,-1,1,1,"<=")

<<" is 6 in vec ?  \n"

<<" $fi \n"



fi->info(1)

chkN(fi[0],6)

// <<" $I[3:7] \n"

   fi= I->findval(7,0,-1,1,EQU_)

<<"$fi \n"

chkN(fi[0],7)

<<"is 7 in vec ? $fi \n"





   fi= I->findval(17,-1,-1)


<<"is 17 in vec ? $fi \n"

   fi= I->findval(17,15,-1)


<<"is 17 in vec below 15 ? $fi \n"


   I[4] = 6
   vf = findval(I,6,0,1,1)
vf->info(1)
<<" $vf \n"


   vf = findval(I,76,0,1,1)

<<" $vf \n"



F= Fgen(20,0,1)


<<" $F \n"
// FIXME <<" $F[3:7] \n"
<<" $F[3:7] \n"


   fi= findval(F,6,0,1)

<<" $fi \n"

   fi= F->findval(7,0,1)

<<" $fi \n"

chkOut()

