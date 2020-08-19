
Str msg = "HELLO"

<<"%V$msg \n"

Str msg2 = 'H'

<<"%V$msg2 \n"

char C[] 
 //   C = msg

  scpy(C,msg)

<<"%c$C[1] \n"

char wc = C[1]

<<"%V%c$wc \n"

 sc = sele(msg,1,3)

<<"%V$sc \n"


 sc = sele(msg,-3,3)

<<"%V$sc \n"

 sc = sele(msg,-3,4)

<<"%V$sc \n"



 sc = sele(msg,1,1)

<<"%V$sc \n"

 wc = pickc(msg,2)

<<"%V%c$wc \n"

 wc = pickc(msg,-1)

<<"%V%c$wc \n"

 wc = pickc("MARK",-1)

<<"%V%c$wc \n"

 wc = pickc("MARK",-2)

<<"%V%c$wc \n"

 wc = pickc(msg,-2)

<<"%V%c$wc \n"