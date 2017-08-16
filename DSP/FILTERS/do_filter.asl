

  fn = _clarg[1];
<<" reading input data $fn\n"
  A= ofr(fn);
  if (A != -1) {
  X = ReadRecord(A,@type,FLOAT_,@ncols,1)
  cf(A)
  sz = Caz(X)
  dmn = Cab(X)
  nrows = dmn[0]

<<"%V$sz $dmn $nrows\n"

  }
  else {
<<"bad file \n"
   exit();
  }

short SO[];

  SO= X;
  
B=ofw("chord.pcm")
  w_data(B,SO)
  cf(B)

  fn = _clarg[2];
<<" reading filter coefs $fn\n"
  A= ofr(fn);
  if (A != -1) {
  H = ReadRecord(A,@type,FLOAT_,@ncols,1)
  cf(A)
  sz = Caz(H)
  dmn = Cab(H)
  nrows = dmn[0]

<<"%V$sz $dmn $nrows\n"

  }
  else {
<<"bad file \n"
   exit();
  }



<<"running the filter -- convolving filter ip response with input\n"


   Op= lconvolve (H,X);


  sz = Caz(X)
<<"%V$sz \n"
<<"$Op[0:10]\n";



  SO = Op;

B=ofw("chord_filtered.txt")
<<[B]"%(1,,,\n)$Op\n"

cf(B);

B=ofw("chord_filtered.pcm")
  w_data(B,SO)
  cf(B)