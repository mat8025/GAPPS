

#define TRUE  1


#{
 x = TRUE

<<"%V $x  \n"
#}



y = 1
<<"%V $y \n"
;


CheckIn()


 a = 1
 b = 0



 if ( a && b) {

  <<"  && is true $a $b \n"

 }
 else {

  CheckTrue(1)
  <<"  && is NOT true $a $b \n"

 }


 if ( a AND b) {

  <<"  AND is true $a $b \n"

 }
 else {
  CheckTrue(1)
  <<"  AND is NOT true $a $b \n"

 }


 if ( a OR b) {
  CheckTrue(1)
  <<"  OR is true $a $b \n"

 }
 else {

  <<"  OR is NOT true $a $b \n"

 }

 if ( a XOR b) {
  CheckTrue(1)
  <<"  XOR is true $a $b \n"

 }
 else {

  <<"  XOR is NOT true $a $b \n"

 }

 if ( a NAND b) {
  CheckTrue(1)
  <<"  NAND is true $a $b \n"

 }
 else {

  <<"  NAND is NOT true $a $b \n"

 }



<<"   AND what do we make of this OR NOT \n"

 c = a * b 

<<"%V $a $b $c \n"

;
CheckOut()
stop()

;

