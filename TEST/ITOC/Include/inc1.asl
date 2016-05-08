//////////////

#define C_YELLOW 6


float y = 1.2345
<<"a global %V$y\n"

proc foo( a,b)
{

   c= a+b;

  return c;
}

//include "inc3"

proc boo( a,b)
{

   c= a-b;

  return c;
}


include "inc2" ; // nested include

<<"included inc1 _scope \n"

