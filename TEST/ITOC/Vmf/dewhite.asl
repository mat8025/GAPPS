//%*********************************************** 
//*  @script dewhite.asl 
//* 
//*  @comment test dewhite func 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Fri Mar 15 11:52:53 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
/{/*

Dewhite(S)
Dewhites a string variable (or array of strings)
S->Dewhite() - dewhites a string
S[a:b]->Dewhite()
would dewhite a range of an array of strings - where S is an array 

/}*/



 include "debug.asl";
  debugON();
  setdebug(1,@keep,@pline,@trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);


checkin()


svar  T = "123 456   789  "
T[1] = T[0]
T[2] = T[1]

for (i=3;i<=10;i++) {
T[i] = T[0]
}


<<"%(1,,,\n)$T \n"


T[2]->dewhite()

ns="123 456   789  ";

checkstr(T[2],"123456789")
checkstr(T[0],ns)

checkstr(T[0],"123 456   789  ")

<<"%(1,,,|>\n)$T \n"


T[4:6]->dewhite()

<<"%(1,<|,,|>\n)$T \n"

checkstr(T[4],"123456789")
checkstr(T[6],"123456789")

len=slen(T[8])
len2=slen(ns)
<<"%V$len $len2\n"
checkstr(T[8],ns)

<<"<|$T[8]|>\n"
<<"<|$ns|>\n"


k=scmp(T[8],ns)
<<"%V$len $len2 $k\n"


checkout()