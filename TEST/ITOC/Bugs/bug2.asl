///
///
///


// bug2
// print  <<"  $(exp)  \n"   broke
// the exp is evaluated but the result is not printed

#include "debug"

if (_dblevel >0) {
   debugON()

}


chkIn(_dblevel)

  echoLines()

// this is a comment

  n= 2
  m = 3

<<"%V $n $m  \n"


<<"%V $n $m  $(n+m) \n"


<<" $(n+m) \n"

<<"%V $(n+m) \n"


 q = 0

<<" $(q= n+m) \n"

<<"%V $q\n"

 echoLines(0)

chkN(n,2)

chkN(m,3)

chkN(q,(n+m))


<<" $(q= n-m) \n"

<<"%V $q\n"

chkN(q,(n-m))

<<" $(q= n*m) \n"

<<"%V $q\n"

chkN(q,(n*m))

 chkOut(1)




