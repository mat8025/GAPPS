//%*********************************************** 
//*  @script vmf.asl 
//* 
//*  @comment test vmf - var member function 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sat Apr 11 23:11:04 2020 
//*  @cdate Sat Apr 11 23:11:04 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_");

setdebug(1,@pline,@trace)


// test cut array

CheckIn()

int I[] ;

I= Igen(20,0,1)

<<" $I \n"

 I[14]->Set(747)

<<" $I\n"

I[5:13:2]->Set(50,1)

<<"$I \n"

C = Igen(4,12,1)

<<" $C \n"

I->cut(C)



<<" $I \n"

CheckNum(I[12],16)


checkStage("cut")

float F[]

F= Fgen(20,0,1)

sz = Caz(F)
<<"$sz $F \n"
//<<"%,j%{5<,\,>\n}%6.1f$F\n"

<<"%6.1f $F\n"

C = Igen(4,12,1)

<<"%V $C \n"

F->cut(C)


<<"%6.1f  $F \n"
CheckFNum(I[12],16,6)


<<" $I[::] \n"

I[3:8]->cut()

<<" $I[::] \n"
CheckNum(I[3],52)

F[3:8]->cut()

<<" %6.1f $F[::] \n"
CheckFNum(F[3],9,6)

F[3]->cut()

<<" %6.1f $F[::] \n"

F[3]->obid()

id = F[3]->obid()

<<" $id \n"
checkStage("obid")

//=============================//

/{/*
Dewhite(S)
Dewhites a string variable (or array of strings)
S->Dewhite() - dewhites a string
S[a:b]->Dewhite()
would dewhite a range of an array of strings - where S is an array 
/}*/



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

checkStage("dewhite")

//===========================//
//%*********************************************** 
//*  @script rotate.asl 
//* 
//*  @comment test rotate vector 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//*
//***********************************************%

/{/*
 rotate

rotate(vec, dir, nsteps)
or
Vec->rotate(dir,nsteps)

Vector is rotated in direction (1 forward , -1 backward) for nsteps

/////
/}*/




IV = vgen(INT_,20,0,1)

<<"$IV\n"

checkNum(IV[0],0)

IV->rotate(1,3)


<<"$IV\n"

checkNum(IV[0],17)

IV->rotate(-1,4)


<<"$IV\n"

checkNum(IV[0],1)

rotate(IV,1,5)

<<"$IV\n"

checkNum(IV[0],16)
checkStage("rotate")
//=================//
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



svar  TS = "123456789"

for (i=1;i<=10;i++) {
TS[i] = TS[0]
}


<<"%(1,,,\n)$TS \n"


TS[2]->Substitute("456","ABC")

checkstr(TS[1],"123456789")
checkstr(TS[2],"123ABC789")

<<"%(1,,,\n)$TS \n"

TS[4:6]->Substitute("789","DEF")

checkstr(TS[4],"123456DEF")
checkstr(TS[6],"123456DEF")

TS[::]->Substitute("123","XYZ")

for (i=0;i<=10;i++) {
checkstr(TS[i],"XYZ",3)
}
<<"%(1,,,\n)$TS \n"

TS[3]->Substitute("XYZ","AAA")

//TS[4]->Substitute("XYZ",BBB)  // use to check error flag in svarg
// error in args - skip function

TS[4]->Substitute("XYZ","BBB")


TS[5]->Substitute("XYZ","CCC")

TS->Sort()

<<"%(1,,,\n)$TS \n"
checkStr(TS[0],"AAA",3)


checkStage("substitute")
checkout()


checkStage("xxx")

