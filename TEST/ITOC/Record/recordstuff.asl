///
///
///
setDebug(1,"keep")

filterDEbug(1,"~store","~findtokens","~convert","findncols")
   A= ofr("Stuff2Do.csv")

   R= readRecord(A,@del,',')

   sz = Caz(R);

   ncols = Caz(R[0])
   
<<"num of records $sz $ncols\n"

for (i = 0; i < sz;i++) {
<<"[${i}] $R[i]\n"
}



sz = Caz(R);

j = sz;



writeRecord(1,R)


<<"\n $R[7]  @ \n $R[2]\n"
insertRows(R,7,3,2)


for (i= 0; i < 13; i++) {
R[i][2] = "$i";
}

writeRecord(1,R)



<<"\n $R[3]  @ \n $R[8]\n"
insertRows(R,3,4,8)

writeRecord(1,R)


<<"\n 3 $R[3]  @ \n 12 $R[12]\n"

insertRows(R,3,4,12)

writeRecord(1,R)


<<"\n 3 $R[3]  @ \n 13 end of record\n"

insertRows(R,3,4,13)

writeRecord(1,R)


<<"\n 3 $R[3]  @ \n 0  start $R[0]\n"

insertRows(R,3,4,0)

writeRecord(1,R)




exit()



while (1) {


sz = Caz(R);

<<" add a row current %V$sz\n"

R[j] = R[1];

<<"$j $R[j] \n"

sz = Caz(R);

  j++;

<<"next ele $j size is now $sz $j \n"

//writeRecord(1,R)

ans=iread("again?")

   if (! (ans @="y")) {
   break;
   }
}

j = sz;



<<" add a row 2 past current \n"
R[sz+2] = R[1];

   sz = Caz(R);

<<"size is now $sz\n"

//writeRecord(1,R)

R[j] = R[1];

writeRecord(1,R)




for (i = 0; i < sz;i++) {
<<"[${i}] $R[i][2]\n"
}

for (i = 0; i < sz;i++) {
<<"[${i}] $R[i][3]\n"
}





/{

 T= R[0]

  T->sort()


<<" $T\n"


 T= R[2]

<<" $T\n"

  T->sort()


<<" $T\n"

/}

for (i = 0; i < sz;i++) {
<<"[${i}] $R[i]\n"
}

  sortRows(R,1,1,1,1)

<<"////////////\n"
for (i = 0; i < sz;i++) {
<<"[${i}] $R[i]\n"
}

<<"swaping rows 3 and 4 \n"

 swapRows(R,3,4)

for (i = 0; i < sz;i++) {
<<"[${i}] $R[i]\n"
}

<<"swoping cols 3 and 4 \n"

 swapCols(R,3,4)

for (i = 0; i < sz;i++) {
<<"[${i}] $R[i]\n"
}


   sz = Caz(R);

<<"size is now $sz\n"

a=9
b=10

   deleteRows(R,a,b)

   sz = Caz(R);

<<"deleted rows   $a to $b size is now $sz\n"


for (i = 0; i < sz;i++) {
<<"[${i}] $R[i]\n"
}


<<" add a column\n"


for (i = 0; i < sz;i++) {
ncols = Caz(R[i]);
<<"[${i}] $ncols\n"
R[i][ncols] = "T"

}


for (i = 0; i < sz;i++) {
ncols = Caz(R[i]);
<<"[${i}] $R[i] $ncols\n"
}

for (i = 0; i < sz;i++) {
ncols = Caz(R[i]);
<<"[${i}] $ncols\n"
R[i][ncols] = "E"

}

writeRecord(1,R)

int dvec[] = {1,2,4,6}

    deleteRows(R,dvec,4)

   sz = Caz(R);

<<"deleted rows  $dvec size is now $sz\n"


writeRecord(1,R)

// R[0:3:][2] = "HA" // TBF

for (i=0; i< sz; i++) {
 R[i][2] = "HA"
}


<<" $R[::] \n"

for (i=0; i< sz; i++) {
<<" $R[i][3] \n"
}


writeRecord(1,R)

   sz = Caz(R);

<<"size is now $sz\n"


<<" add a row \n"
R[sz] = R[1];

   sz = Caz(R);

<<"size is now $sz\n"

writeRecord(1,R)

j = sz;
<<" add a row 2 past current \n"
R[sz+2] = R[1];

   sz = Caz(R);

<<"size is now $sz\n"

writeRecord(1,R)

R[j] = R[1];

