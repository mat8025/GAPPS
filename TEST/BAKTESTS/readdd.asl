setdebug(1)



// read an record (all ascii fileds) to a RECORD variable

A=ofile("dd_04-19-2017","r+");

//R=ReadRecord("record.txt",@del,',',@comment,"")
R=ReadRecord(A,@del,','))


<<"$(typeof(R)) $(cab(R))\n"


<<"$R[0]\n"
<<"$R[1]\n"
<<"$R[2]\n"