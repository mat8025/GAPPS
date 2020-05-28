//  test vec cat expand ops
setdebug(1)
CheckIn()

int M[]
int N[]
int P[]


  N= igen(20,0,1)

<<"$N \n"

 P= N

<<"$P \n"

  P[10] = 80

  P[30] = 47

   CheckNum(P[30],47)
  P[25] = 79
   CheckNum(P[25],79)

<<"$P \n"

  M= igen(10,0,-1)

<<"$M \n"

  V = M @+ P

<<"$V \n"

 CheckNum(V[1],-1)
 CheckNum(V[11],1)
 CheckNum(V[39],0)
 CheckNum(V[40],47)
 CheckNum(V[35],79)

 CheckOut()

///////////////////////////////