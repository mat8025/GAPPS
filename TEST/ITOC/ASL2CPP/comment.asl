///
///
///


#include "debug"

debugON();

sdb(1,@pline,@trace)


   a= 2;
   b= 2;


//  this is a comment

   c=  a +b;

// <<"is this a comment? 1 should not be seen %V$c \n"

/*

  <<"is this a comment? 2 should not be seen %V$c \n"

*/


     <<" $c allow WS between << and \" \n";

  << " $c allow WS between << and \" \n";


/{/*

  <<"is this a comment 3 also %V $c\n"

/}*/

