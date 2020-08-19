//%*********************************************** 
//*  @script scalarvec.asl 
//* 
//*  @comment scalar vec ops 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                 
//*  @date Thu Mar  7 23:34:50 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl"; 
  debugON(); 
  setdebug(1,@keep,@pline,@trace); 
  FilterFileDebug(REJECT_,"storetype_e","ds_storevar","ds_sivmem");
  FilterFuncDebug(REJECT_,"~ArraySpecs",); 
 

 CheckIn()

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

U->info(1)
<<"$U\n"

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

T = U -255 
<<"%V$T\n"
sz = Caz(T)

<<"%v$sz \n"

  V = 255 -U
  <<"%V$V\n"

CheckNum(V[0],255)
CheckNum(V[1],254)

U->info(1)
sz = Caz(U)
 <<"%v$sz \n"
<<"%V $U\n"



CheckNum(U[1],1)
CheckNum(U[2],2)

//CheckOut()
//exit()

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