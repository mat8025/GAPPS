
A = 0
ncols = 2


//opendll("stat")

R = ReadRecord(A,@type,FLOAT,@NCOLS,ncols)

     sz = Caz(R)

     dmn = Cab(R)

nrows = dmn[0]

<<"%V$nrows \n"

<<"%V$sz $dmn\n"

sz = Caz(R)

// check # cols

  YV = R[::][1]

  Redimn(YV)

<<"$YV \n"

  sz = Caz(YV)
<<"ysz $sz \n"

  // if want to exclude neg and 0
  MM= Stats(YV,">",0)
  // but we don't
  MM= Stats(YV)
<<"$MM \n"
stop!