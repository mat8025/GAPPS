
//   Svar emsg ;
   Svar kws ;
   Str keyw ;


 svar emsg = { "JAN", "FEB", "MAR", "APR" }  // init OK

// emsg = { "JAN", "FEB", "MAR", "APR" } //

<<"%V$emsg \n"

  kws = Split(emsg)

<<"%V$kws \n"

      keyw = kws[0]

<<"%V$keyw\n"



 stop!