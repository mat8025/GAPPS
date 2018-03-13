///
///  Records
///
///



// test record type
// each record is an Svar

SetDebug(1,"trace")

CheckIn()


Record DF[10];
today = date(2);

//S = Split("$today,0,10,0,0,0,0,0,0,0", 44);  // TBF CRASH

//S = Split("$today 0 10 0 0 0 0 0 0 0");

S = Split("$today,0,10,0,0,0,0,0,0,0", ",");  // TBF CRASH

<<"$S\n"

<<"$S[2]\n"



DF[0] = Split("$today,0,10,0,0,0,0,0,0,0",",");



//DF[0] = Split("$today 0 10 0 0 0 0 0 0 0");

<<"$DF[0]\n"
DF[1] = Split("$today,0,10,0,0,0,0,0,0,0",",");

<<"$DF[1]\n"




int I[];

sz= Caz(I);

<<"I %V$sz \n"

I[1] = 4;

svar SV[10];

sz= Caz(SV);

<<"SV %V$sz \n"

SV[2]  = "cheers";

record R[10];

sz = Caz(R)


<<"R %V$sz\n";


str sr0;
str fr0;
str sr1;

//record R[]; // TBF


//exit()


/{
// how many cols ??
 svar S;

 S= Split("how many cols in this record?")

 <<"$S[0] $S[1]\n"

 sr0 = S[2];
 fr0 = S[3]'
 
<<"%V$sr0 $fr0\n"

 W = S


 <<"$W[0] $W[1]\n"
/}


 R[0] = Split("how many cols in this record?")

<<"in record[0] we have:-  $R[0] \n"


 sr0 = R[0][0];
 <<"%V$sr0\n"

checkStr(sr0,"how")

   sr0 = R[0][2]

checkStr(sr0,"cols")
 <<"%V$sr0\n"




 R[3] = Split("just concentrate focus and move ahead")
// fix the number of cols ?? - for an ascii table

<<"inrecord[3] we have:- $R[3] \n"

   sr1 = R[3][2]
   
   checkStr(sr1,"focus")

 R[2] = R[3];   // TBF

<<"inrecord[2] we have the same:- $R[2] \n"

<<"inrecord[2][1] we have :- $R[2][1] \n"
<<"%V $R[2][2] \n"
<<"%V $R[2][0] \n"

 sr0 = R[0][0];
 <<"%V$sr0\n"

 checkStr(R[0][0],"how")

   sr2 = R[2][2]
   
checkStr(sr2,"focus")

   sr3 = R[3][2]
   
checkStr(sr3,"focus")

checkStr(sr3,sr2)


<<"inrecord[3] we have:- $R[3] \n"

checkStr(R[2],R[3])

<<"inrecord[2] we have:- $R[2] \n"


 R[4] = "what is going on here"

<<"in R[4] we have: $R[4]\n"



// svar fr0;

// select the record and the field
   
   fr0 = R[3][2];
   
 <<"%V $fr0  \n"

   sr0 = R[3][3]

checkStr(sr0,"and");

   sr1 = R[3][4]


 <<"%V $fr0 $sr0 $sr1\n"
checkStr(sr1,"move")

checkProgress()

<<"%V$R[3]\n"
<<"inserting muy bien into R[3][4]\n"

   R[3][4] = "muy bien";

<<"%V$R[3]\n"


   sr1 = R[3][4]


 <<"%V $fr0 $sr0 $sr1\n"

   sr3 = R[3][3]

checkStr(sr3,"and");

checkStr(sr1,"muy bien");

checkProgress();

eh = R[3][-1]
  
<<"%V$eh \n"

ah = R[-1][1]
  
<<"%V$ah \n"


exit()




//  set the record and the field
<<"in %V$R[3]\n"

   R[5][4] = R[3][2];

// this will have to expand record 5 -- currently with no fields
// to 6 fields and  set the 6th

<<"in %V$R[5]\n"

   R[5][0] = R[2][1];

<<"in %V$R[5]\n"

   R[5][1] = R[2][0];

<<"in %V$R[5]\n"
   
<<" so now want to access the 2nd and 4th fields of R[3] \n"



<<" %V$R[3]\n"

   fr3 = R[3][2]
   
 <<"%V $fr3  \n";

sr3 = R[3][4]

 <<"%V $sr3 \n"






R[7] = R[5];

<<"$R[7]\n"

<<"now in record[7][0] we have $R[7][0] \n"
<<"now in record[7][1] we have $R[7][1] \n"

   R[7][1] = "that"

<<"now in record[7] we have $R[7] \n"

<<"now in record[7][0] we have $R[7][0] \n"
<<"now in record[7][1] we have $R[7][1] \n"

//
<<" trying subscript ops !! \n"
<<"now in record[7][0:4] we have $R[7][0:4] \n"


CheckOut()
   exit()


     
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
