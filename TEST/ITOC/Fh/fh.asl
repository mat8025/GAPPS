/* 
   *  @script fh.asl
   *
  *  @comment test file handle
  *  @release CARBON
  *  @vers 1.2 He Helium [asl 6.3.66 C-Li-Dy]
  *  @date 12/16/2021 22:03:56
  *  @cdate 1/1/2003
  *  @author Mark Terry
  *  @Copyright © RootMeanSquare  2010,2021 →
  *
  *  \\-----------------<v_&_v>--------------------------; //
 */


#include "debug.asl"

  if (_dblevel >0) {

  debugON();

  }

  showUsage("   Demo  of test file handle ");

  db_ask =1;

  allowErrors(-1);

  chkIn();
////
////
////

  A=ofw("log2");

  <<"first line in script  stdout\n";

  <<[A]"first line in log file - not stdout\n";

  <<[A]"second line in log file\n";

  svar W;

  W.pinfo()
  
  W[0] = "hey";

  W[1] = "mark";

  W[2] = "can";

  W[3] = "you";

  W[4] = "make";

  W[5] = "your";

  W[6] = "goal";

  <<[A]"$W[0:3]\n";

  <<[A]"$W[4:-1]\n";

  <<[A]"$W[-1:0:-1]\n";
//<<"$W[-1:0:-1]\n"

  <<[A]"last line using file handle $A\n";

  cf(A);

  !!"cat log2";

  

  B=ofr("log");

  wcv = countWords(B)

  wcv.pinfo()



  Svar S;

  S.pinfo()

  dbAllow("rdp,array,spe",1)

  S=readfile(B);

  S.pinfo()
  nl = Caz(S)
  
ans = ask("n lines in file $nl",db_ask) 

  <<"S[0] $S[0]\n";

  <<"%V $S[1]\n";



  LL = S[1]

<<"1 $LL \n"
  
  LL.pinfo()

  LL = S[0]

<<"0 $LL \n"

  LL = S[-1]

<<"-1 $LL \n"


  LL = S[-2]

<<"-2 $LL \n"

  LL = S[-3]

<<"-3 $LL \n"

  LL = S[-6]
  
<<"-6 $LL \n"


  <<"%V $S[-1]\n";

  chkStr(S[0],"first line in log file - not stdout\n");

  chkStr(S[-1],"last line using file handle $A\n");



  chkOut();

//==============\_(^-^)_/==================//
