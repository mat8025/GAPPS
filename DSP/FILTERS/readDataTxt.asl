
  fn = _clarg[1];

  A= ofr(fn);
  if (A != -1) {
  R = ReadRecord(A,@type,FLOAT_,@ncols,1)

  sz = Caz(R)
  dmn = Cab(R)
  nrows = dmn[0]

<<"%V$sz $dmn $nrows\n"
  }
  else {
<<"can't read $fn\n";

  }

