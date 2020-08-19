// BUG 89 prepost vec
chkIn()

AV= vgen(INT_,10,0,1)

<<"$AV\n"

chkN(AV[1],1)
//setdebug(1,"trace")
 ++AV;

<<"$AV\n"

chkN(AV[1],2)


 BV= ++AV

<<"B= ++AV => $BV"

chkN(AV[1],3)

chkN(BV[1],3)

<<"AV is $AV\n"

 AV--;

chkN(AV[1],2)

<<"after AV-- : $AV\n"

 --AV;

<<"after --AV : $AV\n"

chkN(AV[1],1)

chkOut()
exit()

