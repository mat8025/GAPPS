///
///
///


//  get the sp30 stereo  file

  fn = _clarg[1];
<<" reading input data $fn\n"

  A= ofr(fn);
  if (A != -1) {
  R = rdata(A,SHORT_);
  //X = ReadRecord(A,@type,FLOAT_,@ncols,1)
  cf(A)
  sz = Caz(R)
  dmn = Cab(R)

<<"%V$sz $dmn \n"

  }
  else {
<<"bad file \n"
   exit();
  }



stem = scut(fn,-4);
<<"$stem \n";
stem = spat(stem,"Track ",1)
<<"$stem \n";


  S= R[0:-1:2];

// now have mono track -- maybe left?



/{
  float X[];

  X = S;
  
  sz = Caz(X)
  dmn = Cab(X)


<<"%V$sz $dmn \n"
<<"$X[0:19]\n"
/}

// read in the fir_lowpass impulse coeffs

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

//   convolve the signal with the desired lowpass impulse response


<<"running the filter -- convolving filter ip response with input\n"

/{
   Op= lconvolve (H,S);
  sz = Caz(Op)
<<"%V$sz \n"
<<"$Op[0:10]\n";
/}

short Sop[];

  //Sop = round(Op);
  Sop= round(lconvolve (H,S));
<<"$Sop[0:10]\n";


//   write out the   lowpassed signal

  sz = Caz(Sop)
<<"%V$sz \n"

//  now we want to down sample to 16 kHz rate
//  every 16Khz interval --- interpolate between nearest 44100 samples
//  could pad vec out so exact 44100/16000 factor

  int nsz = sz/44100.0 * 16000;

  Rop = vzoom(Sop,nsz);

  Sop = Round(Rop);


  sz = Caz(Sop)
<<"%V$sz \n"

  B=ofw("sp30_16K_${stem}.pcm")
  w_data(B,Sop)
  cf(B);





