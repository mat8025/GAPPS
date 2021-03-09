A= 0

////////////////// READ CEX DATA ///////////////////
k = 0


int wt

  while (1) {

   S= readline(A)

   if (check_eof(A) )
     break

   if (slen(S) > 5) {

    col= split(S)

   if (!scmp(S,"#",1)) {


    if (col[0] @= "WEX") {

     wtam = atof(col[2])
     wtpm = atof(col[3])
     wt = wtam

     if (wtam > 0 && wtpm > 0) {
        if (wtpm < wtam) {
         wt = wtpm
//<<"XXX?  $wtam $wtpm $wt\n"
        }
     }

     pfvec = atof(col[4:-1])

//     <<"$col[0:1] $wt $col[4:-1]\n"
     <<"$col[0:1] $wt %4.0f$pfvec"

    }
   else {
    <<"$col[0:-1]\n"
   }

   }
   else {

if (col[1] @= "date") {
 <<"$col[0:1] weight $col[4:-1]\n"
}
else {
  <<"$S"
}

   }

   }


  }

