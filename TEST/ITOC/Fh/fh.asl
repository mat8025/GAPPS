/* 
 *  @script fh.asl                                                      
 * 
 *  @comment  file handle                                               
 *  @release Carbon                                                     
 *  @vers 1.3 Li Lithium [asl 6.54 : C Xe]                              
 *  @date 09/19/2024 14:21:26                                           
 *  @cdate 1/1/2003 22:03:56 Helium [asl 6.3.66 C-Li-Dy]                
 *  @author Mark Terry Helium [asl 6.3.66 C-Li-Dy]                      
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 



#include "debug.asl"

  if (_dblevel >0) {

  debugON();

  }


  showUsage("   Demo  of test file handle ");

  db_ask =0;

  allowErrors(-1);

  chkIn();
////
////
////

  A=ofw("log2");

  <<"first line in script  stdout\n";

  <<[A]"first line in log file - not stdout\n";

  <<[A]"second line in log file\n";

  Svar W;

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

   ka = A

  cf(A);

  !!"cat log2";






  B=ofr("log2");

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


  <<"%V $S[-1]  $A $ka\n";

  
  chkStr(S[0],"first line in log file - not stdout\n");

  chkStr(S[-1],"last line using file handle $A\n");



  chkOut();

//==============\_(^-^)_/==================//
