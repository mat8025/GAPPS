///
/// split stereo into mono channels
///


 sfn= _clarg[1];

// assume 16 bit words
<<"$sfn\n"

 A= ofr(sfn);

  if (A ==-1) {
<<"file error $sfn \n"
   exit();
  }

stem = scut(sfn,-4);

<<"$stem \n";
stem = spat(stem,"Track ",1)
<<"$stem \n";

  R=rdata(A,SHORT_);

  sz= Caz(R);

<<" nwords read $sz\n";

<<"$R[0:10] \n";


B=ofw("sp30_${stem}.pcm")

  wcdata(SHORT_,B,R[0:-1:2])

cf(B);
/{
B=ofw("sp30_${stem}_r.pcm")

  wcdata(SHORT_,B,R[1:-1:2])

cf(B);
/}

exit();