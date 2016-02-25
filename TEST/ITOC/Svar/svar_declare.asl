#  

setdebug(1)

checkIn()

Mol = ( "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" ) ;


<<"$Mol \n"
<<"$(caz(Mol))\n"
<<"$(typeof(Mol))\n"


sz = caz(Mol)

checkNum(sz,12)
<<"$Mol[0]\n"

<<"$Mol[1]\n"


le = Mol[0]

<<"$(typeof(le)) %V$le\n"

checkStr(le,"JAN")

checkStr(Mol[0],"JAN")

checkStr("FEB",Mol[1])


Svar Mo[] = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" }

sz= Caz(Mo)

<<" %V$sz \n"

<<"$Mo[0] \n"

<<"$Mo[1] \n"



for (i = 0; i < 12 ; i++) {

<<"$i $Mo[i] \n"

}



checkStr(Mo[0],"JAN")

checkStr(Mo[11],"DEC")

checkOut()


stop!