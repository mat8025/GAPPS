

chkIn(_dblevel)



Str msg = "HELLO"

<<"%V$msg \n"

Str msg2 = 'H'

<<"%V$msg2 \n"

char C[>1] 
 //   C = msg
<<"%V$msg\n"
  scpy(C,msg)

<<"%c$C[1] \n"
chkStr(C,"HELLO")

char wc = C[1]

<<"%V%c$wc \n"

 sc = sele(msg,1,3)

<<"%V$sc \n"


 sc = sele(msg,-3,3)

<<"%V$sc \n"

 sc = sele(msg,-3,4)

<<"%V$sc \n"



 sc = sele(msg,1,2)

<<"sc <|$sc|> \n"
sc->info(1)
chkStr(sc,"EL")

 wc = pickc(msg,2)
 wc->info(1)
<<"%V%c$wc \n"

chkC(wc,'L');



 wc = pickc(msg,-1)

<<"%V%c$wc \n"

 wc = pickc("MARK",-1)

<<"%V%c$wc \n"

 wc = pickc("MARK",-2)

<<"%V%c$wc \n"

 wc = pickc(msg,-2)

<<"%V%c$wc \n"

chkT(1)
chkOut()

