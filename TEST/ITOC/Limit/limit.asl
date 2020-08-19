//   
//  Limit
//

chkIn()

F= vgen(FLOAT_,20,-7,1)

<<"%6.1f$F \n"

H=limitVal(F,-6,6)

<<"%6.1f$H \n"

chkR(H[0],-6)

chkR(H[19],6)


F->limit(-5,5)


<<"%6.1f$F \n"
chkR(F[0],-5)

chkR(F[19],5)


a = 7;

<<"$a\n"

a->limit(0,2)

<<"$a\n"
chkN(a,2);

b = -7;

<<"$a\n"

b->limit(0,2)

<<"$b\n"
chkN(b,0);

chkOut()

exit()/