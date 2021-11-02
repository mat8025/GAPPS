//%*********************************************** 
//*  @script ssubrgx.asl 
//* 
//*  @comment test Ssubrgx func 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Fri Mar 29 14:23:41 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///

#include "debug"
debugON()


//sed 's/\([^_]\)SUBSC_/\1SI_SUBSC_/g' 


W= "abc(SUBSC_ARRAY) || def(SUBSC_LOCK)"



dir = 1;



//





<<"\n$W \n"
T= ssubrgx(W,"([^_])SUBSC_([A-N])",'SI_SUBSC_ABC',dir)
<<"$T \n"


<<"\n$W \n"
T= ssubrgx(W,"([^_])SUBSC_([A-N])",'\1SI_SUBSC_\2X',dir)
<<"$T \n"







<<"\n$W \n"
T= ssubrgx(W,"([^_])SUBSC_([A-N])",'\1SI_SUBSC_\2ABC\1\2',dir)
<<"$T \n"

<<"\n$W \n"
T= ssubrgx(W,"([^_])SUBSC_([A-N])",'\1SI_SUBSC_\2\1ABC\2',dir)
<<"$T \n"




<<"\n$W \n"
T= ssubrgx(W,"([^_])SUBSC_([A-N])",'\1SI_SUBSC_\2',dir)
<<"$T \n"

dir = 0
<<"\n$W \n"
T= ssubrgx(W,"([^_])SUBSC_([A-N])",'\1SI_SUBSC_\2',dir)
<<"$T \n"



//abc(SUBSC_ARRAY) || def(SUBSC_LOCK) 

dir = 1;

<<"\n$W \n"
T= ssubrgx(W,"([^_])SUBSC_([A-N])",'\1SI_SUBSC_\2',dir)
<<"$T \n"




dir = -1;

<<"\n$W \n"
T= ssubrgx(W,"([^_])SUBSC_([A-N])",'\1SI_SUBSC_\2',dir)

<<"$T \n"
