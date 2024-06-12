//%*********************************************** 
//*  @script parse_exp.asl
//* 
//*  @comment   (a >=3 || b == 2)
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%//

include "debug.asl"

debugON()

chkIn()
///
/// 
///
sdb(1,@~trace)

  a= 2
  b= 2
  c= 3

  d= a + b * c

<<"$d = 8?\n"

  e= a || b ==2

  chkT(b ==2)

<<"$e = 1?\n"
  chkT(e)
  e= a || (b ==2)

<<"$e = 1?\n"
  chkT(e)



  if (a >=1) {
<<"$a >= 1\n"
  }


  if (a >=1 || b == 2) {
<<"$a >= 1 || $b == 2\n"
   chkT(1)
  }
  else {
<<"XXX - should not see!\n"
   chkT(0)
  }


  if (a >=3 || b == 2) {
<<"$a >= 1 || $b == 2\n"
   chkT(1)
  }
  else {
<<"XXX - should not see!\n"
   chkT(0)
  }


  if (a >=3 || b != 3) {
<<"$a >= 1 || $b != 3\n"
   chkT(1)
  }
  else {
<<"XXX - should not see!\n"
   chkT(0)
  }

  if ((a >=3) || (b == 2)) {
<<"($a >= 1) || ($b == 2)\n"
   chkT(1)
  }



  if ((a >=1) && (b == 2)) {
<<"($a >= 1) && ($b == 2)\n"
   chkT(1)
  }


  if (a >=1 && b == 2) {
<<"$a >= 1 && $b == 2\n"
   chkT(1)
  }
  else {
<<"XXX $a >= 1 && $b == 2\n"
  chkT(0)
  }


  if ( 2 * 3 >= 4 * 1) {

<<" 2 * 3 >= 4 * 1 \n"
  }
  else {

<<"XXX 2 * 3 >= 4 * 1 \n"
  }



  if ( 7 * 3 <  6 * 2) {

<<"XXX 7 * 3 <  6 * 2\n"

  }
  else {
  
<<"Y 7 * 3 <  6 * 2\n"
  }

a=7
b=3
c= 6
d=2

  if ( a * b <  c * d) {

<<"XXX  $a * $b <  $c * $d \n"

  }
  else {

<<"Y $a * $b <  $c * $d \n"
  }


  if (( a * b) <  (c * d)) {

<<"XXX  $a * $b <  $c * $d \n"

  }
  else {

<<"Y $a * $b <  $c * $d \n"
  }




chkOut()

exit()