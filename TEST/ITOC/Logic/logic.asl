//%*********************************************** 
//*  @script logic.asl 
//* 
//*  @comment test logic ops 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.50 C-He-Sn]                               
//*  @date Sat May 23 15:08:41 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
   
<|Use_=
Demo  of logic ops
///////////////////////
|>


#include "debug.asl";



if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}

   
   chkIn(); 
   
   
   int a = 1;
   int b = 1;

<<"%V $a $b \n"

   if (a == b) {

   chkT(1)
   

   }

   if (a != b) {

    chkT(0)

   }

b = 2;

   if (a == b) {

   chkT(0)
   

   }

   if (a != b) {

    chkT(1)

   }

   


   int Goo()
   {
     
     plop = 0; 
     
     if (a > 0 ) {
       <<" ($a > 0)  \n"; 
       plop = 1; 
       }
     else {
       <<" NOT ($a > 0 ) \n"; 
       }
     
     
     chkT(plop); 
     
     return plop; 
     
     
     }
   
//==========================//
   
   int Goo2()
   {
     plop = 0;
     
     int a = 2;
     int b = 3;
     <<"%V $a $b \n"; 
     if ((a > 0) && (b > 2))
       {
       <<" ($a > 0 && $b > 2) \n"; 
       plop = 1;
       }
     else {
       <<" NOT ($a > 0 && $b > 2) \n";
       }
     
     
     chkT(plop); 
     
     return plop; 
   }
   
//EP==========================//
   
   
   lop = 0; 
   
   if (a > 0 ) {
     <<" ($a > 0)  \n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($a > 0 ) \n"; 
     }
   
   
   chkT(lop); 
   
///////////////////////////////////////////////
   lop = 0; 
   
   if ((a > 0) && (b > 2)) {
     <<" ($a > 0 && $b > 2) \n"; 
     
     }
   else {
     <<" NOT ($a > 0 && $b > 2) \n"; 
     lop = 1; 
     }
   
   
   chkT(lop); 
   
///////////////////////////////////////////////////////
   
///////////////////////////////////////////////
   lop = 0; 
   
   if (!((a > 0) && (b > 2))) {
     <<" !(($a > 0 && $b > 2)) \n"; 
     lop = 1; 
     }
   else {
     <<" NOT !(($a > 0 && $b > 2)) \n"; 
     
     }
   
   
   chkT(lop); 
   
///////////////////////////////////////////////////////
   
   
   lop = 0; 
   
   if ((a > 0) && (b > 1)) {
     <<" ($a > 0 && $b > 1) \n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($a > 0 && $b > 1) \n"; 
     }
   
   
   chkT(lop); 
   
///////////////////////////////////////////
   lop = 0; 
   
   if ( (b > 2) || (a > 0) ) {
     <<" ($b > 2 || $a > 0) \n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($b > 2 || $a > 0) \n"; 
     }
   
   
   chkT(lop); 
   
/////////////////////////////////////////
   
   
   lop = 0; 
   
   if ( (a > 0) && (b > 1)) {
     <<" ($a > 0 && $b > 1) \n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($a > 0 && $b > 1) \n"; 
     }
   
   
   chkT(lop); 
   
   a = 0; 
   b = 0; 
   
   if (( a == 0) || (b > 1)) {
     <<" ($a ==  0 || $b > 1) \n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($a == 0 || $b > 1) \n"; 
     }
   
   chkT(lop); 
   a =1; 
   b = 2; 
   if ( (a == 0) || (b > 1)) {
     <<" ($a ==  0 || $b > 1) \n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($a == 0 || $b > 1) \n"; 
     }
   
   chkT(lop); 
   
   
   b = 0; 
   if ( (a == 0) || (b > 1)) {
     <<" ($a ==  0 || $b > 1) \n"; 
     
     }
   else {
     <<" NOT ($a == 0 || $b > 1) \n"; 
     lop = 1; 
     }
   
   
   chkT(lop); 
   
///////////////////////////////////
   
   a = 1; 
   b = 2; 
   c = 3; 
   
   lop = 0; 
   
   if ( (a == 1) && (b > 1) && (c == 3)) {
     <<" ($a == 1) && ($b > 1) && ($c == 3) \n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($a == 1) && ($b > 1) && ($c == 3)) \n"; 
     }
   
   <<"%V $a $b $c\n"
   chkT(lop);



