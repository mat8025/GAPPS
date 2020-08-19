//%*********************************************** 
//*  @script splice.asl 
//* 
//*  @comment test splice(insert) vectors 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Fri May  1 08:49:45 2020 
//*  @cdate Fri May  1 08:49:45 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

 //Splices one vector into another at the specified index.
 
checkIn(_dblevel)

I = vgen(INT_,10,1,1)

K = I

<<"%V$I \n"


I[1] = 47
<<"%V$I \n"


R = vReverse(I)
<<"%V$R \n"
checkNum(R[0],10)



R = vReverse(R)
<<"%V$R \n"
checkNum(R[1],47)


R = vReverse(R)
<<"%V$R \n"






K = vgen(INT_,10,10,-1)



J = vSplice(I,K,4)

<<"%V$I \n"
<<"%V$K \n"
<<"%V$J \n"

checkNUm(J[4],10)


J = vSplice(I,vReverse(K),4)

<<"%V$J \n"



R = vReverse(K)
<<"%V$R \n"
<<"%V$K \n"

checkOut()