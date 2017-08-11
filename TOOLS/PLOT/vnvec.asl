



nylines = 2;


float R[10][2];


 R[::][0] = vgen(FLOAT_,10,0,1)


 R[::][1] = vgen(FLOAT_,10,0,-1)


<<"$R\n"



svar vn;

  for (i = 0; i < nylines ; i++) {
   vn[i] = "YV$i"
   $vn[i] =  R[::][i]
   redimn($vn[i])
<<"$i $vn[i] \n"
  }


<<"%V$YV0 \n"

<<"%V$YV1 \n"

<<"$(typeof(YV0)) $(Cab(YV0))  $(Caz(YV0))\n"

 R[::][1] = vgen(FLOAT_,10,0,-2)

<<"$R\n"


<<"%V$YV1 \n"

// testargs(YV0)


 AL=testargs($vn[0])


<<"$AL\n"

// testargs(YV1)


 AL=testargs($vn[0],$vn[1],R)


<<"$AL\n"