setDebug(1,@~trace,@keep,@filter,0)
checkMemory(1);

IV= vgen(INT_,12,0,1)

<<"$IV\n\n"

IV->redimn(4,3)


<<"$IV\n\n"


 sm = IV[1:3][1:2];

<<"$(Caz(sm)) $(Cab(sm))\n"

<<"$sm\n"


vec =  IV[::][1];

<<"$(Caz(vec)) $(Cab(vec))\n"

vec->redimn()

<<"%V $vec\n"

<<"$(Caz(vec)) $(Cab(vec))\n"


int VL[];


VL[2] = 85;

<<"$(Caz(VL)) $(Cab(VL))\n"


<<"%V $VL\n"


VL =  IV[::][1];

<<"$(Caz(VL)) $(Cab(VL))\n"


<<"%V $VL\n"

VL->redimn()

<<"%V $VL\n"