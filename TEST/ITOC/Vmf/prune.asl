//%*********************************************** 
//*  @script prune.asl 
//* 
//*  @comment test prune func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
/{/*

Prune(S)
Prunes a string variable (or array of strings) to a specified length
S->Prune(length) - trims characters from head or tail of string until a vspecified length
 no action if stem already less than of equal to required length
S[a:b]->Prune(-4)
would prune  from tail of  a range of an array of strings - where S is an array
S->Prune(4)
would prune from head of string until required length

/}*/



 include "debug.asl";
  debugON();
  setdebug(1,@keep,@pline,@~trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);


checkin()


svar  T = "123456789"
T[1] = T[0]
T[2] = T[1]
for (i=3;i<=10;i++) {
T[i] = T[0]
}
<<"%(1,,,\n)$T \n"

T[1]->Prune(-3)

checkstr(T[1],"123")

<<"%(1,,,\n)$T \n"

T[2]->Prune(3)

checkstr(T[2],"789")

<<"%(1,,,\n)$T \n"

T[4:6]->Prune(-5)

<<"%(1,,,\n)$T \n"

checkstr(T[4],"12345")
checkstr(T[5],"12345")
checkstr(T[6],"12345")
checkstr(T[7],"123456789")


checkout()