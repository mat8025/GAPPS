A= 0

////////////////// READ CEX DATA ///////////////////
k = 0

<<"#date\t\twtam\twtpm\tCarbCnt\tW	H	R	C	S	G	WEX\tBpress\n"

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
   j = 1

   wtam = atof(col[j++])
   wtpm = atof(col[j++])
   carb = atof(col[j++])
   walk =  atof(col[j++])
   hike =  atof(col[j++])
   run =  atof(col[j++])
   cycle =  atof(col[j++])
   wex = atof(col[j++])
   bpress =  atof(col[j++])


<<"$day %6.2f \t$wtam\t$wtpm\t$carb\t$walk\t$hike\t$run\t$cycle\t0.0\t0.0\t$wex\t$bpress\n"

   }
   else {

<<"$S"

   }

   }


  }

