
#include "debug"

chkIn(_dblevel)

 x = vgen(INT_,5,0,1)

<<"%V$x\n"
 x1 = x
 y = x

<<"%V$y \n"
 b = 2


 y1 =  x*b
 y2 =  b*x

<<"%V$x\n"
<<"%V$x1\n"

chkVector(x1,x)

<<"%V$y1\n"
<<"%V$y2\n"

chkVector(y1,y2)



 y1 = x + b*x*x
 y2 = x + x*x*b

chkVector(y1,y2)

<<"%V$x\n"
<<"%V$y1\n"
<<"%V$y2\n"

 y1 = x + x*x + x*x*x
 y2 = x + x*x + x*x*x

chkVector(y1,y2)

<<"%V$y1\n"
<<"%V$y2\n"



 y1 = x + x*x*b + x*x*x +x*x*x*x
<<"%V$x\n"
<<"%V$y\n"

 y2 = x + b*x*x + x*x*x +x*x*x*x
<<"%V$x\n"
<<"%V$y1\n"
<<"%V$y2\n"

// need vector check
chkVector(y1,y2)

 c= 3

 y1 = x + b*x*x + c*x*x*x
 y2 = x + x*x*b + x*x*x*c

<<"%V$y1\n"
<<"%V$y2\n"

chkVector(y1,y2)




chkOut()