///
///
///


// bug2
// print  <<"  $(exp)  \n"   broke
//the exp is evaluated but the result is not printed

#include "debug"

if (_dblevel >0) {
   debugON()

}


chkIn()

  echoLines()

 cdate = date(2,'-')

<<"current_score Scores/score_${cdate} \n"

<<" current_score Scores/score_$(date(2,'-')) \n"

<<" the \$(func())  exp is evaluated but the result is not printed into output str \n "

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




