
setdebug(1,"trace")
checkIn();

int L[24];

checkNum(L[0],0)
checkNum(L[23],0)
<<"$L\n"

L = 79;
checkNum(L[0],79)
checkNum(L[23],79)

<<"$L\n"


L = 0;

checkNum(L[0],0)
checkNum(L[23],0)

<<"$L\n"

L[5:8] = 1;

checkNum(L[0],0)
checkNum(L[23],0)
checkNum(L[5],1)
checkNum(L[8],1)

proc Hey(V)
{
<<"$V\n"

L= 17

<<"$L\n"

<<"$V\n"

V= 18

}






Hey(L)

<<"$L\n"

checkNum(L[0],18)
checkNum(L[23],18)
checkNum(L[5],18)

L= 80;

checkNum(L[0],80)
checkNum(L[23],80)
checkNum(L[5],80)

Hey(L)

<<"$L\n"

checkNum(L[0],18)
checkNum(L[23],18)
checkNum(L[5],18)


L[5:8] = 74;
<<"$L\n"

checkNum(L[5],74)


checkOut()

