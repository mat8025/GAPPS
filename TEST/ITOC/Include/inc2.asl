
float z = 1.2345;
<<"a global %V$z\n"

proc goo( a,b)
{

 c= a*b;
<<"$_proc $a * $b = $c\n"
  return c;
}

include "inc3";

<<"included inc2 _scope \n"

