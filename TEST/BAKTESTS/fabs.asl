///
///
///

setdebug(1,@pline,@~step,@trace,@showresults,1)
filterFuncDebug(ALLOWALL_,"proc","opera_ic");
filterFileDebug(ALLOWALL_,"ic_","array_subset");



checkIn()

// bug in arg passing??

  double y = 1234.123456

  x= fabs(y)

<<"%V $x  $y\n"

  z = y * -1.0;

  x= fabs(z)

<<"%V $x  $y\n"

  checkFnum(x,y,6)


  y = 123456.123456

  z = y * -1.0;

  x= fabs(z)

<<"%V $x  $y\n"

  checkFnum(x,y,6)


  y = 123456789.123456

  z = y * -1.0;

  x= fabs(z)

<<"%V $x  $y\n"

  checkFnum(x,y,6)

checkOut()