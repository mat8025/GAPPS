
<<"including $_include _scope \n"

<<"inc2 sees globals %V $A $X\n"

float Y = 2.2345;

<<"inc2 adds global %V$Y\n"

proc goo(int a, int b)
{

 c= a*b;
<<"$_proc $a * $b = $c\n"
  return c;
}

include "inc3";

<<"included $_include _scope \n"

