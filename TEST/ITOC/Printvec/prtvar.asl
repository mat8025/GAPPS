/* 
   *  @script prtvar.asl
   *
   *  @comment print format for vectors
   *  @release CARBON
   *  @vers 1.4 Be Beryllium [asl 6.3.64 C-Li-Gd]
   *  @date 11/29/2021 21:01:31
   *  @cdate 11/29/2021 21:01:31
   *  @author Mark Terry
   *  @Copyright © RootMeanSquare  2010,2021 →
   *
   *  \\-----------------<v_&_v>--------------------------; //
 */ 
   ;//----------------------//;
   
<|Use_= 
   Demo  of print format for vectors
/////////////////////// 
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_ \n";

     }

   chkIn(_dblevel);


A =1
B =2
C =3

<<"$A $B $C\n"



printf("A %d B %d \n",A,B);
char TPname[64];


 sprintf(TPname,"A %d B %d \n",A,B);

<<"%s $TPname\n";

exit();


Vec=Igen(10,0,1)

<<"%(2,\s-->,\t,<--\n)$Vec\n"

c="X"
d="Y"
e="Z"
<<"%-10.1s$c %25.1s$d \v %30.1s$e \r$c\n"


<<" $(2+2) \n"

mystr="abcd"

<<" $mystr \n"

ns = scat(mystr,"efgh")
<<"$ns\n"

<<" $(scat(mystr,\"_super\")) \n"

vs = nsc(10,"x")
<<"$vs \n"

<<"nsc $(nsc(10,\"ha\")) \n"

chkOut()