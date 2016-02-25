
setdebug(0)

int n = 4




V1 = "Happy days are here again- \n \
\tthe skies above are clear again \n\
\tSo let's sing a \vsong of cheer again \n\
\tHappy days are here again \n";

<<"%s $V1\n"




V2 = "                       \n\
      Altogether shout it now \n\
      There's no one Who can doubt it now \n\
      So let's tell the world about it now \n\
      Happy days are here Again!\n" ;

<<" $V2 \n"


T = V1 @+ V2


<<" $T \n"

;

 //S->split()

  S= Split(T)
// contains each word

 n = Caz(S)

<<" $n $S[2] \n"

  L= Split(T,"\n")
// contains each line

 n = Caz(L)

<<" $n $L[2] \n"

<<" last line $L[-1] \n"



stop!

<<" $S \n"



   S[2]->cut()

//<<" $S \n"

<<"  $S[0:5] \n"



  S[4,5,6]->cut()

<<"  $S[0:5] \n"




//<<"  $S \n"

//iread(":)")

// cut out every other line

  S[0:-1:2]->cut()

<<"  $S \n"

<<" /////////////// \n"

;


