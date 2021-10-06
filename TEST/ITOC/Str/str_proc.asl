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

/*
#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

filterFuncDebug(REJECT_,"varIndex","FindVar","ArrayCopy","storeString");	
filterFileDebug(REJECT_,"scopesindex_e","scope_e","scope_findvar","rdp_token");
*/

chkIn(_dblevel)



chkT(1)

int x = 21;

<<"%V$x\n"

 int iv[10];

// iv[3] = 'A' // bug TBF

<<"$iv\n"

  iv = 80;

<<"$iv\n"

 iv[3] = 65;
 <<"$iv\n"
//chkOut()

 int k = iv[3];

 k<-pinfo();

chkN(k,65);






str  T;

T= "XYZ";

<<"%V $T \n"

str  R = "Help";

<<"%V $T $R\n"

<<"$x\n"




proc  moo( int val)
{
<<"$_proc $val\n"

 pval = val + 78;

<<"$pval\n"
}
//===========================//


int  goo( int val)
{
<<"$_proc $val\n"

 pval = val + 78;

 return pval;
}
//===========================//

str ystr( str val)
{

<<"$_proc $val \n"

  val = scat(val,"123")
<<"$val\n"

val<-pinfo()

  return val;


}



str ostr( str val)
{
 Str ospv;
 Str oxpv = "xpv";
<<"\nval <|$val|>\n"
<<"in ostr \n"
!a
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
!a

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
!a
   val<-pinfo()
   spv = scat(val,"vorwarts");
   spv<-pinfo()
   val =  scat(val," vorwarts");
   ps=rstr(val);
<<"rstr return $ps\n"
   return ps;
cd ../}
//===========================//


str rstr( str val)
{
 Str qspv;
 Str qxpv = "xpv";
<<"\nval <|$val|>\n"
<<"in rstr \n"
!a
   val<-pinfo()
   spv = scat(val," Ende der Strasse");
   spv<-pinfo()
   
<<"qstr ret $spv\n"
   return spv;
}
//===========================//



//===========================//



str  S = "abcde";





//  moo(x)

 y = goo(x)


 chkN(y,99)

//  z= goo(y)
<<"%V$x $y\n"











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

xyz = "xYz"

<<"$abc\n"
!a

//ns=ystr(xyz);


ystr(xyz);




chkT(1)





 ns=pstr(xyz)

chkOut()

 str def = "defgh"

 ns=pstr(def)

  chkStr(ns,"defgh vorwarts Ende der Strasse")

 ns=pstr("defgh")


  chkStr(ns,"defgh vorwarts Ende der Strasse")


 ns=pstr(abc);

  chkStr(ns,"abcdXfg vorwarts Ende der Strasse")

<<"$ns\n"


chkOut()






