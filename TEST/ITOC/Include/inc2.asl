
<<"including inc2 _scope \n"

<<"inc2 a global %V$X\n"

float Y = 2.2345;

<<"inc2 a global %V$Y\n"

proc goo( a,b)
{

 c= a*b;
<<"$_proc $a * $b = $c\n"
  return c;
}

include "inc3";

<<"included inc2 _scope \n"

