

int I[]

<<" $I \n"

  I[0:8]->Set(0,1)


<<" $I \n"


  I[0:30]->Set(0,2)


<<" $I \n"
n = I->Caz()

//<<" $(I->Caz()) \n"

<<" $n \n"

float F[]

<<"%v $F \n"
  j = 30
  F[0:j]->Set(0)

  F[1:j:3]->Set(1,2)


<<" $F \n"

  F[0:j:3]->Rand(62)


<<" $F \n"

STOP!