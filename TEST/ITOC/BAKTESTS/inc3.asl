
// inc3
<<"start including  inc3\n"

<<"inc3 sees globals %V $A $X $Y\n"

 #define C_YELLOW 6
float Z = 3.2345;

<<"inc3 adds global %V$Z\n"

proc hoo( a,b)
{

 c= a/b;
<<"$_proc $a / $b = $c\n"
  return c;
}



<<"included $_include  _scope \n"

include "inc3";

<<"ignored repeated include\n"