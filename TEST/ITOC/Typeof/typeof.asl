///
/// Typeof
///

/{/*

Typeof(V)
typeof - returns the type of the variable V as a string FLOAT,INT,...

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

wtype = typeof(f);

<<"%V $wtype \n"

chkStr(wtype,"FLOAT");

pan p = 3.14159;

<<"$p\n"

<<"$(typeof(p))\n"

wtype = typeof(p);

<<"%V $wtype $(sizeof(p))\n"

chkStr(wtype,"PAN");

chkOut();