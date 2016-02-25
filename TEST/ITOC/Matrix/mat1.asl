

 I = vgen(INT_,16,1,1)

<<"$I \n"

 I->redimn(4,4)


<<"\n%(4,[, ,]\n)2d$I \n"

  J = transpose(I)


<<"\n%(4,[, ,]\n)2d$J \n"


  K = reflectCol(I)


<<"\n%(4,[, ,]\n)2d$K \n"


  L = reflectRow(K)


<<"\n%(4,[, ,]\n)2d$L \n"


  R = rotateRow(L,1)


<<"\n%(4,[, ,]\n)2d$R \n"


  T = transpose(K)

<<"\n%(4,[, ,]\n)2d$T \n"


  U = reflectCol(T)

<<"\n%(4,[, ,]\n)2d$U \n"