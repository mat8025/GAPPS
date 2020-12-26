//%*********************************************** 
//*  @script trim.asl 
//* 
//*  @comment test trim func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
/*
Trim(S)
Trims a string variable (or array of strings)
S->Trim(nc) - trims chaaracters from head or tail of string
S[a:b]->Trim(- 4)
would trim four chars from end of  a range of an array of strings - where S is an array
S->Trim(4)
would trim four chars from nead of  a range of an array of strings - where S is an array 

Prune(S)
Prunes a string variable (or array of strings) to a specified length
S->Prune(length) - trims characters from head or tail of string until a vspecified length
 no action if stem already less than of equal to required length
S[a:b]->Prune(-4)
would prune  from tail of  a range of an array of strings - where S is an array
S->Prune(4)
would prune from head of string until required length

*/


#include "debug.asl";
  debugON();


//  setdebug(1,@keep,@pline,@~trace);
//  FilterFileDebug(REJECT_,"~storetype_e");
//  FilterFuncDebug(REJECT_,"~ArraySpecs",);
  



chkIn()
svar  S = "una larga noche"

<<"%V $S\n"

<<" $(typeof(S)) $(Caz(S)) \n"

S[1] = "el gato mira la puerta"

S[2] = "espera ratones"

S[3] = "123456789"
<<"%V $S[2] \n"

<<"%(1,,,\n)$S \n"

S->trim(-3)

<<"%(1,,,\n)$S \n"

chkStr(S[3],"123456")

S[3]->trim(3)

chkStr(S[3],"456")

S->trim(3)

chkStr(S[3],"")

<<"%(1,,,\n)$S \n"

svar  T = "123456789"
T[1] = T[0]
T[2] = T[1]

<<"%(1,,,\n)$T \n"

T[1]->Prune(-3)

chkStr(T[1],"123")

<<"%(1,,,\n)$T \n"

T[2]->Prune(3)

chkStr(T[2],"789")

<<"%(1,,,\n)$T \n"


chkOut()