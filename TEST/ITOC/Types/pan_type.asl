/////////////////////////////////////////

setdebug(1)
CheckIn()

setap(30)

pan a = 1.234567801012340001234567; 
pan b = -0.98765400000001; 
pan c = 1.234567801012340001234567;

<<"$a $(typeof(a)) \n"

<<"$b $(typeof(b)) \n"

<<"$c $(typeof(c)) \n"

CheckFNum(a,c,6)
CheckFNum(b,-0.987654000001,4)

CheckFNum(a,1.234567801012340001234567,6)

CheckFNum(a,1.234567801012340001234567,2)

CheckFNum(b,-0.987654000001,2)


CheckOut()

stop!









//  FIX Pan Arrays
pan P[500]


P[20] = 787
P[30] = 429




CheckNum(P[20],787)
CheckNum(P[30],429)

CheckOut()


