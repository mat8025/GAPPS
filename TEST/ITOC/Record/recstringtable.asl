//
///  Record as a string table
///
///



// test record type
// each record is an Svar

SetDebug(1,@keep)

N= 258

Record ST[N];

for (i= 0; i< N; i++) {
   ST[i][0] = "<$i>"
}


<<"$ST[2][0]\n"


<<"$ST[::]\n"

val = "<79>"

for (i= 0; i< N; i++) {
  if (ST[i][0] @= val) {
  <<"found Au here $i\n"
     break;
  }
}


