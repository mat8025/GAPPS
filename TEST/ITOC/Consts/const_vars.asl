//%*********************************************** 
//*  @script const_vars.asl 
//* 
//*  @comment test const declare 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Fri Apr 17 12:45:14 2020 
//*  @cdate Fri Apr 17 12:45:14 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

setAP(0)

include "consts_local"

chkIn()

nlb = 10
nkg = 10 * _lb2kg

F = 1.0/ _lb2kg 

<<"%V$nkg  $nlb $_lb2kg $F\n"

a= _PI

<<"%V$a $_PI \n"

chkR(a,_PI,6)

// can't do this
<<"tring to modify internal _PI --- won't work which is correct! \n"
_PI = 2.0


<<"%V$a $_PI \n"

 chkR(a,_PI,6)



const double ALV = 59.0

<<"trying to modify a declared const variable  --- won't work which is correct! \n"

<<"%V $ALV  $(typeof(ALV)) \n"
 chkR(ALV,59.0,6)

ALV = 23

<<"%V$ALV  $(typeof(ALV)) \n"

<<" this should pass ALV == 59 !! $ALV \n"
 chkR(ALV,59.0,6)

<<" this should fail ALV == 23  $ALV \n"
  if (ALV == 23) {
  did_mod = 1 
  }
  else {
  did_mod = 0
  }

  checknum(did_mod,0)


const int Gyear = 2009

 chkN(Gyear,2009)

<<"trying to modify a declared const variable  --- won't work which is correct! \n"
Gyear = 2027

 chkN(Gyear,2009)


<<"\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n"

//S=units()
//<<"$S\n"

<<"\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n"

//S=consts()
//<<"$S\n"
<<"\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n"


  chkOut()
