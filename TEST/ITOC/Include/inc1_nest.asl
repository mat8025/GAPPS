//////////////

<<"start including  nest \n"

#define C_YELLOW 6

<<"$_include sees global %V$A\n"

float X = 1.2345;
<<"$_include adds global %V$X\n"


proc foo( a,b)
{
   c= a+b;
<<"$_proc $a + $b = $c\n"
  return c;
}

//include "inc3"

proc boo( a,b)
{
   c= a-b;
<<"$_proc $a - $b = $c\n"
  return c;
}


include "inc2" ; // nested include

<<"inc2 added global %V$Y\n"

<<"included $_include \n"

