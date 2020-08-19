

#{

           BUG 40 {
                  redeclaration -- no error
                  int A[]
                  float A[] -- no error??
           }

#}


int A[6]  = { 1,2,4,9,8,6 }

<<"%I $A \n"
<<" $A \n"
<<" $(Caz(A)) $(typeof(A)) \n"


float  A[]  = { 3.14159, 2.71828, 0.707  }

<<"%I $A \n"
<<" $A \n"
<<" $(Caz(A)) $(typeof(A)) \n"
