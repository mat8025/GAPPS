

float X = 2
float Y = 2


proc foo()
{
int x = 1

   X++
   x++
<<"$_proc %V $X $x \n"



}

proc goo()
{
int x = 1

   Y++
   x++
<<"$_proc %V $Y $x \n"



}

proc moo()
{
int x = 1

   Y++
   x++
<<"$_proc %V $Y $x \n"
   foo()


}


  X++
<<"%V $X \n"

  foo()


<<"%V $X \n"

  foo()

<<"%V $X \n"
  k = 0
  j = 0
  m = 1
  while (j++ < 3) {

  while (k++ < 3) {


  if (m == 1) {

    foo()

<<"%V $j $k $X \n"
    m = 2
  }
  else if (m == 2) {

    moo()
    m = 3
  }
  else {

    goo()

    m  = 1

  }



  }
  <<" %V $j\n"
  k = 0
  }

stop!
;