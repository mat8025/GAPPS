//  demo ptr/ref args
//

checkIn()

setdebug(1)

proc swap ( x, y)
{
  t = 0
<<"$_proc %V$x $y $t\n"
  t = x
  x = y
  y = t
<<"out %V$x $y $t\n"
}


 int k = 4
 int m = 3
 int w = 0

<<"$V$k $m \n"

 swap (&k, &m)

<<"swapped $V$k $m \n"

 CheckNum(k,3)

 swap (k, m)

<<"as b4 $V$k $m \n"

 CheckNum(k,3)

 swap (&k, &m)

<<"swapped $V$k $m \n"

 CheckNum(k,4)



<<" via main \n"
<<"%V$k $m $w\n"

// a swap
 w = m
 m = k
 k = w

<<"%V $k $m $w\n"

 CheckNum(k,3)

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


 CheckNum(a,11)

<<" diff vars %V$k $m\n"

checkOut()
stop()

for (g = 0; g < 3; g++) {

  swap(&k,&m)

<<"%V $k $m \n"

}

 CheckNum(k,4)

<<" orig vars %V$a $b\n"

for (g = 0; g < 3; g++) {

 swap(&a,&b)

<<"%V$g $a $b \n"
}


//<<"%V $x $y $t \n"

 CheckNum(a,9)

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

  swap(&k,&m)

<<"%V $k $m $w\n"

 CheckNum(k,3)

 CheckOut()

stop!
