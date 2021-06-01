/* 
 *  @script sizeof.asl 
 * 
 *  @comment test sizeof SF -- for memtypes and Svar,Siv,Pan, ... 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.8 C-Li-O]                                  
 *  @date Mon Jan 11 09:03:11 2021 
 *  @cdate 1/1/2003 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///
/// Sizeof
///

<|Use_=
Sizeof(V)
  - returns the number of bytes for array elements of this type
|>

proc showUse()
{
  <<"$Use_\n"
}


//==================================



#include "debug"

if (_dblevel >0) {
   debugON()
   showUse();
}
  
chkIn(_dblevel)




int i;
sz = sizeof(i);
<<"$(typeof(i)) $(sizeof(i)) \n"
chkN(sz,4)
wtype = typeof(i);

<<"%V $wtype \n"

chkStr(wtype,"INT");

float f;

<<"$(typeof(f)) $(sizeof(f))  \n"
sz = sizeof(f);

chkN(sz,4)
double d;

<<"$(typeof(d)) $(sizeof(d))  \n"
sz = sizeof(d);

chkN(sz,8)

char c;

<<"$(typeof(c)) $(sizeof(c))  \n"
sz = sizeof(c);

chkN(sz,1);

wtype = typeof(f);

<<"%V $wtype \n"

chkStr(wtype,"FLOAT");

pan p = 3.14159;

<<"$p\n"

<<"$(typeof(p))\n"

wtype = typeof(p);

<<" $wtype $(sizeof(p)) $(panlen(p))  $(sizeof(\"pan\"))\n"

chkStr(wtype,"PAN");

p = 123456789.987654321;

<<" $wtype $(sizeof(p)) $(panlen(p))  $(sizeof(\"pan\"))\n"

sz=sizeof("Siv")

<<" size of a Siv $sz\n"

sz=sizeof("Svar")

<<" size of a Svar $sz\n"

sz=sizeof("Record")

<<" size of a Record $sz\n"

sz=sizeof("Str")

<<" size of a Str $sz\n"

sz=sizeof("Pan")

<<" size of a Pan $sz\n"


chkOut();