#define DBOFF 

SetDebug(1,"pline")

 N = 8
 M = 3

 float Re[N];

 float ReStg[M][N];


 Re = vgen(FLOAT_,N,0,1)

<<"$Re \n"


 ReStg[1][::] = Re

<<"$ReStg \n"

 ReStg[0][::] = (Re *2 );

<<"$ReStg \n"

 ReStg[1][::] = ReStg[1][::] *  Re ;  // works

<<"$ReStg \n"

 cmplx CS[N];

 cmplx CStg[M][N];

 CS->setReal(Re)


<<"$CS\n"


 CStg[1][::] = CS

<<"$CStg\n"

 CStg[0][::] = CS

<<"$CStg\n"

 CStg[1][::] = CStg[1][::] *  CS ;  //  works


<<"$CStg\n"

  exit()



 ReStg[1][::] *= Re    // does not work  -- no self ops??

<<"$ReStg \n"

 ReStg[1][::] = ReStg[1][::] *  Re   // works

<<"$ReStg \n"


 ReStg[::][::] = Re

<<"$ReStg \n"

 ReStg[1][::] = 3

<<"$ReStg \n"


 ReStg[2][::] *= 3

<<"$ReStg \n"

  Re *= 3
  
<<"$Re \n"

// this crashes
DBOFF ReStg[::][::] *= -5

<<"$ReStg \n"



