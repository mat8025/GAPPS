

#{
     REQ 18 {
               VMF   ---- I->op()   modifys I
                          I<-op()   modifys I
                          I-|op()   returns result of the operation leaves I unmodified
                          J = I->op()
            }
#}



int A[] = { 1,2,3,4,5,6 }

<<"%I $(typeof(A)) $(Caz(A))\n"
<<"$A\n"


   A->Convert("FLOAT")

<<"%I $(typeof(A)) $(Caz(A))\n"

<<"$A\n"

   A->Convert(FLOAT)

<<"%I $(typeof(A)) $(Caz(A))\n"

<<"$A\n"

//   do the vector operation using copy of the vector -- and return the result
//
//   A<-Convert(FLOAT)
//   A-|Convert(FLOAT)
//   B=<A->Convert(FLOAT)
//     B= A|->Convert(FLOAT)

stop!