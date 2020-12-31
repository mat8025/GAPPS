// test circular convolve func
//
// h 3,2,1
// X 1,2,3,2,1
//
//


//opendll("math")

int h[>3] = {3,2,1}

int X[5] = {1,2,3,2,1}


H = h
<<"%V$h\n"

<<"%V$X\n"

int t[2] = {0,0}

// setp1 match length

n = X->Caz()

// setsize

<<"%V$n\n"

   h[4] = 0

// step 1
// flip h

h->reverse()

<<"%V$h\n"


//h =  t @+ h

//<<"%V$h \n"

// would like 
// h = h @+ {0,0}

int out[n]

for (j = 0; j < n; j++) {

//  v = h * X

//<<"%V$v\n"

//  s= Sum(v)

   s= Sum(h * X)

//<<"%V$s\n"

  h->rotate(-1)

//<<"%V$h\n"
  out[j] = s
 }

<<"%V$out\n"




 cvec = cconvolve(H,X)

<<"%V$cvec\n"



