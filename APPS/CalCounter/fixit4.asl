///
///
///
setDEbug(1,"keep","trace")
filterDebug(1,"get_args","process_args")
 A=  ofr("foodtable.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }

   RF= readRecord(A,@del,',')
   cf(A);
  Nrecs = Caz(RF);

  Ncols = Caz(RF,0);



<<"num of records %V $Nrecs  num cols $Ncols  \n";


   for (i= 5; i >= 0; i--) {
       nc = Caz(RF,i);
<<"<$i> $nc  $RF[i] \n";
    }
/{
    for (i= Nrecs -10; i < Nrecs; i++) {
    nc = Caz(RF,i);
<<"<$i> $nc $RF[i] \n";
    }
/}
exit();