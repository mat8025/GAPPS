/* 
 *  @script str-proc.asl 
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
///

<|Use_=
S string use in proc
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

filterFuncDebug(REJECT_,"varIndex","FindVar","ArrayCopy","storeString");	
filterFileDebug(REJECT_,"scopesindex_e","scope_e","scope_findvar","rdp_token");
chkIn(_dblevel)




str pstr( str val)
{
 Str spv;
 Str xpv = "xpv";
<<"\nval <|$val|>\n"

   val->Info(1)
   spv = val;
   spv->info(1)

<<"ret $spv\n"
   return spv;
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




 char c;

  c->info(1)

  c = abc[3];

<<"%V$c %c $c\n"

c->info(1)

  abc[4] = 'X';


abc->info(1)
 



str xyz;

xyz = "xyz"

<<"$abc\n"

 pstr(abc);


 ns=pstr(xyz)

 str def = "defgh"

 ns=pstr(def)

  chkStr(ns,"defgh")

 ns=pstr("defgh")


  chkStr(ns,"defgh")




chkOut()






