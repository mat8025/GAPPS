


setdebug(0)

fn1 = "lp_mag";
fn2 = "hp_mag";


A=ofr(fn1)

  L = ReadRecord(A,@type,FLOAT_)

B=ofr(fn2)

  H = ReadRecord(B,@type,FLOAT_)


sz = Caz(L);
 dmn = Cab(L);
 nrows = dmn[0];

 for (i = 0; i < nrows ; i++) {

  <<"$L[i][0] $L[i][1] $H[i][1]\n"
 }

  Y1 = L[::][1];
  Y2 = H[::][1];


 y1sz = Caz(Y1)

 y2sz = Caz(Y2)

<<"%V$y1sz $y2sz\n"

 dmn = Cab(Y1)

<<"%V$dmn\n"


<<"$Y1[0:10][0]\n"

 redimn(Y1)


<<"$Y1[0:10]\n"

  YS = Y1[0:10]

<<"$YS\n"

  an = "YS"

 YX = $an

 <<"%V$YX\n"