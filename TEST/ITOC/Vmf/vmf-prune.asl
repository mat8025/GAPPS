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

/*

Prune(S)
Prunes a string variable (or array of strings) to a specified length
S->Prune(length) - trims characters from head or tail of string until a vspecified length
 no action if stem already less than of equal to required length
S[a:b]->Prune(-4)
would prune  from tail of  a range of an array of strings - where S is an array
S->Prune(4)
would prune from head of string until required length

*/
#include "debug"

if (_dblevel >0) {
   debugON()
}
chkIn(_dblevel)



svar  TP;
//TP[0]= "123456789"  ; // bug FIXED converts to STRV -instead of filling TP[0]
TP =  "123456789"
TP->info(1)
<<"$TP[0] \n"
TP[1] = TP[0]
TP[2] = TP[1]
for (i=3;i<=10;i++) {
TP[i] = TP[0]
}
<<"%(1,,,\n)$TP \n"

TP[1]->Prune(-3)

chkStr(TP[1],"123")

<<"%(1,,,\n)$TP \n"

TP[2]->Prune(3)

chkStr(TP[2],"789")

<<"%(1,,,\n)$TP \n"
TP->info(1)
TP[4:6]->Prune(-5)

<<"%(1,,,\n)$TP \n"

chkStr(TP[4],"12345")
chkStr(TP[5],"12345")
chkStr(TP[6],"12345")
chkStr(TP[7],"123456789")

//chkStage("Prune")
chkOut()
