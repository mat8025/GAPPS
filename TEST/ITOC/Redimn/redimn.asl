/* 
 *  @script redimn.asl 
 * 
 *  @comment test redimn func 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.16 C-Li-S]                                 
 *  @date Fri Feb  5 13:04:56 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///
///  redimn
///
#include "debug.asl"

  if (_dblevel >0) {

  debugON();

  }

  showUsage(" test redimn func ");

  ask =0;

  chkIn(_dblevel);

  int V[20];

  V[10] = 47;

  chkN(V[0],0);

  chkN(V[10],47);

  chkN(V[19],0);

  <<" vector \n";

  <<"$V\n";

  V.redimn(10,2);

  <<" 2D array 10,2 \n";

  <<"$V\n";

  V.redimn(5,4);

  <<" 2D array 5,4 \n";

  <<"$V\n";

  <<" vector \n";

  V.redimn();

  <<"$V\n";

  M = V;

  redimn(M,4,5);

  <<" 2D array 4,5 \n";

  <<"$M\n";

  redimn(M);

  <<" vec \n";

  <<"$M\n";

  chkN(M[10],47);

  chkOut();

//==============\_(^-^)_/==================//
