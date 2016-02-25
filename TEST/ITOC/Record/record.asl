#/* -*- c -*- */

// test record type
// each record is an Svar

SetDebug(2)

CheckIn()

OpenDll("math")


record R[];


// how many cols ??


 R[0] = Split("how many cols in this record?")

// fix the number of cols ?? - for an ascii table


<<" $R[0] \n"

 R[3] = Split("just concentrate focus and move ahead")

<<" $R[3] \n"

 S=Split("just concentrate focus and move ahead")
<<" $S \n"

 V= S
<<" $V \n"

 T= R
<<" done rec ---> rec \n"
 sz = Caz(T)
<<"%v $sz \n"
<<" $T[0] \n"
//xzz*zz
<<" $T[0:3] \n"

 R[12] = Split("re-educate -- implement demo \n")

 R[13] = Split("audio pickup to phone \n")
 R[19] = Split("Build a ASL interface that provides \n")
 R[20] = Split("a natural language interface to SQL ? \n")

<<"\n\n%1r$R[13:23]\n"
// use a comma separator
<<"\n\n%1r%,a$R[13:23]\n"
// use a underlineseparator
<<"\n\n%1r%_a$R[13:23]\n"
// use a underlineseparator
<<"\n\n%1r%ta$R[13:23]\n"

// use a underlineseparator
<<"\n\n%1r%\ta$R[13:23]\n"

// pick fields
<<"\n\n%1r$R[13:23][0]\n"

STOP!



/////////  TBD //////////
// record is an array of svar --- each record has arbitary number of fields
// option to make it fixed
// dynamic realloc of record
// smart print of record
// indexing R[i][k]    where k is field (of the svar)
