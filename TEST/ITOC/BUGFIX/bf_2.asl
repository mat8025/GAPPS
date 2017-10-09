// BUG_FIX 

SetPCW("writeexe","writepic")
SetDebug(1)

//  FIXME_PARSE         
//  version 1.2.38

double xx
xx = 2.3
<<" $xx \n"

double yr0 = -1.5
double yr1 = 1.5
double xr0 = -1.5
double xr1 = 1.5

<<"%V $xr0 $yr0 $xr1 $yr1 \n"


short CM[256]

 CM[254] = 3


short YM[]


   YM[257] =3

<<" $YM[257] \n"

   for (k = 255; k < 512; k++) {
     YM[k] = k*2
   }
<<" $YM[499] \n"

// FIX was in declare_type routine -- revised added more error conditions

STOP!