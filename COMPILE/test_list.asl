/* 
 *  @script test_list.asl 
 * 
 *  @comment exercise List class cpp interface 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.96 C-Li-Cm]                                
 *  @date 03/17/2022 07:05:29 
 *  @cdate 03/17/2022 07:05:29 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//


  
/// cpp debug ??
#include <iostream>
#include <ostream>
#define ASL 0
#define CPP 1

// this file will be cpp compiled if edits are made to to uac_functions.h and uac_methods.h
// follow test_vec example
// then use make in uac directory

// it can be run as follows
// using bash run_list

// echo "bash args" $*
// asl -d -s 'Svar z=_clarg[1:-1:1]; Str sa="$z"; <<"%V $sa\n"; opendll("uac"); test_list(sa); exit(0); ' $*


// command one-liner
// asl -d -s  'opendll("uac");  test_list(2); '

// asl script
//try_list.asl
//
//opendll("uac");
//test_list(1);
//exit(-1);
////


  void Uac::listWorld(Svarg * sarg)
  {

  Str Use_ = " Demo  of exercise List class cpp interface ";

  Str ans= "xyz";

  cout << "hello simple List test  " << ans << endl;

  Svar VLS;

  Str ls;

  VLS.split("restart math modules");

  cout << "VLS " << VLS << endl;

 // ans=query("do_list");

  List LS(STRV);

 // ans=query("info?");

  LS.pinfo();

  LS.setType(STRV);

 // ans=query("insert ?");

  LS.insert( LIEND,VLS);

//  ans=query("get LIBEG?");

  Siv sli(STRV);

  sli= LS.getLitem(LIBEG);

  cout << " test Siv print " << endl;

  cout <<"sli  " << sli <<endl;

  sli.pinfo();

 // ans=query("sli ?");

  ls=LS.getItemAsStr(1);

  cout <<" ls  " << ls <<endl;

 // ans=query("get LIEND?");

  sli = LS.getLitem(LIEND);

  cout <<"WHATS sli  " <<  endl;

  cout <<"whats sli  " << sli <<endl;

  sli.pinfo();

  cout <<"hot item is sli " << sli << endl;

  cout  << "LS "  << LS << endl;

 // ans=query("seen sli val ?\n");
// try an INT List

  List LSI(INT);

  LSI.insert( LIEND,1);

  LSI.insert( LIEND,2);

  LSI.insert( LIEND,3);

  LSI.insert( LIBEG,4);

  cout  << "LSI "  << LSI << endl;
//  ans=query("List INT ?\n");

  cout << "Exit cpp testing List " << endl;

  }
//==============================//

  extern "C" int test_list(Svarg * sarg)  {

  Uac *o_uac = new Uac;
   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 

  o_uac->listWorld(sarg);

  dbt("EXIT extern C test_list\n");

  return 1;

  }
//================================//

;//==============\_(^-^)_/==================//;
