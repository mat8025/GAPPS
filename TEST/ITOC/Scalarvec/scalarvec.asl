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
 

 chkIn()

 I = vgen(INT_,10,0,1)

<<"$I\n"

 chkN(I[1],1)


 K = I - 255


 chkN(K[1],-254)

<<"$K\n"


 M = 512 - I 


<<"$M\n"

 chkN(M[1],511)


  U = vgen(UCHAR_,12,0,1)

U->info(1)
<<"$U\n"

 sz = Caz(U)

<<"%v$sz\n"

 u = U[1]

  chkN(U[1],1)

  chkN(u,1)



 W= U[1:8:2]

<<"%V$W \n"

 chkN(W[1],3)

// chkN(U[1],1)


<<"%V$U\n"

 W= U - 32

<<"%V$W \n"
<<"$(typeof(W)) \n"


 if (! chkN(W[1],225)) {  // U is unsigned

<<"FAIL $W[1] 255\n")

 }
<<"%V$U\n"



if (! chkN(U[1],1) ) {

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

chkN(V[0],255)
chkN(V[1],254)

U->info(1)
sz = Caz(U)
 <<"%v$sz \n"
<<"%V $U\n"



chkN(U[1],1)
chkN(U[2],2)

//chkOut()
//exit()

 chkN(V[1],254)



<<"%V$U\n"

chkN(U[1],1)

<<"%V$U\n"

 W= U[0:9:3]

<<"%V$W \n"



 T = 255 - U[1:8:2]

<<"%V$T\n"
 chkN(T[1],252)

<<"%V$U\n"


 chkN(U[1],1)

 chkOut()