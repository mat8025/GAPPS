/* 
 *  @script xor.asl                                                     
 * 
 *  @comment test && || etc ops                                         
 *  @release Boron                                                      
 *  @vers 1.3 Li Lithium [asl 5.95 : B Am]                              
 *  @date 04/01/2024 13:03:14                                           
 *  @cdate 1/1/2001                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


  myScript = getScript();
#define TRUE  1
#{

  x = TRUE;

  <<"%V $x  \n";
#}

  y = 1;

  <<"%V $y \n";
#include "debug"

  if (_dblevel >0) {

   debugON();

   }

  chkIn(_dblevel);

  a = 1;

  b = 0;

  if ( a && b) {

   <<"  && is true $a $b \n";

   }

  else {

   chkT(1);

   <<"  && is NOT true $a $b \n";

   }

  if ( a AND_ b) {

   <<"  AND is true $a $b \n";

   }

  else {

   chkT(1);

   <<"  AND is NOT true $a $b \n";

   }

  if ( a OR_ b) {

   chkT(1);

   <<"  OR is true $a $b \n";

   }

  else {

   <<"  OR is NOT true $a $b \n";

   }

  if ( a XOR_ b) {

   chkT(1);

   <<"  XOR is true $a $b \n";

   }

  else {

   <<"  XOR is NOT true $a $b \n";

   }

  if ( a &| b) {

   chkT(1);

   <<"  XOR is true $a $b \n";

   }

  else {

   <<"  &| XOR is NOT true $a $b \n";

   }

  if ( a NAND_ b) {

   chkT(1);

   <<"  NAND is true $a $b \n";

   }

  else {

   <<"  NAND is NOT true $a $b \n";

   }

  if ( a |& b) {

   chkT(1);

   <<"  |& NAND is true $a $b \n";

   }

  else {

   <<"  NAND is NOT true $a $b \n";

   }

  <<"   AND what do we make of this OR NOT \n";

  c = a * b;

  <<"%V $a $b $c \n";

  a =1;

  b = 1;

  if ( a XOR_ b) {

   <<"  XOR is true $a $b \n";

   }

  else {

   chkT(1);

   <<"  XOR is NOT true $a $b \n";

   }

  b = 0;

  if ( a XOR_ b) {

   chkT(1);

   <<"  XOR is true $a $b \n";

   }

  else {

   <<"  XOR is NOT true $a $b \n";

   }

  chkOut(1);
///  TBD
///  BXOR,BAND,  bit ops

//==============\_(^-^)_/==================//
