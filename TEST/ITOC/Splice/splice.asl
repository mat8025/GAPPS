/* 
 *  @script splice.asl                                                  
 * 
 *  @comment test splice(insert) vectors                                
 *  @release Arsenic                                                    
 *  @vers 1.3 Li Lithium [asl ]                                         
 *  @date 10/22/2023 21:42:43                                           
 *  @cdate Fri May 1 08:49:45 2020                                      
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare  -->                                   
 * 
 */ 


#include "debug"

  if (_dblevel >0) {

  debugON();

  }

  <<"Splices one vector into another at the specified index \n";

  chkIn(_dblevel);

  I = vgen(INT_,10,1,1);

  K = I;

  <<"%V$I \n";

  I[1] = 47;

  <<"%V$I \n";

  R = vReverse(I);

  <<"%V$R \n";

  chkN(R[0],10);

  R = vReverse(R);

  <<"%V$R \n";

  chkN(R[1],47);

  R = vReverse(R);

  <<"%V$R \n";

  K = vgen(INT_,10,10,-1);

  J = vSplice(I,K,4);

  <<"%V$I \n";

  <<"%V$K \n";

  <<"%V$J \n";

  chkN(J[4],10);

  J = vSplice(I,vReverse(K),4);

  <<"%V$J \n";

  R = vReverse(K);

  <<"%V$R \n";

  <<"%V$K \n";

  chkOut();

//==============\_(^-^)_/==================//
