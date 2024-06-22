/* 
 *  @script colors.asl 
 * 
 *  @comment showme colors for screen 
 *  @release 6.34 : C Se 
 *  @vers 1.2 He Helium [asl 6.34 : C Se]                                   
 *  @date 06/22/2024 03:00:03 
 *  @cdate 1/1/2003 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2024
 * 
 */ 
//-----------------<V_&_V>------------------------//

Str Use_= " Demo  of showme colors for screen ";

#define _CPP_ 0

#define _ASL_ 1


#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); // set number of errors allowed -1 keep going 

  chkIn(_dblevel) ;

  chkT(1);

 


// CPP main statment goes after all procs
#if _CPP_
   int main( int argc, char *argv[] ) { // main start 
#endif       
///
///
///
i = 39;


<<"$('PBKGBROWN_')  this is brown background print  \n"
<<"$('PBKGBLUE_')  this is blue background print  \n"


 <<"$('PRED_')  this is red print  \n"
  <<"$('PWHITE_')  this is white print  \n"

 <<"$('PGREEN_')  this is green print  \n"
  <<"$('PBLUE_')  this is blue print  \n"
   <<"$('PYELLOW_')  this is yellow print  \n"
<<"$('PBKGWHITE_')  this is white background print  \n"   
   <<"$('PWCOLOR_')  this is ? print  \n"
<<"$('PBKGWHITE_')  this is white background print  \n"
for (i = 30; i<= 38; i++) {
 <<"  \033[1;${i}m $i ??\n"
}
  <<"$('PWHITE_')  this is white print  \n"
for (i = 40; i<= 48; i++) {
 <<"  \033[1;${i}m $i ??\n"
}

//a=iread("?");

<<"$('PBKGBROWN_')  this is brown background print  \n"
for (i = 30; i<= 50; i++) {
 <<"  \033[1;${i}m $i ??\n"
}

 <<"$('PBLACK_')  this is black print \n"
<<"$('PBKGWHITE_')  this is white background print  \n"

#if _CPP_           
  exit(-1); 
  }  // end of C++ main 
#endif     


///

  //chkOut(1);

  exit();

//==============\_(^-^)_/==================//
