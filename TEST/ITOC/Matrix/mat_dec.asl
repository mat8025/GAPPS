///
///
///

#include "debug"
debugON()

 chkIn()

//DV = vgen(FLOAT_,10,0,1)


vect = vgen(INT_,20,-5,1)

vect->info(1)

<<"$vect \n"


Vec V(FLOAT_,10,1,1);

V[1] = 5;

<<"$V\n"

V->Info(1)





Mat M(DOUBLE_,2,2);

<<"$M\n"

M->info(1)

M[0][0] = 3;
M[0][1] = 1;
M[1][0] = 2;

<<"$M\n"

Mat MI(INT_,2,2);

<<"$MI\n"

MI->info(1)
MI[0][0] = 4;
MI[1][1] = 1;

<<"$MI\n"

MM= MI *M

<<"$MM\n"

/*

Vec  V(FLOAT_,4) = {4,7,2,6};

<<"$V\n"

V->info(1)

*/