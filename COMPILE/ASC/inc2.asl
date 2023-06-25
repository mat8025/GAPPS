///
/// inc2.asl
///


 //  can be declarations of variables

  A_inc2 = 36 

  B_inc2 =  77.66


//  procedures
/*
 int add_inc2 (int m, int n)
 {
 int am;
      am = m +n

 <<" $am = $m + $n \n"
      return am;

 }
*/
 s_inc2 = "str created in inc2"

// try nested include
#include "inc3.asl"


<<" after nested inc3 \n"

<<" Done inc2.asl \n"

///
/// end  inc2.asl
///