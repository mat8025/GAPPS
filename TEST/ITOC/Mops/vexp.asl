#! /usr/local/GASP/bin/asl

// vector operation

  N = $2

 if (N @= "") {
<<" enter parameter value on command line -> e.g. \n ./sexp 10 \n"
 STOP!
  }

 OpenDll("math")

<<" you entered a value of $N \n"

 V = Fgen(N,0,0.1)

<<" $V \n"

 k = 0
 while ( k < 3 ) {
 V = V + 0.1

<<" %v $V \n"

 S = Sin(V)

<<" sin $S \n"

 C = Cos(V)

<<"cos  $C \n"

 R = S * C

<<" sin * cos $R \n"
 k++
 }

STOP!

///////////////////////////////
