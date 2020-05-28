///
/// Variables
///


/{/*

  Variables (fn, [type,values])

/}*/

#define OAL (2,-->,,\n)

setdebug(1,@~step,@~pline)
checkIn()

pan p = 1.23456789;

<<" $(vinfo(p)) \n"

pan P[10];

   P[0] = 80;
   

int i = 1;

float f = 3.14159;

I=vgen(INT_,10,10,-1);

C=vgen(CHAR_,10,10,-1);

double D[];

D[3]= atan(1) * 4;

<<"$D\n"

<<" $(vinfo(p)) \n"

 T= vinfo(&p,P,C,I,&f);

<<"%(1,,,\n)$T\n"

<<"/////////////////\n"

<<" %$OAL \n"

//<<"$(OAL) $T\n"

<<"/////////////////\n"

 S=Variables(0);

<<"%(1,,,\n)$S\n"

checkStr(S[0],"C, CHAR, 10")


//checkStr(S[6],"p, PAN, 0")

<<"%(1,,,\n)$S\n"

 S=Variables(1)

<<"////\n"
<<"%(1,,,\n)$S\n"

 T= vinfo(&p,P,C,D,I,&f);

<<"%(1,,,\n)$T\n"

checkOut()