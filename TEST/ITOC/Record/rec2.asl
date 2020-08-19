
///
///  Records
///

setdebug(1);

 record R[10];


 R[0] = "some words";

<<"%V$R[0]\n"


 R[1] = R[0];
 

<<"%V$R[1]\n"

 R[2] = R[1];

<<"%V$R[2]\n"


R[0] = Split("some other words to add");

<<"%V$R[0]\n"


 R[1] = R[0];

 sr1 = R[1][2]
   
chkStr(sr1,"words")

<<"%V$R[1]\n"

<<"%V$R[0][1] $R[0][2]\n"

<<"%V$R[1][1] $R[1][2]\n"