//%*********************************************** 
//*  @script vec_cat.asl 
//* 
//*  @comment test concat of vecs 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Wed May  6 20:00:27 2020 
//*  @cdate Wed May  6 20:00:27 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
//
///
//  test vec cat expand ops

checkIn(_dblevel)

int M[]
int N[]
int P[]


  N= igen(20,0,1)

<<"$N \n"

 P= N

<<"$P \n"

  P[10] = 80


 P[30] = 47
  //P[31] = 93
P->info(1)
   checkNum(P[30],47)
  P[25] = 79
   checkNum(P[25],79)

<<"$P \n"

  M= igen(10,0,-1)

<<"$M \n"

  V = M @+ P

<<"$V \n"
V->info(1)

 checkNum(V[1],-1)
 checkNum(V[11],1)
 checkNum(V[39],0)
 checkNum(V[40],47)
 checkNum(V[35],79)

 checkOut()

///////////////////////////////