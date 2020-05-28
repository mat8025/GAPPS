// test circular convolve func
//
// h 3,2,1
// X 1,2,3,2,1
//
//
setdebug(1)



double h[4] = {1,2,3,4}
int X[5] = {5,6,7,8,9}


H = h

<<"%V$h\n"

<<"%V$X\n"


 cvec = lconvolve(H,X)

<<"%V$cvec\n"

<<"%V$H\n"





