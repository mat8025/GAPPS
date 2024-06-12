


#include "debug"


if (_dblevel >0) {
   debugON()
}


chkIn()


 fv = vgen(FLOAT_,10,0,1)
 fv->info()

<<"$fv \n"

  chkR(fv[1],1.0)

 fv[0] = -32;
 fv[2] = 77;
 fv[3] = 80;

<<"$fv \n"

chkN(fv[3],80)
