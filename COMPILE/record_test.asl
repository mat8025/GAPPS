/* 
 *  @script test_record.asl 
 * 
 *  @comment exercise Record type cpp interface 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.96 C-Li-Cm]                                
 *  @date 03/17/2022 06:51:17 
 *  @cdate 03/17/2022 06:51:17 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//


  Str Use_= " Demo  of exercise Record type cpp interface ";
  
/// cpp debug ??
#include <iostream>
#include <ostream>
#define ASL 0
#define CPP 1

#include "record.h"

  void
  Uac::recordWorld(Svarg * sarg)
  {

cout << Use_ << endl;

  Str ans= "xyz";

  Siv S(STRV);


  S= "we will attempt just one feature at a time ";

  Str q = "at";

  Str t = "im";

  cout << " t "  << t.pinfo() << endl;

  t.pinfo();

  int do_record = 1;

  Svar SV;

  SV.findCommaTokens("80,1,2,3,40,5,6,7,8,9");
  //SV.pinfo();

  cout  << "SV  "  << SV  << endl ;

  Record R(10);

  R(0) = SV;

  cout  << "done row assign  "  << endl ;

  cout  << "R(0)  "  << R(0)  << endl ;

  SV.findCommaTokens("82,11,2,3,40,5,6,7,8,99");

  R(1) = SV;

  cout  << "R(1)  "  << R(1)  << endl ;

  SV.findCommaTokens("9,8,7,6,5,4,3,2,1,0");

  cout << "SV  " << SV << endl;

  R(3) = SV;


  SV.findCommaTokens("19,8,77,66,555,44,123,3212,-111,0");

  cout << "SV  " << SV << endl;

  R(2) = SV;


  cout  << "R()  "  << R(RALL_)  << endl ;

  Svar SV2;

  Svar *sp = &SV2;

  SV2 = R(1);

  cout << "SV2  " << SV2 << endl;

    cout << "R(0)  " << R(0) << endl;
    cout << "R(1)  " << R(1) << endl;
    cout << "R(3)  " << R(3) << endl;        

    cout << "R  \n" << R(RALL_) << endl;

  cout  << "done record test  "  << endl ;

  cout << "Exit cpp testing Record " << endl;

  }
//==============================//

  extern "C" int test_record(Svarg * sarg)  {

  Uac *o_uac = new Uac;
   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 

  o_uac->recordWorld(sarg);

  dbt("EXIT extern C test_record\n");

  return 1;

  }
//================================//

;//==============\_(^-^)_/==================//;
