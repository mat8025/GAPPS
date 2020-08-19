///
/// Typeof
///

/{/*

Typeof(V)
typeof - returns the type of the variable V as a string FLOAT,INT,...

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

wtype = typeof(f);

<<"%V $wtype \n"

checkStr(wtype,"FLOAT");

pan p = 3.14159;

<<"$p\n"

<<"$(typeof(p))\n"

wtype = typeof(p);

<<"%V $wtype $(sizeof(p))\n"

checkStr(wtype,"PAN");

checkOut();