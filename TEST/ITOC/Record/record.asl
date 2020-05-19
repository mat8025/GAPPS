//%*********************************************** 
//*  @script record.asl 
//* 
//*  @comment test recA=rec5 use 
//*  @release CARBON 
//*  @vers 1.36 Kr Krypton                                                
//*  @date Sat Jan 19 06:45:00 2019 
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///  Record
///
///



// test record type
// each record is an Svar
checkIn(_dblevel)


  Record R[>4];


  Nrecs = Caz(R);
  Ncols = Caz(R,1);

<<"num of records $Nrecs  num cols $Ncols\n";

recinfo = info(R);
<<"$recinfo \n"


 R[0] = Split("80,1,2,3,40,5,6,7,8,9",',');
 R[1] = Split("82,5,4,3,40,5,6,7,8,9",',');
 R[2] = Split("83,7,6,5,40,5,6,7,8,9",',');
 R[3] = Split("84,8,7,6,40,5,6,7,8,9",',');
 R[4] = Split("85,9,8,7,40,5,6,7,8,47",',');
 R[6] = Split("87,9,8,7,40,5,6,7,8,79",',');


<<" $R[::] \n"


  Nrecs = Caz(R);
  Ncols = Caz(R,1);

<<"num of records $Nrecs  num cols $Ncols\n";

 recinfo = info(R);
 <<"$recinfo \n"




<<"%V$R[0]\n"

<<"%V$R[0][2]\n"
<<"%V$R[0][4]\n"


int ival = atoi(R[0][2]);
sz  = csz(ival)
<<"ival $ival  bounds $(Cab(ival)) sz   $(csz(ival))\n"
checkNum(sz,0)
checkNum(ival,2)


//=============================
 R[5] = R[1];

<<"%V$R[5]\n"
<<"%V$R[5][2]\n"
fval = atoi(R[1][2]);
ival = atoi(R[5][2]);
ival->info(1)
checkNum(ival,fval)


<<"%V$R[3]\n"
R[3][3]=R[2][3]
<<"%V$R[3]\n"

<<"%V$R[2][3]\n"
<<"%V$R[3][3]\n"

fval = atoi(R[2][3]);
ival = atoi(R[3][3]);

checkNum(ival,fval)



 R[2] = R[0];

<<"%V$R[2]\n"

<<"%V$R[2][2]\n"

  sz = Caz(R);
  <<"%V$sz\n"

ival = atoi(R[2][2]);
sz  = csz(ival)
<<"ival $ival  bounds $(Cab(ival)) sz   $(csz(ival))\n"

checkNum(sz,0)
checkNum(ival,2)

<<"%V$R[2][4]\n"

ival = atoi(R[2][4]);


pval = ptan("Zr");

<<"%V $pval \n"
checkNum(ival,pval)
checkNum(ival,ptan("Zr"))

<<" $R[::] \n"

deleteRows(R,2,4)

<<" $R[::] \n"

deleteRows(R,1,-1)

<<" $R[::] \n"


recinfo = info(R);
<<"$recinfo \n"

 R[1] = Split("82,5,4,3,40,5,6,7,8,29",",");
 R[2] = Split("83,7,6,5,40,5,6,7,8,30",",");
 R[3] = Split("84,8,7,6,40,5,6,7,8,31",",");
 R[4] = Split("85,9,8,7,40,5,6,7,8,32",",");
 R[6] = Split("87,9,8,7,40,5,6,7,8,33",",");

<<" $R[::] \n"

deleteRows(R,1,-1)

recinfo = info(R);
<<"$recinfo \n"

<<" $R[::] \n"

 R[1] = Split("82,5,4,3,40,5,6,7,Sn,50",",");
 R[2] = Split("83,7,6,5,40,5,6,7,Sb,51",",");
 R[3] = Split("84,8,7,6,40,5,6,7,Te,52",",");
  R[7] = Split("84,8,7,6,40,5,6,7,I,53",",");

<<" $R[::] \n"

recinfo = info(R);
<<"$recinfo \n"




//////////////////////////////////////////


 R[1] = Split("10,12,23,34,45,56,67,78,89,90",",");

<<"%V$R[1]\n"
<<"%V$R[1][4]\n"

ival = atoi(R[1][4]);
sz  = csz(ival)
<<"ival $ival  bounds $(Cab(ival)) sz   $(csz(ival))\n"

checkNum(sz,0)
checkNum(ival,45)

ival = atoi(R[1][5]);
checkNum(ival,56)


 R[3] = R[0];

<<"3 == 0 %V$R[3]\n"


<<"[3][4] $R[3][4] \n"

<<"%V$R\n"


<<"%V$R[3][4]\n"

ival = atoi(R[3][4]);
<<"%V $ival\n"
checkNum(ival,40)


ival = atoi(R[3][5]);
<<"%V $ival\n"
checkNum(ival,5)

////////////////////////////////////////////////////
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

//record R[10];

sz = Caz(R)


