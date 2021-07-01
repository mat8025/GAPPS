

#include "debug"

if (_dblevel >0) {
   debugON()

}


chkIn(_dblevel)

Dur = vgen (FLOAT_,10,1,0.5)

<<"$Dur \n"

float rtime = 0.0;

for (i= 0; i < 3; i++) {



  rtime += Dur[i];

<<"%V  $rtime $Dur[i]\n"
  rtime->info(1)
}


chkR(rtime, 4.5)

chkOut()