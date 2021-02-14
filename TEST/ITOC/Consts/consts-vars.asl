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

#include "consts_local"

#include "debug"

chkIn(_dblevel)

nlb = 10
nkg = 10 * _lb2kg

F = 1.0/ _lb2kg 

<<"%V$nkg  $nlb $_lb2kg $F\n"

_PI->info(1);


a= _PI

<<"%V$a $_PI \n"

chkR(a,_PI,6)

// can't do this
<<"trying to modify internal _PI --- won't work which is correct! \n"

_PI->info(1);

_PI = 2.0


<<"%V$a $_PI \n"

 chkR(a,_PI,6)




const double ALV = 59.0

<<"trying to modify a declared const variable  --- won't work which is correct! \n"

ALV->info(1)
 chkR(ALV,59.0,6)

ALV = 23
ALV->info(1)


<<" this should pass ALV == 59 !! $ALV \n"
 chkR(ALV,59.0,6)

<<" this should fail ALV == 23  $ALV \n"
  if (ALV == 23) {
  did_mod = 1 
  }
  else {
  did_mod = 0
  }

  chkN(did_mod,0)



const int Gyear = 2009

Gyear->info(1)

 chkN(Gyear,2009)

<<"trying to modify a declared const variable  --- won't work which is correct! \n"
 Gyear = 2027

Gyear->info(1)

 chkN(Gyear,2009)


  chkOut()

exit()


<<"\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n"

//S=units()
//<<"$S\n"

<<"\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n"

//S=consts()
//<<"$S\n"
<<"\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n"


