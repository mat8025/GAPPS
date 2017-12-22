///
/// magic square
///

CheckIn()

setdebug(0)

//#define ASK ans=iread();
#define ASK ;


int A[10+]

int B[] = {16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(Cab(B)) $(typeof(B)) \n"
<<"%V$B \n"

  B->Redimn(4,4)

<<"\n B[][] $(Cab(B)) \n"

  A = B

<<"B= %(4,\t<\s, ,\s>\n)%2d$B \n"

<<"A= %(4,\t{\s, ,\s}\n)%3d$A \n"

<<" $(Cab(A)) $(Cab(B)) \n"
<<" $(Caz(A)) $(Caz(B)) \n"
<<" $(typeof(A)) $(typeof(B)) \n"


 R= RowSum(A)
<<" ROW SUM\n"
<<"$R\n"

 C= ColSum(A)

<<" COL SUM\n"
<<"$C\n"

ASK

 M = Sum(A)

 <<"$M \n\n"

  D = A

<<"D= %(4,\t{\s, ,\s}\n)%3d$D \n"
<<" Transpose \n"

 C = Transpose(A)

<<"C= %(4,\t{\s, ,\s}\n)%3d$C \n"

// FIXME
<<"\n\tC\n%(4,\t\s,\s,\n)%5d${C} "

<<"\n"


<<" Sum $M \n"

sz  = Caz(A)
<<" %V$sz  $(Cab(A))\n"

<<"$A \n"


 V = Sum(A)
 
<<"$V \n"


 T= transpose(A)
<<"T \n"
<<"$T\n"
X= Sum(T)



 V = Sum( transpose(A) )


<<"tsum of X \n"
<<"$X \n"

<<"$X[0] $X[1] $X[2] $X[3] \n"

<<"tsum $V \n"

<<"$V[0][0] $V[1][0] $V[2][0] $V[3][0] \n"

V->redimn()




   CheckFNum(V[0],34,6)

   CheckFNum(V[1],34,6)

   CheckFNum(V[2],34,6)

   CheckFNum(V[3],34,6)



  D= B

  D->Redimn(2,2,4)

<<"\n\tD\n%(2,\t[\s, ,\s]\n)$D \n "





 D[]= {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(typeof(D)) \n"
<<" $(Cab(D)) \n"
<<"%v $D \n"

  D->Redimn(4,4)
<<" $D[0][0] \n"
<<"%V%(4, , ,\n)$D \n"

<<"\n"


ASK


float e[] = {1.1,2.2,3.3,4.4}

<<"%v$e\n\n"

 E = diag(e)

<<"%v$E \n"
//<<" $(Cab(E)) $(Caz(E)) \n"

<<"%(4,, ,\n)$E \n"

<<"\n %v$E[0][0] \n"
<<"\n %v$E[0][1] \n"
<<"\n %v$E[1][1] \n"
<<"\n %v$E[2][2] \n"
<<"\n %v$E[3][3] \n"

lw = E[0][::]

<<" $lw \n"


lw = E[1][::]

<<" $lw \n"


lw = E[0:1][::]

<<" $lw \n"


<<"\n %v${E[0][::]} \n"
<<"%I$A\n"
<<" $(typeof(A)) $(Caz(A)) \n"
// already declared -- no error ??
//int A[] 
<<"%I$A\n"
<<" $(typeof(A)) \n"


 A[] = {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(typeof(A)) \n"
<<" $(Cab(A)) \n"
<<" $A \n"

<<" %(4,, ,\n)%2d$A \n"



float G[]= { 16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(typeof(G)) \n"
<<" $(Cab(G)) \n"
<<"%4.0f$G \n"


  CheckOut()

stop!
