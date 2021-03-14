/* 
 *  @script scope.asl 
 * 
 *  @comment test scope main, proc 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.30 C-Li-Zn]                                
 *  @date 03/13/2021 22:09:15 
 *  @cdate 1/1/2004 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */
 
///
///   Scope -- local and Global refs inside of procs
///

#include "debug"


if (_dblevel >0) {
   debugON()
}


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

chkIn();

<<"%V $X $Y\n"

chkN(X,2);

chkN(Y,4);

 soo()

 chkN(X,3)

<<"%V $X $Y\n"


 goo();

 chkN(X,3)

 chkN(Y,5)

<<"%V $X $Y\n"


 moo();

chkN(X,4)

<<"%V $X $Y\n"




  k = 0
  j = 0
  m = 1

 while (j++ < 3) {

  while (k++ < 3) {


  if (m == 1) {

    soo()

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

chkOut()
