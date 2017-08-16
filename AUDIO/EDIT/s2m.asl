///
/// split stereo into mono channels
///


 sfn= _clarg[1];

// assume 16 bit words


 A= ofr(sfn);

  if (A ==-1) {
<<"file error $sfn \n"
   exit();
  }

  R=rdata(A,SHORT_);

  sz= Caz(R);

<<" nwords read $sz\n";

<<"$R[0:10] \n";


B=ofw("left")

  wcdata(SHORT_,B,R[0:-1:2])

cf(B);

B=ofw("right")

  wcdata(SHORT_,B,R[1:-1:2])

cf(B);


exit();