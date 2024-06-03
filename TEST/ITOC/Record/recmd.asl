/* 
 *  @script rec_md.asl 
 * 
 *  @comment check md range ops 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.60 C-Li-Nd] 
 *  @date 11/18/2021 06:57:17          
 *  @cdate Mon Feb 15 08:48:06 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

<|Use_=
  Demo  of Record class MD ;
///////////////////////
|>

#include "debug"

  if (_dblevel >0) {

  debugON();

  <<"$Use_\n";

  }

  chkIn(_dblevel);

  int MD[5][10];


  chkN(MD[0][1],0)

  chkN(MD[0][-1],0)

  chkN(MD[0][-1],0,"init Array zero ")

  MD[0][1] = 79;

  mdv =  MD[0][1];

  <<"%V $MD[0][1] $mdv \n";


  chkN(MD[0][1],79,"Set element")

  MD[0][0:8:1] = 77;

  <<"$MD[0][::]\n";

  chkN(MD[0][8],77,"set subset of elements")

  MD[1][::] = 80;

  chkN(MD[1][1],80,"set default range")

  <<"$MD\n";

  MD[0][5:9:1] = 54;

  chkN(MD[0][5],54,"set subset of eles")

  MD[1][3:8:1] = 28;

  chkN(MD[1][6],28),"set subset of eles")

  MD[1][3:8:] = 27;

  chkN(MD[1][6],27,"set subset of eles-default step")

  <<"$MD\n";

  MD[2:4:1][4:9:1] = 77;

  <<"$MD\n";

  chkN(MD[3][6],77,"set subset of eles")

  MD[2:4:1][4:9:] = 78;

  chkN(MD[3][9],78,"set subset of eles-default stride")

  MD[2:4][0:3] = 85;

  MD[0:3][0] = -34;

  Record RSV[3];

  MD.pinfo();

  RSV= MD;

  RSV.pinfo();

  <<"%V $RSV\n";

  Str sval ;

  sval = RSV[2][4];

  sval.pinfo();

  <<"%V<|$sval|>\n";

  chkStr(sval,"78.000000");

  val = RSV[2][4];

  val.pinfo();

  <<"%V<|$val|>\n";

  chkStr(val,"78.000000");

  val = RSV[2][1];

  <<"$val\n";

  chkStr(val,"85.000000");

  chkStr(RSV[2][1],"85.000000");

  SM= MD[0:2][1:5:];

  RSV= MD[0:2][1:5:];

  <<"after subscript RHS\n";

  RSV.pinfo();

  <<"$RSV\n";

  V=vgen(FLOAT_,10,0,1);

  <<"$V\n";

  Record RV[3];

  RV =V;

  RV.pinfo();

  <<"$RV\n";

  chkOut(1);
/*
   Should be able to specify a subset of a MD array for operations
*/


//==============\_(^-^)_/==================//
