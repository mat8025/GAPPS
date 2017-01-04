
// inc3
<<"start including  inc3\n"

<<"inc3 a global %V$X\n"
<<"inc3 a global %V$Y\n"


float Z = 3.2345;

<<"inc3 a global %V$Z\n"

proc hoo( a,b)
{

 c= a/b;
<<"$_proc $a / $b = $c\n"
  return c;
}



<<"included inc3 _scope \n"