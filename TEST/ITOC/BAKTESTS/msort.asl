//%*********************************************** 
//*  @script msort.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sun Dec 30 21:36:04 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%

checkin()

M = vgen(INT_,20,0,1)

<<"$M\n\n"
checkNum(M[3],3)

M->redimn(5,4)

<<"$M\n"
sz=Caz(M)
checkNum(sz,20)

<<"%V$sz \n"

bnds=Cab(M)

<<"%V$bnds \n\n"
checkNum(bnds[0],5)
checkNum(bnds[1],4)

checkNum(M[0][0],0)

T= mrevrows(M)

<<"$T\n"

checkNum(T[0][0],16)


S= msortcol(T,2)

<<"$S\n"

checkNum(S[0][0],0)
checkNum(S[4][0],16)

R= mrevcols(M)

<<"$R\n"

checkNum(R[0][0],3)
checkNum(R[0][3],0)

R= mxrows(M,1,2)

checkNum(R[1][0],8)
checkNum(R[2][0],4)

<<"$R\n"

S= msortcol(S,2)

<<"$S\n"

checkNum(S[1][0],4)
checkNum(S[2][0],8)


checkOut()