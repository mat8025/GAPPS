setdebug(1)

CheckIn()
// setdebug(0)

 I = vgen(INT_,10,0,1)

<<"$I\n"

 CheckNum(I[1],1)


 K = I - 255


 CheckNum(K[1],-254)

<<"$K\n"


 M = 512 - I 


<<"$M\n"

 CheckNum(M[1],511)


  U = vgen(UCHAR_,12,0,1)

<<"%I$U\n"

 sz = Caz(U)

<<"%v$sz\n"

 u = U[1]

 CheckNum(U[1],1)

  CheckNum(u,1)



 W= U[1:8:2]

<<"%V$W \n"

 CheckNum(W[1],3)

// CheckNum(U[1],1)


<<"%V$U\n"

 W= U - 32

<<"%V$W \n"
<<"$(typeof(W)) \n"


 if (! CheckNum(W[1],225)) {  // U is unsigned

<<"FAIL $W[1] 255\n")

 }
<<"%V$U\n"



if (! CheckNum(U[1],1) ) {

<<"FAIL $U[1] 1\n")

}

sz = Caz(U)
<<"%v$sz \n"

V = 255 -U
<<"%V$V\n"
sz = Caz(U)
<<"%v$sz \n"






 CheckNum(V[1],254)



<<"%V$U\n"

CheckNum(U[1],1)

<<"%V$U\n"

 W= U[0:9:3]

<<"%V$W \n"



 T = 255 - U[1:8:2]

<<"%V$T\n"
 CheckNum(T[1],252)

<<"%V$U\n"


 CheckNum(U[1],1)

 CheckOut()