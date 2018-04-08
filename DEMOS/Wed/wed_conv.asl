// convert old style wed.dat



wed_dir = "./"


chdir(wed_dir)

wherearewe=!!"pwd "

A=ofr("wed.dat")

//<<"%V$wherearewe \n"
////////////////// READ CEX DATA ///////////////////


   S= readline(A)

   last_known_wt = 205

tl = 0


nobs = 0

  while (1) {

   S= readline(A)

   tl++

   if (check_eof(A) )
     break
   
   ll = slen(S)

//<<"$tl $S "

   if (ll < 10) {
        continue
   }

   if (!scmp(S,"#",1)) {

    col= split(S)

//    <<"$col \n"

    day = col[0]

    wday = julday(col[0]) 


   j = 1

   wtam = atof(col[j++])
   wtpm = atof(col[j++])
   carbc = atof(col[j++])

   walk =  atof(col[j++])
   hike = atof(col[j++]) 
   run = atof(col[j++]) 
   cycle =  atof(col[j++])
   swim =  atof(col[j++])
   yardwrk =  atof(col[j++])
   wex = atof(col[j++])
   bpress =  atof(col[j++])


DBPR"WEX   $day %6.1f$wtam $wtpm $walk $hike $run $cycle $swim $yardwrk $wex $bpress \n"
   if (carbc > 0) {
DBPR"CFPC  $day %6.1f$carbc 0.0 0.0 0.0\n"
   }
   nobs++

   }
   else {
DBPR"CMT   $S"
   }
  }

//<<"there were $nobs measurements \n"

