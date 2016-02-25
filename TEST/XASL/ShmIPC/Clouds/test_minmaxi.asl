openDll("math")

randseed()

float F[] =  {0,1,2,3,4,5,6,7,8,9}


<<"$F \n"


  mmi = minmaxi(F)

<<"$mmi \n"


  mmi = minmaxi(F,3,8)

<<"$mmi \n"


A = Rand(10,10)

<<"$A\n"


  mmi = minmaxi(A)

<<"$mmi $A[mmi[0]] $A[mmi[1]]\n"
