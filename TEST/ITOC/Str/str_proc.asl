/* 
 *  @script str_proc.asl 
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

Str Use_ ="S string use in proc";


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

filterFuncDebug(REJECT_,"varIndex","FindVar","ArrayCopy","storeString");	
//filterFileDebug(REJECT_,"scopesindex_e","scope_e","scope_findvar","rdp_token");


chkIn(_dblevel)



chkT(1)

int  goo( int val)
{
<<"$_proc $val\n"

 pval = val + 78;

 return pval;
}
//===========================//

Str nameMangle(Str aname, int a)
{
  // FIXIT --- bad arg  bad return
  <<" $_proc   $aname\n";
  Str fname;

 nname=aname
 <<" %V $nname $aname \n"

  kc =slen(nname)

 if (kc >7) {
 nname=svowrm(nname)
 }

 scpy(fname,nname,7)

   // <<"%V$nname --> $fname \n"


 return fname
}
//======================================//

int a = 34;


  b = goo(a);


<<"%V $a $b \n"
   chkN(b,112);


 Str abc = "abcdefghi"

 abc.pinfo();


 rov = nameMangle(abc,1);

<<"%V $rov\n";



chkStr(rov,"bcdfgh");



chkOut();

exit(-1);


int x = 21;

<<"%V$x\n"

 int iv[10];

// iv[3] = 'A' // bug TBF

<<"$iv\n"

  iv = 80;

<<"$iv\n"

 iv[3] = 65;
 
 <<"$iv\n"


int k = iv[3];



 k.pinfo();

chkN(k,65);

 k2 = iv[4];

chkN(k2,80);







Str  T;

T= "XYZ";

<<"%V $T \n"

Str  R = "Help";

<<"%V $T $R\n"

<<"$x\n"



void  moo( int val)
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

Str ystr( Str val)
{

<<"$_proc $val \n"

  val = scat(val,"123")
<<"$val\n"

  val.pinfo()
  yval = val;
  return val;


}



Str ostr( Str val)
{
 Str ospv;
 Str oxpv = "xpv";
<<"\nval <|$val|>\n"
<<"in ostr \n"

   val.pinfo()
   spv = val;
   spv.pinfo()
   ps= qstr(val);
<<"ostr ret $spv $ps\n"
   return ps;
}
//===========================//

Str pstr( Str val)
{
 Str spv;
 Str xpv = "xpv";
<<"\nval <|$val|>\n"

   val.pinfo()
   spv = val;
   spv.pinfo()
<<" calling ostr? with $val \n"


   ps=ostr(val);
<<"ostr return $ps\n"
<<"pstr ret $spv $ps\n"
   return ps;
}
//===========================//
Str qstr( Str val)
{
 Str qspv;
 Str qxpv = "xpv";
<<"\nval <|$val|>\n"
<<"in qstr \n"

   val.pinfo()
   spv = scat(val,"vorwarts");
   spv.pinfo()
   val =  scat(val," vorwarts");
   ps=rstr(val);
<<"rstr return $ps\n"
   return ps;
}
//===========================//


Str rstr( Str val)
{
 Str qspv;
 Str qxpv = "xpv";
<<"\nval <|$val|>\n"
<<"in rstr \n"

   val.pinfo()
   spv = scat(val," Ende der Strasse");
   spv.pinfo()
   
<<"qstr ret $spv\n"
   return spv;
}
//===========================//



//===========================//



Str  S = "abcde";





//  moo(x)

 y = goo(x)


 chkN(y,99)

//  z= goo(y)
<<"%V$x $y\n"











 char c;

  c.pinfo()

  c = abc[3];

<<"%V$c %c $c\n"

c.pinfo()

  abc[4] = 'X';   // xic bug TBF


abc.pinfo()
 



Str xyz;

xyz = "xYz"

<<"$abc\n"


//ns=ystr(xyz);


ystr(xyz);




chkT(1)





 ns=pstr(xyz)

chkOut()

 Str def = "defgh"

 ns=pstr(def)

  chkStr(ns,"defgh vorwarts Ende der Strasse")

 ns=pstr("defgh")


  chkStr(ns,"defgh vorwarts Ende der Strasse")


 ns=pstr(abc);

  chkStr(ns,"abcdXfg vorwarts Ende der Strasse")

<<"$ns\n"


chkOut()






