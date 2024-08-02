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

///
///  this should test parsing of simple and  (very) complex expressions  
///  put this also in Bops RGT
//


#include "debug.asl"


  debugON()

  chkIn()

 do_declare = atoi(_argv[1])

  allowDB("rdp",1)

   x = 2.0

   y = 4.0


   z = (y -x) + 2.0


   ChkN(z, 4.0)

 if (do_declare) {
   float z0 = (y -x) + 2.0
}
else {
  z0 = (y -x) + 2.0
}

   ChkN(z0, 4.0)




   z = y -x/2.0


   ChkN(z, 3.0)

    z = (y -x)/2.0 + (y + (2*x))

   ChkN(z,9)

<<"%V $x $y $z\n"
 if (do_declare) {
    float z1 = (y -x)/2.0 + (y + (2*x))
 }
 else {
     z1 = (y -x)/2.0 + (y + (2*x))
  }
 
   ChkN(z1,9)

<<"%V $x $y $z1\n"
  

    z2 = (y -x)/2.0 + (y + (2*x))

   ChkN(z,9)

<<"%V $x $y $z2\n"

    z3 = ((y -x)/2.0 + (y + (2*(x+1))))

   ChkN(z3,11)

<<"%V $x $y $z3\n"

    z4 = ((y -x)/2.0 + (y + (2*(x-1))))

   ChkN(z4,7)

<<"%V $x $y $z4\n"


   float r =  (y -x)/2.0

   ChkN(r, 1.0)




  float LatS = 37.5;

  float LatN = 42.0;

  float LongW= 108.5;

  float LongE= 104.8;

//   float MidLong = (LongW - LongE)/2.0 + LongE;
   float MidLong;

  

  MidLong = (LongW - LongE)/2.0 + LongE;

<<"%V  $MidLong  $LongW - $LongE) \n"


  float MidLat = (LatN - LatS) /2.0 + LatS;

//<<"%V  $MidLat  $LatN- $LatS "    // tries $LatN-  as a name TBF 8/2/24

<<"%V  $MidLat  $LatN - $LatS "    // tries $LatN-  as a name TBF 8/2/24



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