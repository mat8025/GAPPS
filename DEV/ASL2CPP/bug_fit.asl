

///
///
///



#include "debug"

if (_dblevel >0) { 
   debugON() 
   //<<"$Use_ \n" 
} 

chkIn(_dblevel)

allowErrors(-1) ; // keep going


int DEFS_NF[28];



DEFS_NF = -47;


<<"$DEFS_NF \n"

DEFS_NF = -76;

<<"$DEFS_NF \n"


DEFS_NF[10:20:2] = -77;

<<"$DEFS_NF \n"




exit()


