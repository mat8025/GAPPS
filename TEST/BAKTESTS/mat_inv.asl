// matrix inverse

R= Dgen(25,1,1)

 <<" $(typeof(R)) \n"

 <<"%v \n $R \n"

  Redimn(R,5,5)


 <<"%r %6.1f \n $R \n"

<<" minv \n"

  V=  Minv(R)


<<"%r%6.1f \n $V \n"


STOP!
