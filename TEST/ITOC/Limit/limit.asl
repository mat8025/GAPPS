//   
//  Limit
//

checkIn()

F= vgen(FLOAT_,20,-7,1)

<<"%6.1f$F \n"

F->limit(-5,5)


<<"%6.1f$F \n"
checkFnum(F[0],-5)

checkFnum(F[19],5)


a = 7;

<<"$a\n"

a->limit(0,2)

<<"$a\n"
checkNum(a,2);

b = -7;

<<"$a\n"

b->limit(0,2)

<<"$b\n"
checkNum(b,0);

checkOut()

exit()/