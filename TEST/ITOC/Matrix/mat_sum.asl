
#include "debug.asl"

debugON()

chkIn(_dblevel)


int A[] = {16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}


  A->Redimn(4,4)


<<"$A\n"

<<"A = $A\n"


 VSA = Sum(A)
 
<<"$VSA \n"


 T= mtrp(A)

 T->info(1)

<<"T \n"

<<"$T\n"


X= Sum(T)
<<"tsum of T \n"
X->Info(1)
<<"$X \n"



 V1 = Sum(A)
 <<"V1 $(Cab(V1))\n"
 <<"$V1\n"

<<"$A\n"

  B=mtrp(A)

<<"\n$A\n"

<<"\n$B\n"

 V1->info(1)

 V = Sum( mtrp(A) )
 
 V->info(1)

<<"V1 $V1\n"
<<"V $V\n"

 V->info(1)

val = V[0]

<<"V $V\n"

val1 = V1[0]


<<"$V1[0] $V1[1]\n"
<<"$V[0] $V[1]\n"
<<"$val $val1\n"

val = V[1]
V->info(1)
<<"V $V\n"
val1 = V1[1]

<<"$val $val1\n"

<<"V1 $V1\n"




chkN(V[0],34)
chkN(V1[0],34)

//assert((V1[0] == 34),"(V1[0] == 34)");
//assert((V[0] == 34),"Sum(mtrp(A)) bug");

chkOut()