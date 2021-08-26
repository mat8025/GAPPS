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


void soo( str sa)
{
<<"$_proc $sa\n"

str s1 = sa;

<<"$sa $s1\n"

  s1->pinfo()
!a

}

void soo2( str s)
{
<<"$_proc $s\n"

str s2 = s;
<<"%V $s $s2\n"
  s2->pinfo()
!a
 soo(s)

}

void soo3( str sb)
{
<<"$_proc $sb\n"

str s3 = sb;
<<"%V $sb $s3\n"
  s3->pinfo()
!a
<<"call soo2 \n"
 soo2(sb)

}

str sf = "abc"

<<"%V $sf\n"

soo3(sf)
!a

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