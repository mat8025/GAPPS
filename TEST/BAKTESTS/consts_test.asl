# test internal consts

setAP(0)

// FIX PAN types when we use these for exp > 100
//const double h_ = 6.626e-34
//<<"%v %e $h_ \n"


lib = "/usr/local/GASP/gasp/LIB/"

include "$lib/consts.asl"

CheckIn()


a= _PI

<<"%V$a $_PI \n"

CheckFNum(a,_PI,6)

// can't do this
<<"tring to modify internal _PI --- won't work which is correct! \n"
_PI = 2.0


<<"%V$a $_PI \n"

CheckFNum(a,_PI,6)

//setdebug(1)
const double ALV = 59.0



<<"%V $ALV  $(typeof(ALV)) \n"
 CheckFNum(ALV,59.0,6)

<<"trying to modify a declared const variable  --- which won't work error is correct behaviour! \n"
ALV = 23

<<"%V$ALV  $(typeof(ALV)) \n"

<<" this should pass ALV == 59 !! $ALV \n"
 CheckFNum(ALV,59.0,6)

<<" this should fail ALV == 23  $ALV \n"
  if (ALV == 23) {
  did_mod = 1 
  }
  else {
  did_mod = 0
  }

  checknum(did_mod,0)

  CheckOut()

stop!

const int Gyear = 2009

 CheckNum(Gyear,2009)

<<"trying to modify a declared const variable  --- won't work which is correct! \n"
Gyear = 2027

 CheckNum(Gyear,2009)

// FIXIT
//const double _G = 6.672e-11
//<<" %V %e $G_ \n"

  CheckOut()

stop!

<<"\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n"

units()


<<"\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n"

consts()

<<"\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n"

<<"%e $k_ \n"

  CheckOut()

;
