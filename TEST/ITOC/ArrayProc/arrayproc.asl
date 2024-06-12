
#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn()


float array_sub(float rl[])
{


<<"In $_proc\n"
<<"$rl \n"

j1 = 4
j2 = 6

<<"%V $rl[j1] \n"
x = rl[j1];
y = rl[j2]; 
<<"%V $rl[j2] \n"
z = x - y;
<<"%V $x $y $z\n"

rls = rl[j1] - rl[j2];

<<"%V$rls\n"

chkR(rls,-2)

rl[j1] = 47.0;

<<"%V $rl \n"

<<"%V $rl[j1] $rl[j2] \n"

rl[j1] = rl[j1] - rl[j2];

<<"%V $rl \n"

chkR(rl[j1],41)

return rls
}

//////////////////////////////////////////////////////////////////////////////////////


   Real = fgen(10,0,1)
<<"%V$Real\n"
   j1 = 4;
   j2 = 6;
   
   rlm = Real;

<<"%V $rlm \n"
<<"%V $j1 $j2 \n"

 kp = 3;

x = rlm[j1];
y = rlm[j2]; 
<<"%V $rlm[j2] \n"
z = x - y;
<<"%V $x $y $z\n"
rls = rlm[j1] - rlm[j2];

<<"%V$rls\n"

chkR(rls,-2)

rlm[j1] = rlm[j1] - rlm[j2];

<<"%V $rlm \n"
<<"%V $rlm[j1] \n"

chkR(rlm[j1],-2)

<<"%V $rlm[kp] \n"

val = array_sub(Real)

chkOut();


 





chkOut();