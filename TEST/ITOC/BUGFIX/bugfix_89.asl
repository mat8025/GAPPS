// BUG 89 prepost vec
checkIn()

AV= vgen(INT_,10,0,1)

<<"$AV\n"

checkNum(AV[1],1)
//setdebug(1,"trace")
 ++AV;

<<"$AV\n"

checkNum(AV[1],2)


 BV= ++AV

<<"B= ++AV => $BV"

checkNum(AV[1],3)

checkNum(BV[1],3)

<<"AV is $AV\n"

 AV--;

checkNum(AV[1],2)

<<"after AV-- : $AV\n"

 --AV;

<<"after --AV : $AV\n"

checkNum(AV[1],1)

checkout()
exit()

