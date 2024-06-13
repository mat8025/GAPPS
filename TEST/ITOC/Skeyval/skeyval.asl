/* 
 *  @script skeyval.asl                                                 
 * 
 *  @comment test sort of lookup table via value,num                    
 *  @release Carbon                                                     
 *  @vers 1.4 Be Beryllium [asl 6.29 : C Cu]                            
 *  @date 06/13/2024 17:35:40                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


// key-val pairs via Svar
<|Use=
  Demo key-value pairs use of Svar
  kv->addKeyVal("smarter","pushed")
  
|>


  void showUse()
  {

  <<"$Use\n";
  }

#include "debug"

  if (_dblevel >0) {

  debugON();

  }

  allowErrors(-1) ; // keep going;


  chkIn();

  Svar S;

  S[0] = "ele 0";

  S[1] = "ele 1";

  S[5] = "ele 5";

  sz=Caz(S);

  <<"%V$sz $S\n";


  chkStr(S[5],"ele 5");

  Svar kv;

  kv.table(LUT_,1,2);

  kv.addKeyVal("mark","is",0);

  kv.addKeyVal("terry","good");

  kv.addKeyVal("work","when");

  kv.addKeyVal("smarter","pushed");

  <<"%V $kv[0] $kv[1] \n";

  <<"%V $kv[2] $kv[3] \n";

  <<"%V $kv[4] $kv[5] \n";

  str iv;

  iv = kv.lookup("smarter");

  <<"%V$iv \n";
//!i iv
//!i kv

  iv = kv.lookup("work");

  <<"%V$iv \n";

//!i iv

  chkStr(iv,"when");
//!z

  wi = kv.findVal("work");
  wi.pinfo()
  <<"%V $wi \n";
//!i wi

  chkN(wi[0],4);

ans=ask("kv.findVal(work);",0)

  wi = kv.keySort();

  <<"key sort \n";

  <<"$kv \n";

  <<"%(2,, ,\n)$kv \n";

  <<"value sort\n";

  wi = kv.Sort(1);

  <<"%(2,<,\, ,>\n)$kv \n";

  <<"; ///////////////////\n";

  chkStr(kv[1],"good");

  Svar kvn;

  kvn.table(LUT_,1,2);

  kvn.addKeyVal("mark",1,0);

  kvn.addKeyVal("terry",3);

  kvn.addKeyVal("work",7);

  kvn.addKeyVal("smarter",0);
//wi = kvn.valueNumSort()

  wi = kvn.sortNum(1);

  <<"$kvn\n";

  <<"%(2,, ,\n)$kvn \n";

  <<"\n$kvn\n";
//!i kvn
//!z

  sz=Caz(kvn);

  ws= kvn[1];

  <<"%V$sz $ws\n";
//!i ws

  kvn.pinfo();
//!i kvn

  ws= kvn[4];

  <<"%V$ws\n";

  for (i=0;i<sz;i++) {

  ws= kvn[i];

  <<"$i <|$ws|>\n";

  }

  <<"%V$sz <|$kvn[0]|> $kvn[1] $kvn[1]\n";

  <<"%(2,, ,\n)$kvn \n";

  chkStr(kvn[0],"smarter");

  chkOut();

//===***===//
