///
/// cosh, tanh, ...
///

/{/*

  cosh (x) = (exp(x) + exp(-x))/ 2.0;

  sinh (x) = (exp(x) - exp(-x))/ 2.0;

  tanh (x) = sinh (x) / cosh (x);

/}*/


  chkIn()
 x = 0.5;
 y = cosh(x);
 z = (exp(x) + exp(-x))/ 2.0;

  chkR(z,y)
<<" cosh($x) = $y   $z\n"

 y = sinh(x);
 z = (exp(x) - exp(-x))/ 2.0;

  chkR(z,y)

<<" sinh($x) = $y   $z\n"

 y = tanh(x);

 z = sinh (x) / cosh (x);

<<" tanh($x) = $y   $z\n"

  chkR(z,y);

  y = sin(x)

  z= asin(y);

<<"%V $x $y $z\n"

  chkR(z,x);

  x = 2.0 * atan(1.0);

  y = sin(x)

  z= asin(y);

<<"sin/asin %V $x $y $z\n"

  chkR(z,x);

  x = 2.0 * atan(1.0);

  y = cos(x)

  z= acos(y);

<<"cos/acos %V $x $y $z\n"

  chkR(z,x);

  x = 2.0 * atan(1.0);

  y = tan(x)

  z= atan(y);

<<"tan/atan %V $x $y $z\n"

  chkR(z,x);

  y = tanh(x)
  z = atanh(y);

<<"tanh/atanh %V $x $y $z\n"

chkR(z,x);


  chkOut();
  




