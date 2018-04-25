

  fname = _clarg[1];


  if (fname @= "")  {
   fname = "wex.tsv";
  }


<<"%V $fname \n"

A= ofr(fname)

   Delc = -1; // WS
  R= readRecord(A,@del,Delc)
  
    cf(A);
    sz = Caz(R);

   ncols = Caz(R[0]);

<<"num of records $sz  num cols $ncols\n"