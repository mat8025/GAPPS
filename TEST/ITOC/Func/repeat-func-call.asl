



#include "debug";



if (_dblevel >0) {
   debugON()
}
  
 chkIn(_dblevel);

N = 1000;
y= 0.0;
//x= 0.0;
//int i = 0;
for (i= 0; i <N; i++) {
  x = sin(y)
  
  <<"%V [${i}] $x  sin ( $y )\n"
  y += 0.1;
}

chkN(i,N)

chkOut()