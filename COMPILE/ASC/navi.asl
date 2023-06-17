///            
///  test auto_dec_via_func
///            
               
#define ASL 1
#define CPP 0
#define USE_GRAPHICS 0
               
                            
//#include "debug.asl"
#if CPP
#include "cpp_head.h"                       
#endif               

///////////////  GLOBALS //////////////////


////////////////////////////////////////////////

               
#if CPP

int main( int argc, char *argv[] ) { // main start
///
#endif               
 
               
               
  ignoreErrors();

  S = split ("Once upon a time")

  <<" $S\n"

  S= functions() ;
               
               
  S.sort();

//<<"%(1, , ,\n)$S[0:50:5]\n"

 // <<" $S\n"


//  cprintf("%S\n",S);
               

/*

  S.pinfo()   

 F= search(S," atan (");
 <<"%(1, , ,\n)$F\n"
               
               
 F= search(S," sin (");
 <<"%(1, , ,\n)$F\n"
               
               
 F= search(S," search (");
 <<"%(1, , ,\n)$F\n"
               
 F= search(S," functions (");
 <<"%(1, , ,\n)$F\n"
*/
///////////////////////////////////////
               
               
               
    x= 1.5;
               
    y = atan(x);
               
    p = sin(4* x);
               
         <<"%V $x $p $y \n"
       
               
  //cprintf("  x %f  p %f  y %f \n",x,p,y);
               
               
 //  navi exp  
               
               
               
    sydlat = dmstodd("33,51,54.5 S");
               
    sydlng = dmstodd("151,12,35.6 E");
               
<<"SYDNEY $sydlat $sydlng \n"               


   bldlat = dmstodd("40,02,53.9 N");
               
    bldlng = dmstodd("105,16,13.9 W");
               
<<"BOULDER $bldlat $bldlng \n"               

               
               
    toklat = dmstodd("35,39,10 N");
               
 //toklng = dmstodd("139,50,22 E")
               
    toklng = dmstodd("139,50,22 E");

<<"TOKYO $toklat $toklng \n"
               

               
    lndlat = dmstodd("51,30,35.5 N");
               
 //toklng = dmstodd("139,50,22 E")
               
    lndlng = dmstodd("0,07,5.13 W");

<<"LONDON $lndlat $lndlng \n"
               

               
  
  
   ldn_tok =  howfar(lndlng,lndlat,toklng,toklat,2);
               
<<"LONDON $lndlat $lndlng \n"


#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
