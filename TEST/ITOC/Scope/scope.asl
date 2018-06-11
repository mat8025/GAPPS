///
///   Scope -- local and Global refs inside of procs
///

setdebug(1,@keep,@~trace)

proc soo()
{
 int x = 1;
 x++;
 X++; // applies to global X
<<"$_proc %V $x $X $Y\n"
}
//==========================


proc goo()
{
int x = 1;
int X = 5; // local declaration hides global X

   Y++;
   x++;

   X++;  // applies to local X
   
<<"$_proc %V $x  $X $Y\n"
}
//==========================


proc moo()
{
int x = 1;
int X = 7; // local declaration hides global X
   X++; // applies to local X
   x++;

   ::X++; // scope :: operator allows access to global X

<<"$_proc %V $x $X $Y $::X \n"
}
//========================


float X = 2;
float Y = 4;

checkIn();

<<"%V $X $Y\n"

checkNum(X,2);

checkNum(Y,4);

 soo()

 checkNum(X,3)

<<"%V $X $Y\n"


 goo();

 checkNum(X,3)

 checkNum(Y,5)

<<"%V $X $Y\n"



 moo();

checkNum(X,4)

<<"%V $X $Y\n"




  k = 0
  j = 0
  m = 1

 while (j++ < 3) {

  while (k++ < 3) {


  if (m == 1) {

    foo()

<<"%V $j $k $X \n"
    m = 2
  }
  else if (m == 2) {

    moo()
    m = 3
  }
  else {

    goo()

    m  = 1

  }



  }
  <<" %V $j\n"
  k = 0
  }

checkOut()
