// test circular convolve func
//
// h 3,2,1
// X 1,2,3,2,1
//
//
setdebug(1)

opendll("math")

//float h[3] = {3,2,1}
double h[4] = {3,3,2,1}

//int X[5] = {1,2,3,2,1}

//int X[5] = {1,2,3,2,1}

int X[5] = {5,5,5,5,5}


H = h
<<"%V$h\n"

<<"%V$X\n"


 cvec = lconvolve(H,X)

<<"%V$cvec\n"

<<"%V$H\n"


stop!


