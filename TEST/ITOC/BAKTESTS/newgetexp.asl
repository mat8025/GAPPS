

 a = 3 * 5


<<" %v $a \n"

 c = a + 2

<<" %v $c \n"


int A[10]

    A[1] = 7 * c 

<<" $A[1] \n"

    A[2] = 8 +a

<<" $A[2] \n"

///////////  FIX XIC /////////////////////

 A[9] = 59 * A[1]

<<" $A \n"


Svar S

  S[0] = "how"

  S[1] = "why"

  S[2] = "what"


  s= S[1]
  t = "just a string"

<<" $S[*] \n" 

<<" $s \n"

<<"%I $s \n"

<<"%I $S \n"

<<"%I $t \n"
STOP!