///
///  Cbrt
///

//setdebug(1,"trace");

checkIn()
f= Sqrt(81.0)

<<"$f $(typeof(f))\n"

f= Cbrt(81.0)

<<"$f $(typeof(f))\n"


f= Cbrt(125.0)

<<"$f $(typeof(f))\n"
checkFnum(f,5.0)

checkOut()