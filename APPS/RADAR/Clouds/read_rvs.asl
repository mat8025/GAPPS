
A=ofr("srv_dbz_all.csv")

    CW = readline(A)    // should be SRI


  RS= readRecord(A,@del,',',@nrecords,30720)


//<<"$RS \n"

  DBZ = RS[::][2]



  Redimn(DBZ,256,120)


<<"$DBZ\n"


opendll("image","plot")