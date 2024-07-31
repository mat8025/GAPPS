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

#define USE_GRAPHICS 0

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

  <<"%V $cname\n"

   fcv = getRGBfromHTMLindex(cindex);

   fcv.pinfo()

ans=iread("fcv");

//   ans = ask(" $fcv OK?", db_ask)

Siv fcv2
 i= 0;
 for (i=1; i< 10 ; i++) {
 
  fcv2=getRGBfromHTMLindex(i);
  

<<"$i $fcv2[0] $fcv2[1] $fcv[2]\n"
}

ans=iread("fcv2");

//  Siv fcv3
  fc = fcv2[1]

<<" %V $fc\n"

ans=iread("fcv3");

  fcv3 = getRGBfromHTMLindex(i)

  fcv3.pinfo()

<<"$fcv3 \n"
ans=iread("fcv3");

Siv fcv4 = 49 
  fcv4.pinfo()

  <<"$fcv4 \n" ; // would need to know it is an int scalar
ans=iread("fcv4");
 int fcv5 = 50


  <<"$fcv5 \n"

   rgb = getRGBfromHTMLindex(49) ; // doesn't init  declare via function
//  has to translate to Siv rgb ; rgb = getRGBfromHTMLindex(49)
//  check if we have constructor   Siv( float *) ?? that could work

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
