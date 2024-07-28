/* 
 *  @script vectosiv.asl                                                
 * 
 *  @comment test SF to SIV/vec                                         
 *  @release 6.53 : C I                                                 
 *  @vers 1.2 He Helium [asl 6.53 : C I]                                
 *  @date 07/28/2024 15:22:59                                           
 *  @cdate 07/28/2024 15:22:59                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

                                                                                                                                                                                                                                                                                             
#define __ASL__ 1
#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of test SF to SIV/vec ";

 Svar argv = _argv;  // allows asl and cpp to refer to clargs
 argc = argc();

/*
#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 
*/
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
     init_cpp(argv[0]); 

#endif       

  db_ask = 1
  db_it = 1

#if __ASL__
 aok= allowDB("spe_func,spil,parse,ds_store",db_it)
#endif   
  chkIn(1) ;

  chkT(1);

 
  r = sin(0.25)

<<"%V $r\n"
//
//
//

  ok=openDll("plot")
  <<"%V $ok\n"
  ok=openDll("image")
  <<"%V $ok\n"

  cindex =1

  rok=rainbow()
  <<"%V $rok\n"

   cname = getHTMLcolorName(cindex)



   fcv = getRGBfromHTMLindex(cindex);

   fcv.pinfo()

//   ans = ask(" $fcv OK?", db_ask)

Siv fcv2[5]
 i= 0;
 for (i=1; i< 10 ; i++) {
  fcv2=getRGBfromHTMLindex(i);
  

<<"$fcv2 \n"
}

  Siv fcv3

  fcv3.pinfo()

  fcv3 = getRGBfromHTMLindex(i)

  fcv3.pinfo()

<<"$fcv3 \n"


Siv fcv4 = 49
  fcv4.pinfo()

  <<"$fcv4 \n"

 int fcv5 = 50


  <<"$fcv5 \n"

   rgb = getRGBfromHTMLindex(49)


   rgb.pinfo()

  <<"$rgb \n"

  red = rgb[0]

<<"%V $red \n"

  green = rgb[1]

<<"%V $green \n"

  blue = rgb[2]

<<"%V $red $green $blue \n"
cname="colXYZ"

    for (i=0;i <150; i++) {

    rgb = getRGBfromHTMLindex(i)
     red = rgb[0] ; green = rgb[1];   blue = rgb[2]; 
     cname = getHTMLcolorName(i)
<<"[$i] %V $red $green $blue $cname \n"

   }

///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
