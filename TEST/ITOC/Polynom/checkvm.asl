

proc Wrong()
{

// print out last 10 lines
<<"ERROR \n"
 //sdb(1,"steponerror")

}
////////////////////////

 chkIn(_dblevel)

 x = vgen(DOUBLE_,5,0,1)

<<"%V$x\n"

 y = x

<<"%V$x\n"

<<"%V$y \n"

 chkN(y[1], 1)


<<"%V$x\n"

 y = x + x*x

<<"%V$y\n"

 chkN(y[1], 2)

chkOut ()
 a = 2

<<"%V$x\n"
 y = x + x*x + x*x*x

<<"%V$y\n"

 if (chkN(y[1], 3)) {
   <<" correct!\n"  
 }
 else {
   <<" wrong!\n"  
 }

 if (chkN(y[2], 14)) {
   <<" correct!\n"  
 }


<<"%V$x\n"
 y = x + x*x + x*x*x +x*x*x*x

<<"%V$y\n"

 if (chkN(y[1], 4)) {
   <<" correct!\n"  
 }


 b = 2.0

<<"%V$x\n"

 y = x + x*x*b + x*x*x +x*x*x*x

<<"%V$y\n"

 chkN(y[2], 34)
 


<<"%V$x\n"

 y = x + x*x*b + x*x*x +x*x*x*x

<<"%V$y\n"

<<"%V$x\n"


 chkN(y[2], 34)

 c= 3.0

 t = (x*x)*(x*x)

<<"%V$t\n"

<<"%V$x\n"

 y2 =  x*x

<<"%V$x\n"
<<"%V$y2 \n"
  x1 = x
  x2 = x

 y3 =  x * x1 * x2


<<"%V$y3 \n"


 y3 = ( x * x1) * x2


<<"%V$y3 \n"


 y3 = (x * x) * x


<<"%V$y3 \n"




 y = x + (x*x)*b + (x*x)*(x*c) +(x*x)*(x*x)

<<"%V$x\n"

<<"%V8.0f$y\n"

<<"%V$y[2]\n"

 d = 5
<<"%V $d\n"

<<"%V$a $b $c $d \n"

 chkR(y[2], 50,3)








 y = x + x*x*b + x*x*x*c + x*x*x*x*d


<<"%V$y\n"

 chkN(y[2], 114)


<<"%V$x\n"

// y = a*x + b*x*x + c*x*x*x +d*x*x*x*x
 y = x*a + x*x*b + x*x*x*c +x*x*x*x*d

<<"%V$y\n"


 chkN(y[2], 116)

 C = 7

// y = a*x + b*x*x + c*x*x*x +d*x*x*x*x + C
y = x*a + x*x*b + x*x*x*c +x*x*x*x*d +C
<<"%V$y\n"


 chkN(y[2], 123)



<<"$x \n"



 chkOut ()
