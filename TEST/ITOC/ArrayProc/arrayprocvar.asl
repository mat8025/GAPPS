

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn()


proc array_sub(float rl[])
{


<<"In $_proc\n"
<<"$rl \n"

j1 = 4;

rl[j1] = 47.0;

<<"%V $rl \n"


chkR(rl[4],47)

rls = rl[j1];

return rls;
}

//////////////////////////////////////////////////////////////////////////////////////


   Real = fgen(10,0,1)
<<"%V$Real\n"
   j1 = 4;
   
   rlm = Real;

<<"%V $rlm \n"
<<"%V $j1 \n"

rlm[j1] = 47.0;



//rlm[j1] = rlm[j1] - rlm[j2];

<<"%V $rlm \n"
<<"%V $rlm[j1] \n"

chkR(rlm[4],47)

chkR(rlm[j1],47)



val = array_sub(Real)

<<"%V$val \n";

chkOut();


 