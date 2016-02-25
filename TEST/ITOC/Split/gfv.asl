setdebug(0)

A=ofr("color_table")

S=readfile(A)

<<"%(1,\t, ,)$S"



<<"----------------------\n"


<<"$S[1]\n"


<<"$S[10]\n"

<<"----------------------\n"
<<"$S[0]\n"

setdebug(1)

   fv1 =S[0]->gfv(1)
   fv2 =S[0]->gfv(2,",")

<<"<$fv1> <$fv2> \n"

   fv0 =S[10]->gfv(0)
   fv1 =S[10]->gfv(1)
   fv2 =S[10]->gfv(2,",")

<<"<$fv0> <$fv1> <$fv2> \n"