<<"R %V$sz\n";


str sr0;
str fr0;
str sr1;

//record R[]; // TBF





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


 R[0] = Split("how many cols are in this record?")

<<"in record[0] we have:-  $R[0] \n"

<<"col0 $R[0][0] \n"
<<"col1 $R[0][1] \n"


 sr0 = R[0][0];
 <<"%V$sr0\n"

checkStr(sr0,"how")

<<"col2 $R[0][2] \n"

   sr0 = R[0][2]

checkStr(sr0,"cols")
 <<"%V$sr0\n"


<<"%V $R[0][1] \n"

 checkStr(R[0][1],"many")

  sr1 = R[0][1];

<<"$(typeof(sr1)) %V $sr1 \n"
 checkStr(sr1,"many")
 



   sr2 = R[0][2];

checkStr(sr2,"cols")
 <<"$(typeof(sr2)) %V$sr2\n"




 R[1] = Split("can we have blank records?")

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
 R[2][2] = "learn"

 sr0 = R[0][0];
 <<"%V$sr0\n"

 checkStr(R[0][1],"how")

 sr1 = R[0][0];
 
 <<"%V$sr1\n"



   sr2 = R[2][2]
   
checkStr(sr2,"focus")

   sr3 = R[3][2]
   
checkStr(sr3,"focus")

checkStr(sr3,sr2)


<<"inrecord[3] we have:- $R[3] \n"

checkStr(R[2],R[3])

<<"inrecord[2] we have:- $R[2] \n"


 R[4] = Split("and what is going on here")

<<"in R[4] we have: $R[4]\n"



// svar fr0;

// select the record and the field
   
   fr0 = R[3][2];
   
 <<"%V $fr0  \n"

   sr0 = R[3][3]

checkStr(sr0,"and");

   sr1 = R[3][4]


fpat = searchRecord( R, "and")

<<" $(typeof(fpat)) $(Cab(fpat)) \n"

<<" $R[::] \n"

row = fpat[0][0];
col = fpat[0][1];

<<"%V $row $col\n"
<<" $R[row] \n"


for (k=0; k <3; k++) {
<<"$k $fpat[k][0] $fpat[k][1]\n"
}

fpat = searchRecord( R, "sand")

row = fpat[0][0];
col = fpat[0][1];

<<"%V $row $col\n"
<<" $R[row] \n"

<<" $(typeof(fpat)) $(Cab(fpat)) \n"
nf = Cab(fpat)

for (k=0; k <nf[0]; k++) {
<<"$k $fpat[k][0] $fpat[k][1]\n"
}


fpat->redimn();
<<"$fpat\n"


fpat = searchRecord( R, "blank")

//for (k=0; k <5; k++) { // TBF crashes if out of bounds
for (k=0; k <1; k++) {
<<"$k $fpat[k][0] $fpat[k][1]\n"
}




 <<"%V $fr0 $sr0 $sr1\n"
checkStr(sr1,"move")

//checkProgress()

<<"%V$R[3]\n"
<<"inserting muy bien into R[3][4]\n"

   R[3][4] = "muy bien";

<<"%V$R[3]\n"


   sr1 = R[3][4]


 <<"%V $fr0 $sr0 $sr1\n"

   sr3 = R[3][3]

checkStr(sr3,"and");

checkStr(sr1,"muy bien");

//checkProgress();
<<"0 $R[0]\n"
<<"1 $R[1]\n"
<<"3 $R[3]\n"


// R->getNcols(3) - 1;
//eh = R[3][-1]  // won't work now

ncols = Caz(R)
<<"%V$ncols\n"
<<"$R[0]\n"
ncols = Caz(R[0])
<<"R[0] %V$ncols\n"

<<"$R[3]\n"
ncols = Caz(R[3])
<<"R[3]%V$ncols\n"

nb = Cab(R)
<<"%V$nb\n"


eh = R[3][1]
  
<<"%V$eh \n"

ah = R[-1][1]
  
<<"%V$ah \n"







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
<<"$R[12]\n"
 R[13] = Split("audio pickup to phone \n")
<<"$R[12:13]\n"


 R[19] = Split("Build a ASL interface that provides \n")
 R[20] = Split("a natural language interface to SQL ? \n")


<<"$R[12:19]\n"

<<"\n%(1,,,,\n)$R[13:19]\n"
// use a comma separator




//<<"\n\n%1r%,a$R[13:23]\n"
// use a underlineseparator
//<<"\n\n%1r%_a$R[13:23]\n"
// use a underlineseparator
<<"\n\n%1r%ta$R[13:23]\n"

// use a underlineseparator
//<<"\n\n%1r%\ta$R[13:23]\n"

// pick fields
//<<"\n\n%1r$R[13:23][0]\n"

checkOut()



/////////  TBD //////////
// record is an array of svar --- each record has arbitary number of fields
// option to make it fixed
// dynamic realloc of record
// smart print of record
// indexing R[i][k]    where k is field (of the svar)
