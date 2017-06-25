
///
///  Records
///

setdebug(1);

 record R[10];



 R[0] = "some words";

<<"%V$R[0]\n"


 R[1] = Split("some other words");

<<"%V$R[1]\n"


 record A[6+];


 A[0] = "extra words";

<<"%V$A[0]\n"


 A[1] = "one word";

<<"%V$A[1]\n"

 A[5] = "sixth record";

<<"%V$A[5]\n"

 A[12] = "more words";

<<"%V$A[12]\n"


 A[6] = "seventh rec";




<<"%V$A[6]\n"

<<"%V$A[12]\n"


A[20] = "twentyfirst rec";
<<"%V$A[20]\n"

 A[12] = "more words";

<<"%V$A[12]\n"