//A=ofr("score")

A=ofr("testoutput")

n = 0
pass  = 0
fail = 0

svar col
svar S

#{
   S= readline(A)
<<" $(typeof(S)) \n"
<<" $S \n"

   S= readline(A)
<<" $(typeof(S)) \n"
<<" $S \n"
#}


   while( 1) {
   S= readline(A)
   if (check_eof(A) ) {
   <<"EOF \n"
     break
   }
   col = split(S)

    if (col[0] @= "DONE:") {
//<<" $(typeof(S))  $S \n"
<<"$S "
//<<"%V $col[0] \n"
      n += atoi(col[4])
      pass += atoi(col[8])
      fail += atoi(col[6])
    }
   }


 pcc = pass/(n * 1.0) * 100.0

 ve= split(version(),".")

// <<" $ve[1] $(periodicName(ve[1]))\n"

<<" $(version()) $(periodicName(ve[1]))  tests $n %V $fail $pass %6.2f$pcc\% \n\n"



A=ofr("ictestoutput")



  while (1) {

   S= readline(A)

   if (check_eof(A) )
     break

    col= split(S)
    if (col[0] @= "DONE:") {
   <<" $S "
      n += atoi(col[4])
      pass += atoi(col[8])
      fail += atoi(col[6])

    }


  }


 
 pcc = pass/(n * 1.0) * 100.0

 ve= split(version(),".")

// <<" $ve[1] $(periodicName(ve[1]))\n"

<<" $(version()) $(periodicName(ve[1]))  tests $n %V $fail $pass %6.2f$pcc\% \n\n"


STOP()