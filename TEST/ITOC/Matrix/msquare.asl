//%*********************************************** 
//*  @script msquare.asl 
//* 
//*  @comment test matrix funcs 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///

/*
ColSum()
V=ColSum(A)
returns array V - containing the sum of the columns of a 2D array.
dimensions [1][n_of_cols]
V->redimn() - would redimension to vector
//===================================//
RowSum()
V=RowSum(A)
returns array V - containing the sum of the columns of a 2D array.
dimensions [num_of_rows][1]
V->redimn() - would redimension to vector
//===================================//
*/

///
/// magic square
///
#include "debug.asl"

debugON()



chkIn(_dblevel)



//#define ASK ans=iread();
#define ASK ;


int A[>10]

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


chkStage("RowSum Test -summing rows of magic square 34");

 R= RowSum(A)
R->redimn()
<<"$R\n"


  for (i=0;i < 4; i++) {
   <<"<$i> $R[i] \n"
   chkN(R[i],34);

}
R->info(1)
 //  chkN(R[0],33);

 chkStage("RowSum")




chkStage("ColSum Test -summing cols of magic square 34");

 C= ColSum(A)
 C->redimn()
 CV= C

<<"$C\n"
//C->info(1)
  for (i=0;i < 4; i++) {
  <<"<$i> $C[i] $CV[i] \n"
   chkN(C[i],34);
  }


 chkStage("ColSum")

//chkOut();
//exit();


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
!a

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
<<"tsum of X \n"
<<"$X \n"

 V1 = Sum(A)
 <<"V1 $(Cab(V1))\n"
 <<"$V1\n"

 V = Sum( transpose(A) )
  <<"V $(Cab(V))\n"
<<"$V\n"

<<"$X[0] $X[1] $X[2] $X[3] \n"

<<"tsum $V \n"

<<"$V[0][0] $V[1][0] $V[2][0] $V[3][0] \n"

V->redimn()

<<"$V\n"

!a


   chkR(V[0],34,6)

   chkR(V[1],34,6)

   chkR(V[2],34,6)

   chkR(V[3],34,6)



  D= B

  D->Redimn(2,2,4)

<<"\n\tD\n%(2,\t[\s, ,\s]\n)$D \n "





 //D2[]= {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}
int  D2[]= {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(typeof(D2)) \n"
<<" $(Cab(D2)) \n"
<<"%v $D2 \n"

  D2->Redimn(4,4)
<<" $D2[0][0] \n"
<<"%V%(4, , ,\n)$D2 \n"

<<"\n"



float e[] = {1.1,2.2,3.3,4.4}

<<"%v$e\n\n"

 E = mdiag(e)

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


 A2[] = {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(typeof(A2)) \n"
<<" $(Cab(A2)) \n"
<<" $A2 \n"

<<" %(4,, ,\n)%2d$A2 \n"



float G[]= { 16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(typeof(G)) \n"
<<" $(Cab(G)) \n"
<<"%4.0f$G \n"


  chkOut()
