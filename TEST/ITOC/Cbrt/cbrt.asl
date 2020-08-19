///
///  Cbrt
///

//setdebug(1,"trace");

chkIn()
f= Sqrt(81.0)

<<"$f $(typeof(f))\n"

f= Cbrt(81.0)

<<"$f $(typeof(f))\n"


f= Cbrt(125.0)

<<"$f $(typeof(f))\n"
chkR(f,5.0)

chkOut()