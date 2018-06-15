///
///  wed_foodlog
///
<<"in foodlog \n"

///////////////////////  read FPC_LOG ///////////////////////////////
#define DO_FOOD_LOG 0


if (DO_FOOD_LOG) {

   A=ofr("fpc_log.dat")

   S= readfile(A)
   cf(A)

   nlines = Caz(S)
   j = 0

 str fline

   first_k = 0 
   end_k = 0

   nfobs = 0

   for (j = 0 ; j < nlines; j++) {

   fline = S[j]

//DBPR"$j $fline \n"
   
    if (!scmp(fline,"#",1)) {

    col= split(fline)

    day = col[0]
    calcon = col[7]
    carbcon = col[2]

//DBPR"$j $day $calcon $carbcon\n"

    wday = julday(col[0]) 

   k = wday - sday

   if (!first_k) {
       first_k = k;
   }
   else {
       end_k = k
   }

   if (k >= 0) {

      CALCON[nfobs] = atof(col[7])
      CARBV[nfobs] = atof(col[2])
//DBPR"carb $CARBV[nfobs]\n"
      DFVEC[nfobs] = k
      nfobs++
   }
   }
 }
}

<<"out foodlog \n"

//------------------------------------------------------------\\


