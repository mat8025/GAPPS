opendll("math")
setdebug(0)
chkIn()

  y = Sin(_PI/4.0) 
  z = Cos(_PI/4.0) 

<<" $y $z $_PI \n"

  z = Sin(_PI/4.0) * Cos(_PI/4.0)

<<" $z  \n"


  z = Sin(Cos(_PI/4.0))

<<" $z  \n"

stop!
