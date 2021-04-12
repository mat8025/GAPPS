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
/*

substitute

substitutes string w3 into w1 for  first occurence of w2 returns the result.
substitute

/////
V->SubStitute(this_str,with_str)
 Substitutes a sub string with another  in the  string variable V 


*/

#include "debug"

if (_dblevel >0) {
   debugON()
}
chkIn(_dblevel)


svar  TS;
TS->info(1)

//TS= "123456789" ; // bug converts to STRV - instead of writing to svar field 0

TS[0] = "123456789";

TS->info(1)

for (i=1;i<=10;i++) {
TS[i] = TS[0]
<<"$i $TS[i]\n"
}


<<"%(1,,,\n)$TS \n"

TS->info(1)
TS[2]->Substitute("456","ABC")
TS->info(1)



<<"1 $TS[1]\n"
<<"2 $TS[2]\n"

for (i=0;i<=10;i++) {
<<"$i $TS[i]\n"
}


RS=TS[1]
<<"%V$RS\n"

chkStr(TS[1],"123456789")
chkStr(TS[2],"123ABC789")

<<"%(1,,,\n)$TS \n"




TS[4:6]->Substitute("789","DEF")

chkStr(TS[4],"123456DEF")
chkStr(TS[5],"123456DEF")
chkStr(TS[6],"123456DEF")
<<"5 $TS[5]\n"



TS[::]->Substitute("123","XYZ")


<<"////////////////////\n"
for (i=0;i<=10;i++) {
   chkStr(TS[i],"XYZ",3)
}
<<"%(1,,,\n)$TS \n"
<<"$(Cab(TS))\n"


TS[3]->Substitute("XYZ","AAA")

//TS[4]->Substitute("XYZ",BBB)  // use to check error flag in svarg
// error in args - skip function

TS[4]->Substitute("XYZ","BBB")


TS[5]->Substitute("XYZ","CCC")

chkStr(TS[3],"AAA",3)

<<"$(Cab(TS))\n"

TS[7] = "aaa123"

<<"%(1,,,\n)$TS \n"


!iTS
TS->Sort()

<<"%(1,,,\n)$TS \n"

chkStr(TS[0],"AAA",3)


//chkStage("substitute")
chkOut()
