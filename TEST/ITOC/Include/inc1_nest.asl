//////////////

<<"start including  nest\n"

#define C_YELLOW 6


float X = 1.2345;

<<"inc1 a global %V$X\n"

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

<<"included nest \n"

