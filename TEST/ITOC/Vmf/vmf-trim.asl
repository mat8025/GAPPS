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
*/
#include "debug"

if (_dblevel >0) {
   debugON()
}
chkIn(_dblevel)


svar  S = "una larga noche"

<<"%V $S\n"

<<" $(typeof(S)) $(Caz(S)) \n"

S[1] = "el gato mira la puerta"

S[2] = "espera ratones"

S[3] = "123456789"

<<"%V $S[0] \n"
<<"%V $S[1] \n"
<<"%V $S[2] \n"
<<"%V $S[3] \n"

<<"%(1,,,\n)$S \n"
//<<"%V $S[0] \n"
S->info(1)

S->trim(-3)

<<"%(1,,,\n)$S \n"


chkStr(S[3],"123456")

S[3]->trim(3)

<<"%V$S[3]\n"

chkStr(S[3],"456")



S->trim(3)



chkStr(S[3],"")


<<"%(1,,,\n)$S \n"

//chkStage("Trim")
chkOut()
