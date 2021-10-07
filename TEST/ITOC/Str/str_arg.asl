/* 
 *  @script str-arg.asl 
 * 
 *  @comment str args 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.48 C-Li-Cd]                               
 *  @date 08/21/2021 06:50:56 
 *  @cdate 08/21/2021 06:50:56 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//


                                                                                              
<|Use_=
Demo  of str args command
///////////////////////
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}


chkIn(_dblevel)

proc woo(str a1)
{

<<"$_proc $a1\n";

a1<-pinfo();
pinfo(a1);

 a2= a1;
 a2<-pinfo();

 a4=scat(a1," bitte")
 <<"$a4\n"
  return a4;
}



a="hey"
b="man"

w1 = scat("$a ","$b")

<<"$w1\n"

a="say"


w1 = scat("$a ","$b")

<<"$w1\n"

chkStr(w1,"say man")
k= 2

for (i=0;i < 3; i++) {

w1 = scat('$k ',"$i")
<<"$w1\n"
}

chkStr(w1,'$k 2')

a3=woo(w1)

<<"$a3\n"

a3=woo("jetzt vortreten")

<<"$a3\n"




chkOut()