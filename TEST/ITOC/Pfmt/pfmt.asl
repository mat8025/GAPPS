/* 
   *  @script pfmt.asl
   *
   *  @comment test format in asl print
   *  @release CARBON
   *  @vers 1.1 H Hydrogen [asl 6.3.63 C-Li-Eu]
   *  @date 11/28/2021 14:28:59
   *  @cdate 11/28/2021 14:28:59
   *  @author Mark Terry
   *  @Copyright © RootMeanSquare  2010,2021 →
   *
   *  \\-----------------<v_&_v>--------------------------; //
 */ 


;//----------------------//;

<|Use_= 
   Demo  of test format in asl print
/////////////////////// 
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_ \n";

     }

   chkIn();

   float TFV[] = vgen(FLOAT_,10,1,0.5);

   <<"%6.f $TFV\n";

   T= Split("%V%6.2f$TFV");

   <<"$T\n";

   chkStr(T[2],"1.50");

   chkStr(T[3],"2.00");

   chkStr(T[4],"2.50");

<<"%V%6.2f$TFV\n";
    print("%V%6.2f$TFV\n");
   chkOut();

//===***===//
