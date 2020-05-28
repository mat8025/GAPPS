// test static statement


#include "debug.asl"
debugON()

checkIn()

proc  foo ( x)
{
  static int a = 0;

<<" entered $_proc %V$a $A\n"

     a++;
     A++;
     
<<"exiting $_proc %V$a $A\n"
    checkNum(a,A)
}

int A =0;


foo()

checkNum(A,1)


foo()

checkNum(A,2)


foo()

checkNum(A,3)


foo()

checkNum(A,4)


checkOut()