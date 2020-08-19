
setdebug(1)


 x = vgen(INT_,5,0,1)

<<"%V$x\n"
 x1 = x
 y = x

<<"%V$y \n"
 b = 2

 y2 =  b*x

<<"%V$x\n"
<<"%V$x1\n"
<<"%V$y2\n"

/{

 y1 =  x*b
<<"%V$y1\n"
<<"%V$x\n"
<<"%V$y2\n"

/}