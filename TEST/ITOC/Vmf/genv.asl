/* 
 *  @script genv.asl 
 * 
 *  @comment test vmf generate/fill vector 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.8 C-Li-O]                                  
 *  @date Tue Jan 12 10:10:20 2021 
 *  @cdate 1/1/2012 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
///
///
///

chkIn(_dblevel)
int I[]

I->info(1)

  I[0:8]->Set(0,1)
chkN(I[1],1)

<<" $I \n"

I->info(1)



  I[0:30]->Set(0,3)


<<" $I \n"

I->info(1)



sz = I->Caz()

//<<" $(I->Caz()) \n"

<<" $sz \n"

float F[]

<<"%v $F \n"
  j = 30
  F[0:j]->Set(0)

  F[1:j:3]->Set(1,2)

chkR(F[1],1)
chkR(F[4],3)

<<" $F \n"


  R= Urand(30)
  <<"$R\n"
  F[0:j:3]->Rand(3.0)


<<"\n//////\n $F \n"
chkOut()