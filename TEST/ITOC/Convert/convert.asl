//%*********************************************** 
//*  @script convert.asl 
//* 
//*  @comment test Convert vec SF 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.100 C-He-Fm]                               
//*  @date Sun Dec 27 21:34:29 2020 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


/*
     REQ 18 {
               VMF   ---- I->op()   modifys I
                          I<-op()   modifys I
                          I-|op()   returns result of the operation leaves I unmodified
                          J = I->op()
            }
*/



int A[] = { 1,2,3,4,5,6 }

//<<"%I $(typeof(A)) $(Caz(A))\n"
<<"$A\n"

chkN(A[1],2)
   A->Convert(FLOAT_)

<<"%I $(typeof(A)) $(Caz(A))\n"
chkR(A[1],2.0)
<<"$A\n"

   A->Convert(DOUBLE_)

<<"%I $(typeof(A)) $(Caz(A))\n"
chkR(A[1],2.0)
<<"$A\n"

   A->Convert(SHORT_)

<<"%I $(typeof(A)) $(Caz(A))\n"
chkN(A[1],2)
<<"$A\n"

chkOut()




//   do the vector operation using copy of the vector -- and return the result
//
//   A<-Convert(FLOAT)
//   A-|Convert(FLOAT)
//   B=<A->Convert(FLOAT)
//     B= A|->Convert(FLOAT)

