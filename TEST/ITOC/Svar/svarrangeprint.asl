/* 
 *  @script svarrangeprint.asl                                          
 * 
 *  @comment 1.3                                                        
 *  @release 6.51 : C Sb                                                
 *  @vers 0.0   [asl 6.51 : C Sb]                                       
 *  @date 07/21/2024 05:22:50                                           
 *  @cdate 07/21/2024 05:22:50                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

                                                                                                            
#define __ASL__ 1
#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of 1.3 ";

 Svar argv = _argv;  // allows asl and cpp to refer to clargs
 argc = argc();


#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); // set number of errors allowed -1 keep going 

#endif       

// CPP main statement goes after all procs
#if __CPP__
#include <iostream>
#include <ostream>
using namespace std;
#include "vargs.h"
#include "cpp_head.h"
#define PXS  cout<<

#define CPP_DB 0

  int main( int argc, char *argv[] ) {  
    init_cpp() ; 

#endif       


  chkIn(1) ;

  chkT(1);

//
//
//

//   Svar range print access




allowDB("spe,ds,svar,str",1)
Svar L;
  L.pinfo()



T= " *  @cdate Sun Mar 22 11:05:34 2020"

  T.pinfo()
  L.Split(T)
  L.pinfo()

 //sz =Caz(L)
 hwi =Chi(L)
 
 <<"%V $hwi \n"
i = 0

while (i <= hwi) {
<<"[$i] <|$L[i++]|> \n"
}



<<"-1 <|$L[-1]|> \n"


<<"$L[2::] \n"
<<"$L[2:hwi:1] \n"
<<"$L[0:hwi:2] \n"

      cdate = "$L[2:hwi:]";

<<" <|$cdate|> \n"

  chkStr(cdate,"Sun Mar 22 11:05:34 2020")


      cdate = "$L[2:hwi:2]";

<<" <|$cdate|> \n"

 // chkStr(cdate,"Sun Mar 22 11:05:34 2020")

chkOut()


// TBF 7/20/24   ? WS in last svar field? FIXED use Chi highwater field of Svar

// highwater field is highest of Svar that has been used/filled/stored

///




#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
