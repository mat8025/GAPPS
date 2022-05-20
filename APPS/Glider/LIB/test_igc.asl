///
///
///


// T= fineTime();

//<<"$T \n"

//exit()
#include "debug"
ignoreErrors()

  float IGCLONG[];

  float IGCLAT[];

  float IGCELE[];

  float IGCTIM[];


  
  void IGC_Read(Str igc_file)
  {

<<"%V $igc_file \n"

  uint T[] = fineTime();

  a=ofr(igc_file);

  if (a == -1) {
     //DBG" can't open IGC file $igc_file\n"

  return 0;

  }

  ntps =readIGC(a,IGCTIM,IGCLAT,IGCLONG,IGCELE);

<<"%V $ntps\n"

  IGCELE *= 3.280839 ;
  //  IGCLONG = -1 * IGCLONG;
//DBG"read $ntps from $igc_file \n"

  dt=fineTimeSince(T);
<<"$_proc took $(dt/1000000.0) secs \n"

  cf(a);

  return ntps;

  }
//========================



Str fname ="../IGC/laramie.igc";

int np
np=IGC_Read(fname);

<<"ELE $np $IGCELE[0:10] \n";



np2 =IGC_Read(fname); // TBF

<<"TIM $np2 $IGCTIM[0:10] \n";


np3 =IGC_Read(fname); // TBF

<<"LAT $np3 $IGCLAT[0:10] \n";

exit()


