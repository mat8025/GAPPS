////    test include statement
int n = 0 
//float y
setdebug(1,"pline")
<<" before include\n"

//include "alib/inc1";

include "inc1";

include "inc2";

// inc2 includes inc3

include "inc3";


checkin();


<<" after checkin\n"

#define C_BLUE 7

b = C_BLUE
c = C_YELLOW
<<"$b $c\n"

<<"%V$y \n"

/// FIX XIC 

arg0 = _clarg[0]
<<"%V $arg0\n"

<<"See me?\n"

arg1 = _clarg[1]
<<"%V $arg1\n"

arg2 = _clarg[2]
<<"%V $arg2\n"


 s=foo(2,3)

<<"%V$s\n"
 checkNum(s,5)
 t=goo(4,5)
 checkNum(t,20)
<<"%V$t\n"


 h=hoo(21,7)
 <<"%V$h\n"

  checkNumber(h,3)

checkOut()


exit()



/{/*
include "$_clarg[1]"


<<"%V$busy \n"

<<"$H[0:2] \n"
<<"here \n"
<<" $H \n"
<<"there \n"

int M[3][4] 

M[0][1] = 47

M[2][3] = 79

<<"$M \n"
<<"everywhere \n"

<<"%(4,<-\s,\,,->\n)$M \n"
<<"everywhere \n"
bd=Cab(M)
<<"%V$bd\n"

<<"%($bd[1],<-\s,\,,->\n)$M \n"
/}*/


<<"and more \n"