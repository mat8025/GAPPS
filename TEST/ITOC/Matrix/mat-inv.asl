


// matrix inverse
#include "debug"
debugON()

 chkIn(_dblevel)

chkIn(_dblevel)

 float M[] = {4,7,2,6};

<<"$M\n"

  M->redimn(2,2)


<<"M= $M\n"
  T =M

<<"T= $T\n"

  IM = Minv(M)

<<"M= $M\n"


chkR(IM[0][0],0.6)
chkR(IM[1][0],-0.2)

<<"IM =$IM \n"


  IDM = M * IM;

<<"$IDM \n"
chkR(IDM[0][0],1.0)
chkR(IDM[1][1],1)


mprt(IM)

chkOut()

exit()







R= Dgen(25,1,1)

 <<" $(typeof(R)) \n"

 <<"%v \n $R \n"

  Redimn(R,5,5)


 <<"%r %6.1f \n $R \n"

<<" minv \n"

  V=  Minv(R)


<<"%r%6.1f \n $V \n"



