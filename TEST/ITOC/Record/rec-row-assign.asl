//%*********************************************** 
//*  @script rec-row-assign.asl 
//* 
//*  @comment test record row assign 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Fri Dec 25 22:59:34 2020 
//*  @cdate 1/1/2014 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

///
///  Records
///


#include "debug.asl";


if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)

Record R[10];


 R[0] = "some words";

<<"%V$R[0]\n"


 R[1] = R[0];
 

<<"%V$R[1]\n"



 R[2] = R[1];

<<"%V$R[2]\n"


R[0] = Split("some other words to add");

<<"%V$R[0]\n"

<<"%V$R[0][4]\n"

 R[1] = R[0];

<<"%V$R[1]\n"


<<"%V$R[1][2]\n"


//Str sr1;

 sr1 = R[1][2]

<<"%V $sr1\n"
   
chkStr(sr1,"words")

<<"%V$R[1]\n"

<<"%V$R[0][1] $R[0][2]\n"

<<"%V$R[1][1] $R[1][2]\n"


chkOut()