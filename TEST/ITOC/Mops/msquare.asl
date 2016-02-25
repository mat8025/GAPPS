// magic square

//SetDebug(1)
CheckIn()


int B[] = {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}
<<" $(Cab(B)) \n"
<<"%v $(typeof(B)) \n"
<<"%v $(typeof(B)) \n"
<<" $(Cab(B)) \n"
<<"%v \n $B[*] \n"


  B->Redimn(4,4)
<<" $(Cab(B)) \n"
  A= B
<<"%v \n %4r $B[*] \n"
<<" $(Cab(A)) \n"
<<"%r $A \n"
 M = Sum(A)
 
<<"sum $M \n"
 V = Sum(mtrp(A))
<<"tsum $V \n"


 D[]= {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(typeof(D)) \n"
<<" $(Cab(D)) \n"
<<"%v $D \n"

  D->Redimn(4,4)
<<" $D[0][0] \n"
<<"%v \n %6.2f %4r $D \n"

<<"\n"
STOP!

 E= Diag(A)
<<" $E \n"

int A[] 
A = {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(typeof(A)) \n"
<<" $(Cab(A)) \n"
<<" $A \n"


float C[]= {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(typeof(C)) \n"
<<" $(Cab(C)) \n"
<<" $C \n"




STOP!