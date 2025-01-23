/* 
 *  @script printf.asl 
 * 
 *  @comment test printf - c like 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 5.62 : B Sm]                                  
 *  @date 12/26/2023 11:46:06 
 *  @cdate 12/26/2023 11:46:06 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2023
 * 
 */ 
//-----------------<V_&_V>------------------------//


  Str Use_= " Demo  of test printf - c like ";




#define _CPP_ 0
#include "debug"

  if (_dblevel >0) {

  debugON();

  <<"$Use_ \n";

  }

  allowErrors(-1); // set number of errors allowed -1 keep going;

wdb=DBaction((DBSTEP_|DBSTRACE_|DBALLOW_ALL_),ON_)
//allowDB("spe_,ds_")
<<"%V$wdb \n"

char vers[6] ="5.1";

vers.pinfo();


  chkIn() ;

  chkT(1);
  
// goes after procs
#if _CPP_

  int main( int argc, char *argv[] ) { ; // main start;
#endif



  ok = 1;

  int na =3;

  printf("cprint na %d\n",na);

  Svar sa;

  na = _clargc;

  sa = _clarg;

  printf(" na %d\n",na);

  <<" asl print %V $na \n";

  <<"$sa \n";


#if _CPP_           

  exit(-1);

  }  ; /// end of C++ main;
#endif     
///

  chkOut();

  exit(0);
//==============\_(^-^)_/==================//
