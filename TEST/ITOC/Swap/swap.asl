//  demo ptr/ref args
//

checkIn()

setdebug(1,"pline","~step")

proc swap ( x, y)
{
  t = 0

<<"$_proc IN : %V$x $y $t\n"

  t = x;
<<"%V$t\n"
  x = y;
 <<"%V$x $y\n"
  y = t;
 <<"%V$y $t\n"

<<" OUT: %V$x $y $t\n"

}


 int k = 4
 int m = 3

 int ans = 0

// swap (1,2)


<<"%V$k $m  ref\n"
 swap (&k, &m)
<<" %V$k $m \n"

 CheckNum(k,3)

<<"%V$k $m  value\n"
 swap (k, m)
<<" %V$k $m \n"

 CheckNum(k,3)




<<"%V$k $m  ref\n"
 swap (&k, &m)
<<" %V$k $m \n"

 CheckNum(k,4)

<<"%V$k $m  value\n"

 swap (k, m)

<<" NO SWAP %V$k $m \n"

 CheckNum(k,4)

<<"%V$k $m  ref\n"
 swap (&k, &m)
<<" %V$k $m \n"

 CheckNum(k,3)


<<"%V$k $m  ref\n"
 swap (&k, &m)
<<" %V$k $m \n"

 CheckNum(k,4)


<<"%V$k $m  value\n"
 swap (k, m)
<<" %V$k $m \n"

 CheckNum(k,4)

<<"%V$k $m  ref\n"
 swap (&k, &m)
<<" %V$k $m \n"


 CheckNum(k,3)


<<" via main \n"

<<"%V$k $m $w\n"






 int w = 0

// a swap
 w = m
 m = k
 k = w

<<"%V $k $m $w\n"

 CheckNum(m,3)

int a = 6
int b = 9

<<" via proc \n"
<<"%V $a $b \n"

 swap(&a,&b)

 CheckNum(a,9)

<<"%V$a $b \n"


a = 7
b = 11

for (g = 0; g < 4; g++) {
  swap(&a,&b)
 <<"%V$g $a $b \n"
}

 CheckNum(a,7)

<<" diff vars %V$k $m\n"

for (g = 0; g < 3; g++) {

  swap(&k,&m)

<<"%V$g $k $m \n"

}



<<" orig vars %V$a $b\n"

for (g = 0; g < 3; g++) {

 swap(&a,&b)

<<"%V$g $a $b \n"
}


 CheckNum(a,11)

float r = 3.0
float q = 4.0

 CheckNum(r,3.0)

<<"%V $r $q\n"

   swap(&r,&q)

 CheckNum(r,4.0)


<<"%V $r $q\n"

   swap(&r,&q)

 CheckNum(r,3.0)

<<"%V $r $q\n"

 CheckOut()

stop!
