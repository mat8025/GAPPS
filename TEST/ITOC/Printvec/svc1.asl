
setdebug(0)

#int n

T = "Happy days are here again the skies above are clear again"

<<" $T \n"

  S= Split(T)

 n = Caz(S)

<<" $n $S[2] \n"


<<" $S \n"

   S[2]->cut()

<<" $S \n"

   S[3:6]->cut()

<<" $S \n"

;


