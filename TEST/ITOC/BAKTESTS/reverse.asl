//%*********************************************** 
//*  @script reverse.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Sat Dec 29 14:26:32 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///
setdebug(1,@keep)

checkIn()

 I = vgen(INT_,20,0,1);

<<"$I \n"

 checkNum(I[19],19)
 J = vreverse(I)

<<"$J \n"
 checkNum(J[0],19)
  checkNum(J[19],0)

 M = redimn(J,4,5);
<<"\n"
<<"$J \n"

 T= fliprows(J);
<<" fliprows\n"
<<"$T \n"



 T= flipcols(J);
<<"flipcols\n"
<<"$T \n"

checkOut()
