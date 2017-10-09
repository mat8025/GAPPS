
 CheckIn()

#{

           BUG 40 {
                  redeclaration -- no error
                  int A[]
                  float A[] -- no error??
           }

#}

//  if set it will go into adb
setdebug(1,"trace")

int A[6]  = { 1,2,4,9,8,6 }

<<"%V$A \n"
<<" $A \n"
<<" $(Caz(A)) $(typeof(A)) \n"

// error in first pass --- not in XIC

float  A[]  = { 3.14159, 2.71828, 0.707  };


<<" checking ERROR\n"


e = checkError()

<<" %V $e \n"


<<"float vec %V$A \n"



<<" $(getSiErrorName(e)) \n"

  CheckNum(e,28)

<<"%V $A \n"
<<" $A \n"
<<" $(Caz(A)) $(typeof(A)) \n"

CheckOut()

stop!
;