
//setdebug(1)

A = 0


    R = ReadRecord(A,@type,FLOAT,@del,',')

     sz = Caz(R) ;  dmn = Cab(R)

   nrows = dmn[0]
   ncols = dmn[1]

//<<"%V$sz $dmn $nrows $ncols\n"

   T = R[::][0]
   BA = R[::][3]

 sz = Caz(T) ;  dmn = Cab(T)

//<<"%V$sz $dmn $T[0] \n"

 sz = Caz(BA) ;  dmn = Cab(BA)

//<<"%V$sz $dmn $BA[0] \n"

//  V = R[0:10][0,2,3]   // works can pick off cols


V = R[::][0,3]   // works can pick off cols
<<"%(2,, ,\n)6.3f$V \n"


//<<"%(4,, ,\n)6.3f$R[0:10][0:3] \n"


stop!

