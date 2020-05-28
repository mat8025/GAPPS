


////

 include "debug.asl"; 
  
  debugON();


proc foo( m)
{

  int rooms = m;

  return rooms;


}



 nr = foo(6)

<<"%V $nr \n"