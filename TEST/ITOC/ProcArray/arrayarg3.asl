



//#include "debug"


chkIn()

int veci = 3;






proc Roo(int vect[],int k)
{
<<"$_proc IN $vect \n"
<<"pa_arg2 %V$k\n"
  vect[1] = 47
  vect[2] = 79
  vect[3] = 80
  vect[4] = 78
  vect[5] = 50

<<"OUT $vect \n"
  return vect
}

// vec can't be used as var name - missing type -
// gen for anything


Z = Vgen(INT,10,0,1)

Z[0] = 36

<<"$Z\n"

Z[6] = 28
Z[7] = 78;
<<"before calling proc\n"

<<"$Z\n"




//Y=foo(Z,3)  // TBD FIX -- default array name is ref call



Y= Roo(&Z[1],4) 

<<"after proc $Z\n"

chkN(Z[2],47)
chkN(Z[6],50)
chkN(Z[7],78)


<<"return vec $Y\n"



chkN(Y[1],47)
chkN(Y[6],78)


chkOut()






