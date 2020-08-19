

A=ofr("testoutput")

n = 0
pass  = 0
fail = 0
<<"%V $A \n"
svar S

klines = 0


   nw = S->read(A)

<<"%v $nw \n"



<<"S[0] :  $S[0] \n"
<<"S[1] :  $S[1] \n"


  while (1) {

   nw = S->read(A)

   if (check_eof(A) )
     break

    if (S[0] @= "DONE:") {
   <<" $S \n"
      n += atoi(S[4])
      pass += atoi(S[8])
      fail += atoi(S[6])
    }

  }

<<"%V $n $pass $fail \n"


cfile(A)



