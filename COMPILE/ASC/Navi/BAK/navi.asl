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


//Laramie     	LAR	41,18.75,N	105,40.47,W	7277	03/21	122.95	TA 
    larlat = dmstodd("41,18,55 N");  // TBF make 41,18.75,N work
               
    larlng = dmstodd("105,40,30 W")
               
<<"LARAMIE $larlat $larlng \n"               




               
    toklat = dmstodd("35,39,10 N");
               
 //toklng = dmstodd("139,50,22 E")
               
    toklng = dmstodd("139,50,22 E");

<<"TOKYO $toklat $toklng \n"
               

               
    lndlat = dmstodd("51,30,35.5 N");
               
 //toklng = dmstodd("139,50,22 E")
               
    lndlng = dmstodd("0,07,5.13 W");

<<"LONDON $lndlat $lndlng \n"
               

               
  
  
    dist =  howfar(lndlng,lndlat,toklng,toklat,2);

<<"Howfar $dist \n"

    dist =  howfar(bldlng,bldlat,larlng,larlat,2);

<<"Howfar Boulder => Laramie $dist \n"


#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
