setdebug(1)

 xs = 2.0

 ys = xs

<<"%V$ys\n"

 ys2 = xs * xs

<<"%V$ys2\n"

 ys3 = xs * xs * xs

<<"%V$ys3\n"

 ys4 = xs * xs * xs *xs

<<"%V$ys4\n"



 x = vgen(INT_,5,2,1)
 u = vgen(INT_,5,3,1)
 w = vgen(INT_,5,4,1)

<<"%V$x\n"
<<"%V$u\n"
<<"%V$w\n"


 y = x
 xc = x

 v = x
<<"%V$y \n"

 y2 = x * u




<<"%V$y2 \n"


 if (y2[1] != 12) {
<<" VV_mul ERROR $y2[1] != 12\n"
 }


<<"y2 mul by %V$w\n"


 y3 = x * u * w

<<"%V$y3 \n"


 if (y3[1] != 60) {
<<" VV_mul ERROR $y3[1] != 60\n"
 }
 
 exitSi()


 y3c = (u * v) * w

<<"%V$y3c \n"


 y4 = x * x * x * x

<<"%V$y4 \n"
<<"%V$x\n"
<<"%V$xc\n"

 y4n = (x * x) * (x * x)

<<"%V$y4n \n"



stop!