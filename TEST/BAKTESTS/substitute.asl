//%*********************************************** 
//*  @script substitute.asl 
//* 
//*  @comment test substitute func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
/{/*

substitute

substitutes string w3 into w1 for  first occurence of w2 returns the result.
substitute

/////
V->SubStitute(this_str,with_str)
 Substitutes a sub string with another  in the  string variable V 


/}*/

 include "debug.asl";

  debugON();
  setdebug(1,@keep,@pline,@trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);


checkin()


svar  T = "123456789"

for (i=1;i<=10;i++) {
T[i] = T[0]
}


<<"%(1,,,\n)$T \n"


T[2]->Substitute("456","ABC")

checkstr(T[1],"123456789")
checkstr(T[2],"123ABC789")

<<"%(1,,,\n)$T \n"

T[4:6]->Substitute("789","DEF")

checkstr(T[4],"123456DEF")
checkstr(T[6],"123456DEF")

T[::]->Substitute("123","XYZ")

for (i=0;i<=10;i++) {
checkstr(T[i],"XYZ",3)
}
<<"%(1,,,\n)$T \n"

T[3]->Substitute("XYZ","AAA")

//T[4]->Substitute("XYZ",BBB)  // use to check error flag in svarg
// error in args - skip function

T[4]->Substitute("XYZ","BBB")


T[5]->Substitute("XYZ","CCC")




T->Sort()

<<"%(1,,,\n)$T \n"
checkStr(T[0],"AAA",3)

checkout()