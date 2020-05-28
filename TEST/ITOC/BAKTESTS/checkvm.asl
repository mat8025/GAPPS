

proc Wrong()
{

// print out last 10 lines
 setdebug(1,"steponerror")

}
////////////////////////

 checkIn()

 x = vgen(DOUBLE,5,0,1)

<<"%V$x\n"

//double y[5]
<<"%V$x\n"
 y = x

<<"%V$y $x\n"

 if (checkNum(y[1], 1)) {
   <<" correct!\n"  
 }
 else {
    Wrong()
 }

<<"%V$x\n"
 y = x + x*x

<<"%V$y\n"

 if (checkNum(y[1], 2)) {
   <<" correct!\n"  
 }
 else {
   <<" wrong!\n"  
 }

 a = 2

<<"%V$x\n"
 y = x + x*x + x*x*x

<<"%V$y\n"

 if (checkNum(y[1], 3)) {
   <<" correct!\n"  
 }
 else {
   <<" wrong!\n"  
 }

 if (checkNum(y[2], 14)) {
   <<" correct!\n"  
 }
 else {
   <<" wrong!\n"  
 }

<<"%V$x\n"
 y = x + x*x + x*x*x +x*x*x*x

<<"%V$y\n"

 if (checkNum(y[1], 4)) {
   <<" correct!\n"  
 }
 else {
   <<" wrong!\n"  
 }

 b = 2.0

<<"%V$x\n"

 y = x + x*x*b + x*x*x +x*x*x*x

<<"%V$y\n"

 if (checkNum(y[2], 34)) {
     <<" correct!\n"  
 }
 else {
     Wrong()
 }

<<"%V$x\n"

 y = x + x*x*b + x*x*x +x*x*x*x

<<"%V$y\n"

<<"%V$x\n"


 if (checkNum(y[2], 34)) {
   <<" correct!\n"  
 }
 else {
   <<" wrong!\n"  
 }

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

<<"%V$a $b $c $d \n"

 if (checkFNum(y[2], 50,3)) {
  <<" correct!\n"  
 }
 else {
   Wrong() 
 }



 d = 5

y = x + x*x*b + x*x*x*c + x*x*x*x*d


<<"%V$y\n"

 if (checkNum(y[2], 114)) {
  <<" correct!\n"  
 }
 else {
  <<" wrong!\n"  
 }

<<"%V$x\n"

// y = a*x + b*x*x + c*x*x*x +d*x*x*x*x
 y = x*a + x*x*b + x*x*x*c +x*x*x*x*d

<<"%V$y\n"


 if (checkNum(y[2], 116)) {
   <<" correct!\n"  
 }
 else {
   Wrong()  
 }


 C = 7

// y = a*x + b*x*x + c*x*x*x +d*x*x*x*x + C
y = x*a + x*x*b + x*x*x*c +x*x*x*x*d +C
<<"%V$y\n"


 if (checkNum(y[2], 123)) {
  <<" correct!\n"  
 }
 else {
   Wrong() 
 }

<<"$x \n"



 CheckOut()



stop!