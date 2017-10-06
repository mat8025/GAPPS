///
/// cosh, tanh, ...
///

/{/*

  cosh (x) = (exp(x) + exp(-x))/ 2.0;

  sinh (x) = (exp(x) - exp(-x))/ 2.0;

  tanh (x) = sinh (x) / cosh (x);

/}*/


  checkIn()
 x = 0.5;
 y = cosh(x);
 z = (exp(x) + exp(-x))/ 2.0;

  checkFNum(z,y)
<<" cosh($x) = $y   $z\n"

 y = sinh(x);
 z = (exp(x) - exp(-x))/ 2.0;

  checkFNum(z,y)

<<" sinh($x) = $y   $z\n"

 y = tanh(x);

 z = sinh (x) / cosh (x);

<<" tanh($x) = $y   $z\n"

  checkFNum(z,y);

  y = sin(x)

  z= asin(y);

<<"%V $x $y $z\n"

  checkFNum(z,x);

  x = 2.0 * atan(1.0);

  y = sin(x)

  z= asin(y);

<<"sin/asin %V $x $y $z\n"

  checkFNum(z,x);

  x = 2.0 * atan(1.0);

  y = cos(x)

  z= acos(y);

<<"cos/acos %V $x $y $z\n"

  checkFNum(z,x);

  x = 2.0 * atan(1.0);

  y = tan(x)

  z= atan(y);

<<"tan/atan %V $x $y $z\n"

  checkFNum(z,x);

  y = tanh(x)
  z = atanh(y);

<<"tanh/atanh %V $x $y $z\n"

checkFNum(z,x);


  checkOut();
  