////////////////////////////////////////////////////
   lop = 0; 
   
   if ( (a == 0) || (b > 3) || (c == 3)) {
     <<" ($a == 0) || ($b > 3) || ($c == 3) \n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($a == 0) || ($b > 3) || ($c == 3)) \n"; 
     }
   
   chkT(lop); 
//////////////////////////////////////////////////////
   
   d = 4; 
   lop = 0; 
   if ( (a == 1) && (b > 1) && (c == 3) && (d == 4)) {
     <<" ($a == 1) && ($b > 1) && ($c == 3) && (d == 4)\n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($a == 1) && ($b > 1) && ($c == 3) && ( d == 4)) \n"; 
     }
   chkT(lop); 
   
   
///////////////////////////////////
   d = 3; 
   lop = 0; 
   if ( (a == 1) && (b > 1) && (c == 3) && (d == 4)) {
     <<" ($a == 1) && ($b > 1) && ($c == 3) && ($d == 4)\n"; 
     
     }
   else {
     <<" NOT ($a == 1) && ($b > 1) && ($c == 3) && ( $d == 4)) \n"; 
     lop = 1; 
     }
   chkT(lop); 
   
   
///////////////////////////////////
   
   d = 3; 
   lop = 0; 
   if ( (a == 0) || (b > 8) || (c == 1) || (d == 3)) {
     <<" ($a == 0) || ($b > 8) || ($c == 1) || ($d == 3) \n"; 
     lop = 1; 
     }
   else {
     <<" NOT ($a == 0) || ($b > 8) || ($c == 1) || ($d == 3) \n"; 
     }
   
   chkT(lop); 
   
   
///////////////////////////////////
   
   
   c= 0; 
   
   while (c < 5) {
     c++; 
     b = 0; 
     if (c < 4) {
       
       if ( (a == 0) || (b > 1)) {
         <<" ($a ==  0 || $b > 1) \n"; 
         
         }
       else {
         <<" NOT ($a == 0 || $b > 1) \n"; 
         lop = 1; 
         }
       
       
       chkT(lop); 
       }
     }
   
   
   Goo(); 
   
   Goo2(); 
   
   
#{
//  want to have use of AND OR XOR  ? NOT
     
     lop = 0; 
     if ( (a > 0) AND (b > 1)) {
       <<" ($a > 0 and $b > 1) \n"; 
       lop = 1; 
       }
     else {
       <<" NOT ($a > 0 AND $b > 1) \n"; 
       }
#}
   



#define TRUE  1


#{
 x = TRUE
<<"%V $x  \n"
#}



y = 1
<<"%V $y \n"


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


a =1
b = 1

 if ( a XOR_ b) {
  
  <<"  XOR is true $a $b \n"
 }
 else {
chkT(1)
  <<"  XOR is NOT true $a $b \n"

 }

b = 0

 if ( a XOR_ b) {
chkT(1)  
  <<"  XOR is true $a $b \n"
 }
 else {

  <<"  XOR is NOT true $a $b \n"

 }


//#define RED  1
//#define ORANGE  2
//#define GREEN  3 








chkN(2,RED_)
chkN(ORANGE_,3)
chkN(5,GREEN_)


  color = RED_ ;

 <<"%V $color  $(RED_ + 1) \n"

 <<" rgb  ",RED_,"\n"

  ocolor = ORANGE_ ;

  int t_or_f = 0

<<"%V$t_or_f  \n"

      t_or_f = TRUE_

<<"%V$t_or_f  \n"

<<"%V $ocolor  \n"


  color = GREEN_;


<<"%V $color  \n"
<<"AND %V $(AND_) \n"

  if ( (ocolor == ORANGE_ ) AND_ (color == GREEN_ )) {

        <<"$ocolor   AND $color  is TRUE $(TRUE_)\n"
     

     chkT(TRUE_)
   }


  if ( (ocolor == ORANGE_ ) OR_ (color == RED_ )) {

        <<"$ocolor is  $(ORANGE_)  OR_ $color  is RED is  TRUE\n"
        chkT(TRUE_)
   }


y = 1
<<"%V $y \n"






chkOut()


///  TBD
///  BXOR,BAND,  bit ops
   chkOut(1); 
   
   
