//%*********************************************** 
//*  @script logic_ops.asl 
//* 
//*  @comment  test && || etc ops 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.50 C-He-Sn]                                
//*  @date Sat May 23 15:31:12 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();

#define TRUE  1


#{
 x = TRUE
<<"%V $x  \n"
#}



y = 1
<<"%V $y \n"

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)


 a = 1
 b = 0



 if ( a && b) {

  <<"  && is true $a $b \n"

 }
 else {

  chkT(1)
  <<"  && is NOT true $a $b \n"

 }


 if ( a AND_ b) {

  <<"  AND is true $a $b \n"

 }
 else {
  chkT(1)
  <<"  AND is NOT true $a $b \n"

 }


 if ( a OR_ b) {
  chkT(1)
  <<"  OR is true $a $b \n"

 }
 else {

  <<"  OR is NOT true $a $b \n"

 }

 if ( a XOR_ b) {
  chkT(1)
  <<"  XOR is true $a $b \n"
 }
 else {

  <<"  XOR is NOT true $a $b \n"

 }

  if ( a &| b) {
  chkT(1)
  <<"  XOR is true $a $b \n"
 }
 else {

  <<"  &| XOR is NOT true $a $b \n"

 }

 if ( a NAND_ b) {
  chkT(1)
  <<"  NAND is true $a $b \n"

 }
 else {
  <<"  NAND is NOT true $a $b \n"
 }

 if ( a |& b) {
  chkT(1)
  <<"  |& NAND is true $a $b \n"

 }
 else {
  <<"  NAND is NOT true $a $b \n"
 }



<<"   AND what do we make of this OR NOT \n"

 c = a * b 

<<"%V $a $b $c \n"


chkOut()


///  TBD
///  BXOR,BAND,  bit ops