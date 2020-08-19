#/* -*- c -*- */

// test complex & dcomplex types
SetDebug(1)

CheckIn()

OpenDll("math")


cmplx a
cmplx b

  a->Set(2.5,0.5)

  b->Set(0.5,-1.0)

  c = a + b
<<"%V$a, $b\n"
<<"cmplx add  a + b\n"
<<"$c \n"
<<"cmplx sub  a - b\n"
  c = a - b
<<"$c \n"

<<"cmplx mul  a * b\n"
  c = a * b
<<"$c \n"

<<"cmplx div  a / b\n"
  c = a / b
<<"$c \n"


N = 10
cmplx A[N]

<<"$A \n"

<<"$(typeof(A)) $(Caz(A)) \n"

// FIX IC redundant ele/push_sivele

   A[5]->Set(0.55,0.69)

<<"$A \n"



   R=A->getReal() // real part

<<"%v$R \n"

   I=A->getImag() // get Imag part

<<"%V$I \n"
ttyin()

STOP!

    val = 0.1

    for (j = 1; j < 10; j++) {

     A[j]->Real(val)  // just real ele
     A[12]->Real(val)

     R=A->Real() // real part

     <<"%v $R[0:12] \n"

    val += 0.1
ttyin()
   }


   A->real(Sin(Fgen(N,0,0.1)))


   R = A->real(Cos(Fgen(N,0,0.1)))

<<" $(Caz(R)) \n"

  <<"\n%v $R[0:10] \n"
ttyin()

   R = A->Real(Sin(Fgen(N,0,0.1)))

<<" $(Caz(R)) \n"


  <<"\n%v $R[0:10] \n"

   A->Imag(4.0)      // imag vector set to zero

   I= A->Imag()     // get imag part

<<" $(Caz(I)) \n"
  <<"%v $I[0:10] \n"

<<"%v $A->Imag() \n"


<<"\n %v $A[0:10] \n"


   B = A

<<"\n %v $B[0:10] \n"

   C = A + B

<<"\n %v $C[0:10] \n"

   C = A - B

<<"\n %v $C[0:10] \n"

   C = A * B

<<"\n %v $C[0:10] \n"

   C = A / B

<<"\n %v $C[0:10] \n"






STOP!

   A[3] = {0.3,42.0}  

<<"\n %v $A[0:10] \n"


   A[3] = {0.3,42.0}  

<<"\n %v $A[0:10] \n"


   A[9] = {0.3,42.0}  

<<"\n %v $A[0:10] \n"






//  a = {1.0,0.5}
//  b = (0.5,-1.0}



  r= a->Set(1.0,0.5)

<<" %v $r \n"
  b->Set(0.5,-1.0)

<<"%v $(typeof(a)) \n"
<<"%v $(typeof(b)) \n"

  c= a + b

<<"%v $(typeof(c)) \n"

<<"%V $a $b $c \n"

<<" complex type - ops \n"




STOP!







   A[2]->imag (-0.5)  // just imag ele

   A[3] = {0.3,0.4}  



   A[0:20:2]->imag(5.0)      // imag subscripted part of vector set to zero


STOP("DONE")
float V[12]
j = 0
    V[j] = 3

<<" $V[0:10] \n"

    for (j = 1; j < 3; j++) {
    V[j] = j

<<" $V[0:10] \n"
    }
