

#include "debug"

if (_dblevel >0) {
   debugON()
   
}

chkIn(_dblevel);
  int  j = 5;

  int  k = 1;

  int m = j & k;

  chkEQ(m,1);
  float mf = m

  <<"%V $j & $k BAND  $mf \n";

  cprintf(" j %d & k %d BAND  m %d \n");

float f = 67.0;
double d = 89.5;

long L = 19674956;

short si = 55;

Str st = "tricky";
  <<"%V $f  $d  $L $si $st\n";
char cc[20] = "even trickier";

  <<"%V %s $cc \n";


 chkOut();
 
