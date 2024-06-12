/* 
 *  @script resize.asl                                                  
 * 
 *  @comment test resize ops                                            
 *  @release Rhodium                                                    
 *  @vers 1.8 O Oxygen [asl ]                                           
 *  @date 11/24/2023 09:45:47                                           
 *  @cdate Fri Apr 17 14:18:41 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare  -->                                   
 * 
 */ 




#include "debug.asl"
// fileDB(REJECT_,"args","tok")   // default everything is rejected
// use ALLOW_ to see debug from file xyz

  if (_dblevel >0) {

  debugON();

  }

  showUsage(" test resize ops ");

  ask =0;

  chkIn();

  Svar Wans;

  Wans = "stuff to do";

  <<"sz $(Caz(Wans)) $Wans\n";

  W=testargs(1,Wans);

  <<"%(1,,,\n)$W\n";

  Wans[3] = "more stuff to do";

  <<"sz $(Caz(Wans)) $Wans\n";

  S=testargs(1,Wans);

  <<"%(1,,,\n)$S\n";

  Wans.resize(12);

  Wans.pinfo();

  sz= Caz(Wans);

  <<"sz $(Caz(Wans)) $Wans\n";

  chkN(sz,12);

  Wans[9] = "keeps going";

  <<"sz $(Caz(Wans)) $Wans\n";

  Wans.pinfo();

  M=testargs(1,Wans);

  <<"%(1,,,\n)$M\n";

  Wans.resize(5);

  <<"sz $(Caz(Wans)) $Wans\n";

  sz= Caz(Wans);

  chkN(sz,5);

  Wans.pinfo();

  R=testargs(1,Wans);

  <<"%(1,,,\n)$R\n";

  <<"%V $(Typeof(Wans)) $Wans\n";

  Wans.pinfo();

  delete(Wans);
//Wans.pinfo()

  Wans = "stuff to do";

  <<"sz $(Caz(Wans)) $Wans\n";

  W=testargs(Wans);

  <<"%(1,,,\n)$W\n";
//ans = iread();

  Wans[3] = "more stuff to do";

  <<"sz $(Caz(Wans)) $Wans\n";

  S=testargs(Wans);

  <<"%(1,,,\n)$S\n";
//ans = iread();

  Wans.resize(10);

  <<"sz $(Caz(Wans)) $Wans\n";

  Wans[9] = "keeps going";

  <<"sz $(Caz(Wans)) $Wans\n";

  delete(W);

  W=testargs(Wans);

  <<"%(1,,,\n)$W\n";
//ans = iread();

  Wans.resize(5);

  <<"sz $(Caz(Wans)) $Wans\n";

  R=testargs(Wans);

  <<"%(1,,,\n)$R\n";

  <<"%V $(Typeof(Wans)) $Wans\n";

  <<"resize Svar to sz 1 \n";

  Wans.resize(1);

  <<"sz $(Caz(Wans)) $Wans\n";

  <<"check args \n";

  R1=testargs(Wans);

  <<"%(1,,,\n)$R1\n";
//ans = iread();

  delete(Wans);

  Wans="again";

  L=testargs(Wans);

  <<"%(1,,,\n)$L\n";

  <<"%V $(Typeof(Wans)) $Wans\n";
//chkStage("svar");

  // cpp version
  // V = vgen(INT_,10,0,1, [dynamic])
  

  int V[10];
  
  V.setDynamic(1,20)  ; // 

  V.pinfo();

  V[10] = 47;

  V[11] = 77;

  V[19] = -1;

  chkN(V[0],0);

  chkN(V[10],47);

  chkN(V[19],-1);

  <<"$V\n";
//V.resize(30)

  V.pinfo();

  resize(V,30);

  V.pinfo();

  V[20] = 80;

  chkN(V[20],80);

  chkN(V[29],0);

  <<"$V\n";
//  should give error --- not dynamic

  V.pinfo();

  V[30] = 79;

  V.pinfo();

  chkN(V[30],79);

  <<"$V\n";

  TR=testargs(1,V);

  resize(V,40);

  V[35] = 80;

  chkN(V[35],80);

  <<"%(1,,,\n)$TR\n";

  resize(V,6,6);

  V[0][3] = 79;

  chkN(V[0][3],79);

  <<"$V\n";

  TR=testargs(1,V);

  <<"%(1,,,\n)$TR\n";

  Delete(V);

  float V2 = 4*atan(1.0);

  <<"%V $(Caz(V2)) $V2\n";
  ndb("DBWIC")
  TR2=testargs(1,V2);

  <<"%(1,,,\n)$TR2\n";
 
   Vec V3(INT_,12,0,1,0)

<<"%V $V3\n"

   V3.pinfo()


  chkOut();

//==============\_(^-^)_/==================//

