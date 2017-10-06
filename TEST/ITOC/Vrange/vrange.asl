///
///  vrange
///


checkIn()
 F = Vgen(INT_,30,-10,1)

<<"$F \n"

 R = vrange(F,0,10,100,500);

<<"$R \n"

checkFnum(R[0],100)
checkFnum(R[29],500)


checkOut();