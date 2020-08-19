

svar S

 S[0] = "a b c z "
 S[1] = "c q k y "
 S[2] = "b p j x "



<<"%(1,\s,\s,\n)$S \n"


  S->join()
<<"$S\n"
sz = Caz(S)
<<"%V$sz \n"
  S->split()
sz = Caz(S)
<<"%V$sz \n"



<<"%(4,\s,\s,\s\n)$S \n"
key = 0
<<" now sort using %V$key\n"
  S->setNfieldsKey(4,key)

  S->sort()

<<"%(4,\s,\s,\s\n)$S \n"

key = 1
<<" now sort using %V$key\n"
  S->setNfieldsKey(4,key)

  S->sort()

<<"%(4,\s,\s,\s\n)$S \n"

key = 3
<<" now sort using %V$key\n"
  S->setNfieldsKey(4,key)

  S->sort()

<<"%(4,\s,\s,\s\n)$S \n"

svar N

 N[0] = "1 2 3 4 "
 N[1] = "47 -3 76 23 "
 N[2] = "-7 899 17 3 "

  N->join()
  N->split()


  N->setNfieldsKey(4,0)


 for (k =0 ; k < 4; k++) {
  N->sortNum(k)

<<"%(4,\t,\t,\n)$N \n"
<<"/////////////////\n"
 }
