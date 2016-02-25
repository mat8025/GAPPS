

// +/+ quad

x = 1.0

y = 2.0

r1 = sqrt( x*x + y*y)

   q = atan(x/y)

<<"%V $q \n"

  // i= testargs(y, x)
  // i= testargs(x,y)

   r= atan2(y, x)

   d= r2d(r)

<<"%V $x $y $q $d $r \n"

   ra= atan2(y,x)

   d= r2d(ra)

   q = atan(y/x)

   ny = r1 * sin(ra) 

<<"Q1%V $x $y $ny $d $ra $q \n"


 y *= -1

   ra= atan2(y,x)
   q = atan(y/x)

   d= r2d(r)

   ny = r1 * sin(ra) 

<<"Q2%V $x $y $ny $d $ra $q \n"

 x *= -1

   ra= atan2(y,x)
   q = atan(y/x)

   d= r2d(ra)

   ny = r1 * sin(ra) 

<<"Q3%V $x $y $ny $d $ra $q \n"


 y *= -1

   ra= atan2(y,x)
   q = atan(y/x)
   d= r2d(ra)

   ny = r1 * sin(ra) 

<<"Q4%V $x $y $ny $d $ra $q \n"


x= 0
   r= atan2(y,x)
   d= r2d(r)

<<"%V $x $y  $d $r \n"

x= 1
y = 0
   r= atan2(y,x)
   d= r2d(r)

<<"%V $x $y  $d $r \n"

;


   r= atan2(y,x)
   d= r2d(r)

<<"%V $x $y  $d $r \n"
