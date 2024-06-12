
<|Use_=
Demo  of 2D set range;


///////////////////////
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


chkIn()


int M[10][6]

<<"$M\n"

chkN(M[1][1],0)

int N[10][10]

int V[6];


V[2] = 8
V[3] = 79

<<"%V$V\n"

  V[1:4:1] = 77

<<"%V$V\n"

  M[1:8:2][1:3:1] = 6

<<"$M\n"



chkN(M[1][1],6)





  M[2][1:5:2] = 96

  M[3][::] = 7

  M[1:4][::] = V

<<"$M\n"

  M[5][::2] = 3

  M[6][1::] = 4

  M[7][::2] = 76


  N[::][2] = 3

<<" $N \n"

chkOut()