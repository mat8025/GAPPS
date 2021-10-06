/* 
 *  @script str_proc_chain.asl 
 * 
 *  @comment test access and setting of Str args 
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
S str use in proc and call chain
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

filterFuncDebug(REJECT_,"varIndex","FindVar","ArrayCopy","storeString");	
filterFileDebug(REJECT_,"scopesindex_e","scope_e","scope_findvar","rdp_token");
chkIn(_dblevel)


str ostr( str val)
{
 Str ospv;
 Str oxpv = "xpv";
<<"\nval <|$val|>\n"
<<"in ostr \n"

   val<-pinfo()
   spv = val;
   spv<-pinfo()
   ps= qstr(val);
<<"ostr ret $spv $ps\n"
   return ps;
}
//===========================//

str pstr( str val)
{
 Str spv;
 Str xpv = "xpv";
<<"\nval <|$val|>\n"

   val<-pinfo()
   spv = val;
   spv<-pinfo()
<<" calling ostr? with $val \n"


   ps=ostr(val);
<<"ostr return $ps\n"
<<"pstr ret $spv $ps\n"
   return ps;
}
//===========================//

str qstr( str val)
{
 Str qspv;
 Str qxpv = "xpv";
<<"\nval <|$val|>\n"
<<"in qstr \n"

   val<-pinfo()
   spv = scat(val,"vorwarts");
   spv<-pinfo()
   val =  scat(val," vorwarts");
   ps=rstr(val);
<<"rstr return $ps\n"
   return ps;
}
//===========================//


str rstr( str val)
{
 Str qspv;
 Str qxpv = "xpv";
<<"\nval <|$val|>\n"
<<"in rstr \n"

   val<-pinfo()
   spv = scat(val," Ende der Strasse");
   spv<-pinfo()
   
<<"qstr ret $spv\n"
   return spv;
}
//===========================//



//===========================//


 int iv[10];

 iv[3] = 'A'

 <<"$iv\n"

 int k = iv[3];

 k<-pinfo();


 str abc = "abcdefg"

 abc<-pinfo();




 char c;

  c->info(1)

  c = abc[3];

<<"%V$c %c $c\n"

c->info(1)

  abc[4] = 'X';   // xic bug TBF


abc<-pinfo()
 



str xyz;

xyz = "xyz"

<<"$abc\n"





 ns=pstr(xyz)

 str def = "defgh"

 ns=pstr(def)

  chkStr(ns,"defgh vorwarts Ende der Strasse")

 ns=pstr("defgh")


  chkStr(ns,"defgh vorwarts Ende der Strasse")


 ns=pstr(abc);

  chkStr(ns,"abcdXfg vorwarts Ende der Strasse")

<<"$ns\n"



chkOut()






