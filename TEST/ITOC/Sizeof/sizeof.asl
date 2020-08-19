///
/// Sizeof
///

/{/*

Sizeof(V)
  - returns the number of bytes for array elements of this type

/}*/

chkIn();
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

sz=sivSize()

<<" size of a Siv $sz\n"


chkOut();