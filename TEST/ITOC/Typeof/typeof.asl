///
/// Typeof
///

/{/*

Typeof(V)
typeof - returns the type of the variable V as a string FLOAT,INT,...

/}*/

checkIn();
int i;

<<"$(typeof(i))\n"

wtype = typeof(i);

<<"%V $wtype \n"

checkStr(wtype,"INT");

float f;

<<"$(typeof(f))\n"

wtype = typeof(f);

<<"%V $wtype \n"

checkStr(wtype,"FLOAT");

pan p = 3.14159;

<<"$p\n"

<<"$(typeof(p))\n"

wtype = typeof(p);

<<"%V $wtype \n"

checkStr(wtype,"PAN");

checkOut();