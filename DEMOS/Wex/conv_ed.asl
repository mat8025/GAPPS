A= 0

////////////////// READ CEX DATA ///////////////////
k = 0
<<"#date\t\twtam\twtpm\tW	H	R	C	WEX\tBpress\tCarbCnt\n"

  while (1) {

   S= readline(A)


   if (check_eof(A) )
     break

   if (slen(S) > 5) {
   if (!scmp(S,"#",1)) {
    col= split(S)
//     <<" $S "

      day = col[0]

      wday = julday(col[0]) 

   k++
   wtam = atof(col[1])
   wtpm = atof(col[2])
   rhwc =  atof(col[3])
   wex = atof(col[4])
   carb = atof(col[5])
   bpress =  atof(col[6])

<<"$day %6.2f \t$wtam\t$wtpm\t$rhwc\t0\t0\t0\t$wex\t$bpress\t$carb \n"
   }
   else {
<<"$S\n"
   }
   }

  }

