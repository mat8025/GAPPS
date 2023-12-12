///
/// test/fix arg expression call of func or proc
///


#include "debug"

   if (_dblevel >0) {

     debugON();

     }


     x = sin(0.5);

<<"%V $x \n"

  chkN(x,0.479426,5)

  aslpinfo(x);

   y = 1.0;

     x2 = sin(y /2);

<<" $x2 $(y/2) \n"

     aslpinfo(x2);
     
chkN(x2,0.479426,EQ_,3)

chkN(x2,0.479426,EQ_,4)


   y = 0.5;


     x3 = sin(y);

<<" $x3 $(y) \n"

     aslpinfo(x3);
     
 chkN(x3,0.479426,EQ_,3);




  chkOut();
  