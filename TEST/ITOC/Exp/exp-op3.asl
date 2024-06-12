

<|Use_=
Demo  of exp-sivs;
///////////////////////
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

//filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
//filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");


chkIn()




int sum = 0;
  double mi = 1;
  N = 10;
  k1 = 0;

  int i =1;
  for (k1 = 1; k1 < N; k1++) {
<<"%V $k1 $sum $mi \n"
    sum += k1;
    mi *= k1;
<<"%V $k1 $sum $mi $i\n"
//  if (i++ > N) break;

  }

chkN(k1,10)


fv = vgen(FLOAT_,10,0,1.1)

 fv->info(1)

<<"$fv \n"

chkR(fv[1],1.1)


chkOut()
