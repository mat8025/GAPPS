

include "debug.asl";

debugON();
  setdebug(1,@keep,@pline,@trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);
  

 N = 8
 M = 3

 float Re[N];

 float ReStg[M][N];


 Re = vgen(FLOAT_,N,0,1)

<<"%6.1f$Re \n"


 ReStg[1][::] = Re

<<"$ReStg \n"

 ReStg[0][::] = (Re *2 );

<<"%6.1f$ReStg \n"

 ReStg[1][::] = ReStg[1][::] *  Re ;  // works

<<"%6.1f$ReStg \n"

 cmplx CS[N];

 cmplx CStg[M][N];

 CS->setReal(Re)


<<"%6.1f $CS\n"


 CStg[1][::] = CS

<<"%6.1f$CStg\n"

 CStg[0][::] = CS

<<"%6.1f$CStg\n"

 CStg[1][::] = CStg[1][::] *  CS ;  //  works


<<"%6.1f$CStg\n"


 ReStg[1][::]  *= Re    // does not work  -- no self ops??

<<"%6.1f$ReStg \n"

 ReStg[1][::] = ReStg[1][::] *  Re   // works

<<"%6.1f$ReStg \n"


 ReStg[::][::] = Re

<<"%6.1f$ReStg \n"

 ReStg[1][::] = 3

<<"$ReStg \n"


 ReStg[2][::] *= 3

<<"%6.1f$ReStg \n"

  Re *= 3
  
<<"$Re \n"

// this crashes

ReStg[::][::] *= -5

<<"%6.1f$ReStg \n"


checkOut()
