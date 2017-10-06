///
/// Sizeof
///

/{/*

Sizeof(V)
  - returns the number of bytes for array elements of this type

/}*/

checkIn();
int i;
sz = sizeof(i);
<<"$(typeof(i)) $(sizeof(i)) \n"
checkNum(sz,4)
wtype = typeof(i);

<<"%V $wtype \n"

checkStr(wtype,"INT");

float f;

<<"$(typeof(f)) $(sizeof(f))  \n"
sz = sizeof(f);

checkNum(sz,4)

char c;

<<"$(typeof(c)) $(sizeof(c))  \n"
sz = sizeof(c);

checkNum(sz,1);

wtype = typeof(f);

<<"%V $wtype \n"

checkStr(wtype,"FLOAT");

pan p = 3.14159;

<<"$p\n"

<<"$(typeof(p))\n"

wtype = typeof(p);

<<" $wtype $(sizeof(p)) $(panlen(p))  $(sizeof(\"pan\"))\n"

checkStr(wtype,"PAN");

p = 123456789.987654321;

<<" $wtype $(sizeof(p)) $(panlen(p))  $(sizeof(\"pan\"))\n"

sz=sivSize()

<<" size of a Siv $sz\n"


checkOut();