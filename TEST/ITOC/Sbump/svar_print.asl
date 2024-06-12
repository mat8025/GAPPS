/* 
 *  @script svar_print.asl  
 * 
 *  @comment test svar range print 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.66 C-Li-Dy]                               
 *  @date 12/11/2021 10:48:54 
 *  @cdate 12/11/2021 10:48:54 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

;//----------------------//;

<|Use_= 
Demo  of test svar range print 
/////////////////////// 
|>


#include "debug" 
  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 

  chkIn()

  chkT(1);

///
 
///

///



 svar L;







 L = split("one day at a time dude and keep calm")







<<"%V$L \n"







<<"%V$L[2] \n"

<<"%V$L[2::] \n"

<<"%V$L[2:7:1] \n"

<<"%V$L[2:6:1] \n"

<<"%V$L[2:-1:1] \n"

<<"%V$L[-1:0:-1] \n"




adate = "$L[::]";
bdate = "$L[2::]";
cdate = "$L[2:-1:1]";



<<"found cdate  $cdate\n"     

<<"%V$adate  \n"
<<"%V$bdate  \n"     

<<"%V$cdate  \n"


chkOut()

Record TB[5];

TB[0] = L;

<<"%V$TB\n";

<<"%V$TB[0]\n";
<<"%V$TB[1]\n";


!a

svar S





<|T=
30
12/11/21 10:59
asl:svar_print.asl
cpp:paramexpsvar
descr: bdate = "$L[2::]";   - range not applied correctly
fix_date
|>

T.pinfo()

<<"%V$T\n"
TB[0] = T[::]

<|T=
31
12/11/21 11:11
asl:svar_print.asl
cpp:paramexpsvar
descr: try to program bug reporting
fix_date
|>
<<"%V$T\n"
TB[1] = T[::]

TB.pinfo()

<<"%V$T\n"


<<"%V$TB[0]\n"
<<"%V$TB[1]\n"

<<"%V$TB[1][1]\n"
<<"<|$TB[1][2]|>\n"


<|TB[2]=
32
12/11/21 12:21
asl:svar_print.asl
cpp:paramexpsvar
descr: try to program bug reporting
fix_date
|>

<<"%V$TB[2]\n"

<<"%V$TB[0]\n"
<<"%V$TB[1]\n"


chkOut()
