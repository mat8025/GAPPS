// it is too slow
// unless the operation is vectors - using C++ lib

N = 100

F= fgen (N,0,0.125)

float fsum = 0 

  for (i= 0; i < N ; i++) {

   fsum += F[i];

  }
 
<<"%V$N %$fsum  \n"