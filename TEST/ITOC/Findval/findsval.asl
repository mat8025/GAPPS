
setdebug(0)

V = "hey buddy  have you heard the news lulu is back in town  ready to go ready to move"

<<" $V \n"

  C= Split(V)

<<" $C[0:5] \n"


 K = C->findVal("ready",0,1,1)

<<" $K \n"


 C->cut(K);

<<" $C \n"

 K = C->findVal("aargh",0,1,1)

<<" $K \n"

;