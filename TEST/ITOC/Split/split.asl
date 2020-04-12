//%*********************************************** 
//*  @script split.asl 
//* 
//*  @comment test split SF 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Fri Apr  3 19:37:19 2020 
//*  @cdate Fri Apr  3 19:37:19 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

#define NULL ""
setdebug(1,@keep);

checkIn(0)

A= split("once upon a time")


checkStr(A[0],"once")
checkStr(A[1],"upon")
checkStr(A[2],"a")
checkStr(A[3],"time")

// use

A= split("ONCE,UPON,A,TIME",",")

checkStr(A[0],"ONCE")
checkStr(A[1],"UPON")
checkStr(A[2],"A")
checkStr(A[3],"TIME")

sz=Caz(A)
<<"$sz\n"
<<" %(1,,,\n)$A\n"

B= split("4.0,7.3",",")

sz=Caz(B)
<<"$sz\n"

<<"%(1,,,\n)$B\n"

C= split("4.0 8.0",",")

sz=Caz(C)
<<"$sz\n"
<<"%(1,,,\n)$C\n"
if (C[0] @= "") {
<<"no tokens!\n"
}

if (C[0] @= NULL_) {
<<"no tokens!\n"
}





D= split("",",")

sz=Caz(D)
<<"$sz\n"
<<"[0] $D[0]\n"
if (D[0] @= "") {
<<"no tokens!\n"
}



<<"%(1,,,\n)$D\n"

if (D[0] @= NULL_) {
<<"no D tokens!\n"
}

if (D[0] @= NULL) {
<<"no D tokens!\n"
}

E= split('int a, int b',",")

sz=Caz(E)
<<"$sz\n"
<<"[0] $E[0]\n"

if (E[0] @= "") {
<<"no tokens!\n"
}

if (E[1] @= "") {
<<"one token!\n"
}
<<"%(1,,,\n)$E\n"


args = "int A, int B"

E= split(args,",")

sz=Caz(E)
<<"$sz\n"
<<"[0] $E[0]\n"

if (E[0] @= "") {
<<"no tokens!\n"
}

if (E[1] @= "") {
<<"one token!\n"
}
<<"%(1,,,\n)$E\n"



checkOut()



