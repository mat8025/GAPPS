SetPCW(@compile)
SetDebug(1)

  S = { "hi" , "how" , "are", "you" ,"now", "?"}

 sz = Caz (S)
<<" $sz \n"
<<"<$S> \n"
<<" $S[0] \n"
<<" $S[2] \n"

 foota(S[2],S[3],S[1])

 SN = { "1", "2", "3", "4" ,"5"}

  sz = Caz(SN)

<<" %v $sz \n"

 i = Atoi(SN[2])

<<"%i $i \n"

<<" ${SN[*]} \n"
 r = Atof(SN[2])
<<"%i $r \n"

 r = Atof(SN[3])
<<"%i $r \n"

 r = Atof(SN[4])
<<"%i $r \n"

STOP!
