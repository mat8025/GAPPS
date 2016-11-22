#  

setdebug(1)

checkIn()

Mol = ( "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" ) ;

<<"List is $Mol \n"
<<"$(caz(Mol))\n"
<<"$(typeof(Mol))\n"

sz = caz(Mol)

checkNum(sz,12)
<<"$Mol[0]\n"

<<"$Mol[1]\n"


le = Mol[0]

<<"$(typeof(le)) %V$le\n"

checkStr(le,"JAN")

<<"le checked\n"

checkStr(Mol[0],"JAN")

<<"Mol[0] checked\n"


checkStr("FEB",Mol[1])

<<"$Mol[1] Mol[1] checked\n"

checkStr(Mol[1],"FEB")

le = Mol[1]

checkStr(le,"FEB")

Svar Mo[] = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" }
//Svar Mo = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" }


<<" Mo $(typeof(Mo)) \n"

sz= Caz(Mo)

<<" Mo %V$sz \n"

<<"$Mo[0] \n"

<<"$Mo[1] \n"

for (i = 0; i < 12 ; i++) {

  <<"$i $Mo[i] \n"

}

checkStr(Mo[0],"JAN")

checkStr(Mo[11],"DEC")


int A[] = {0,1,2,3,4,5,6,7,8}

<<"$A\n"

<<"sz $(Caz(A)) cab $(Cab(A))\n"

checkNum(A[1],1)
checkNum(A[8],8)





checkOut()


stop!