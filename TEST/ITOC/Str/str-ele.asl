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


chkIn(_dblevel)

void pstr( str val)
{

<<"\nval <|$val|>\n"

   val->Info(1)

}
//===========================//


//===========================//


 int iv[10];

 iv[3] = 'A'

 <<"$iv\n"

 int k = iv[3];

 k->info(1);


 str abc = "abcdefg"

 abc->info(1);

 chkStr(abc,"abcdefg");
 char c;

  c->info(1)

  c = abc[3];

<<"%V$c %c $c\n"

chkC(c,'d')

c->info(1)

  abc[4] = 'X';


abc->info(1)
 

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

s->info(1)

<<"%V $s \n"

chkOut()





