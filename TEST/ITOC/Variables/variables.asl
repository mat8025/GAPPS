///
/// Variables
///

/{/*

  Variables (fn, [type,values])

/}*/

checkIn()
int i = 1;

float f = 3.14159;

I=vgen(INT_,10,10,-1);

C=vgen(CHAR_,10,10,-1);

pan p = 1.23456789;

 S=Variables(0)
checkStr(S[0],"C, CHAR, 10")
checkStr(S[5],"p, PAN, 1")
<<"%(1,,,\n)$S\n"

 S=Variables(1)
<<"////\n"
<<"%(1,,,\n)$S\n"
checkOut()