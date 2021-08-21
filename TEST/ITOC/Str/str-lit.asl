/* 
 *  @script str-lit.asl 
 * 
 *  @comment str arg literal string 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.48 C-Li-Cd]                               
 *  @date 08/21/2021 07:15:38 
 *  @cdate 08/21/2021 07:15:38 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//

<|Use_=
Demo  of str arg as Single quoted literal string  command
///////////////////////
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}


chkIn(_dblevel)




str s_lit;

s_lit = 'hey\|there'

chkStr(s_lit,'hey\|there')


<<"%V$s_lit $(typeof(s_lit))\n"


 s_dq = "hey\n|there"

<<"%V$s_dq $(typeof(s_dq))\n"



w1 = scat( 'hey\|there'," $s_lit")
<<"$w1\n"

slong_lit = 'hey_thereABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'


len=slen(slong_lit)
<<"$len \n$slong_lit\n"

chkT(1)
chkOut()

exit()