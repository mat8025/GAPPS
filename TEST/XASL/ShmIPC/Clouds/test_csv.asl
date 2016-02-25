

// check comma placement

fn = _clarg[1]
<<"$fn \n"
  A= ofr(fn)


//RS= readRecord(A,@del,',',@nrecords,120)

  RS= readRecord(A,@del,',')

b=Cab(RS)
<<"$b\n"

<<"$RS\n"