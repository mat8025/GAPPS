#/* -*- c -*- */

//  
set_debug(0)
N= 20

   R= Dgen(N*N,1,1)

//   R= Fgen(25,1,1)

// make it work as Double if needed


 <<" $(typeof(R)) \n"

 <<"%v \n $R \n"

  Redimn(R,N,N)

// %r print by rows -- %10r - force fold every 10

 <<"%r%v%6.2f \n $R \n"

X= Mtrp(R)

<<"%v%6.1f \n $X \n"


<<"%v%6.1f \n $R \n"

X= Minv(R)

<<"%v%6.1f \n $X \n"

<<"%v%6.1f \n $R \n"



X = R

for (i= 0; i < 3; i++) {

  Y = Minv(X)
<<"$i \n\n"
<<"%v%6.1f \n $Y \n"
  X = R + 1

}



STOP!

  V=  Mtrp(R)


<<"%v%6.1f \n $V \n"

  T = Mtrp(V)

<<"%v%6.2f \n $T \n"








STOP("DONE \n")


