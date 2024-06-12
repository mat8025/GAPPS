/* 
 *  @script str-ele.asl 
 * 
 *  @comment test access and setting of Ste elements 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.23 C-Li-V]                                
 *  @date Wed Feb 17 12:43:42 2021 
 *  @cdate Wed Feb 17 12:43:42 2021 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///
///

<|Use_=
S string but should be able to be accessed like a dynamic char array
|>




#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


chkIn()

void pstr( str val)
{

<<"\nval <|$val|>\n"

   val.pinfo()

}
//===========================//


//===========================//


 int iv[10];

 iv[3] = 'A'

 <<"$iv\n"

 int k = iv[3];

 k->info(1);


 str abc = "abcdefghijklmnopqrstuvwxyz"

 abc.pinfo();

 chkStr(abc,"abcdefghijklmnopqrstuvwxyz");
 
 char c;

  c.pinfo()

  c = abc[3];

<<"%V$c %c $c\n"

  c.pinfo()

chkC(c,'d')

c.pinfo()


  c = abc[13];

<<"%V$c %c $c\n"

chkC(c,'n')


str s;

  s = abc[2:15:2]

<<"%v $s\n"

chkStr(s,"cegikmo");

s.pinfo();


  abc[4] = 'X';


abc.pinfo()
 

chkOut()
exit()

str xyz = "xyz"

<<"$abc\n"

 pstr(abc);

 pstr("defgh")




abc[4] = 'A'

<<"$abc\n"



Str s = "h";

<<"X<|$s|>\n"

str s2="OK?"

pstr(s2);

!!"echo $s2"

pstr("B");



s = "hi there";

s.info()

<<"%V $s \n"

chkOut()





