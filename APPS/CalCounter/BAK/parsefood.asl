
// parse_foodtable

//<<"inc parseFoodTable\n"

proc parseFoodTable()
{
 str fline;

 k = 0;
 jf = 0;
 int err = 0;
 svar fdwords;

while (1) {

   fline = S[k]

   if (fline @="") {
        break;
   }

   k++

<<"rec $k $RF[k]\n"

   if (!scmp(fline,"#",1)) {

//<<"[${k}] $nlines %V$fline \n"



     fdwords = Split(fline,",");
//<<"$fdwords \n"

     Fdwords = Split(fline,",");
//<<"$Fdwords \n"

     fd = fdwords[0];
// <<"%V$fd \n"



    err= Fd[jf]->setval(fdwords)

//<<"ret setval $err\n"
//<<"trying print \n"
//   Fd[jf]->print()

    jf++

//<<"$k $jf <${fd}> $unit $amt $fat $cals $carbs $wt\n"
//i_read()

   if (err < 0) { 
       break;
   }

   }


  if (k >= (nlines-1))
     break;
 }
      return jf;
}

//<<" we have $jf foods \n"
   //listFoods(jf)
//////////////////////////////////////////////////////
