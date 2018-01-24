///
///
///
setDebug(1,"keep")
   A= ofr("Stuff2Do.csv")

   R= readRecord(A,@del,',')

   sz = Caz(R);

   ncols = Caz(R[0])
   
<<"num of records $sz $ncols\n"

for (i = 0; i < sz;i++) {
<<"[${i}] $R[i]\n"
}

  sortcol = 2;
  startrow = 1;
  alphasort = 0;
  sortdir = -1;
  
  sortRows(R,sortcol,alphasort,sortdir,startrow)

<<"////////////\n"
for (i = 0; i < sz;i++) {
<<"[${i}] $R[i]\n"
}

