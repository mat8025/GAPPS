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
/{/*
Trim(S)
Trims a string variable (or array of strings)
S->Trim(nc) - trims chaaracters from head or tail of string
S[a:b]->Trim(- 4)
would trim four chars from end of  a range of an array of strings - where S is an array
S->Trim(4)
would trim four chars from nead of  a range of an array of strings - where S is an array 


/}*/



 include "debug.asl";
  debugON();
  setdebug(1,@keep,@pline,@~trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);
  



checkin()
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

checkstr(S[3],"123456")

S[3]->trim(3)

checkstr(S[3],"456")



S->trim(3)



checkstr(S[3],"")




<<"%(1,,,\n)$S \n"



checkout()