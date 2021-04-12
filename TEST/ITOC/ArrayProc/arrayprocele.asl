#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)


proc array_sub(float rl[])
{
float t1;

<<"In $_proc\n"
<<"$rl \n"
     t1 = rl[4] 

<<"%6.2f%V$t1\n"

<<"$(Caz(t1))\n"


chkR(t1,4.0);
   return t1;
}

Real1 = vgen(FLOAT_,10,0,1)
<<"%V$Real1\n"

float mt1;

  mt1 = Real1[4];
chkR(mt1,4)
<<"%V $mt1 \n"


val = array_sub(Real1)

<<"returned $val\n"


val = array_sub(Real1)

<<"returned $val\n"




chkOut()