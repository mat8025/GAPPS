//
//
//

#define _CPP_ 0
#if _CPP_
#include "vargs.h"
#include "cpp_head.h"
#include "vec.h"
	Str myvers = MYFILE;
#endif

#if _ASL_
#include "hv.asl"
myvers =Hdr_vers
#define cout //
#define COUT //
#define CDB ans=query("go on");
//#define CDBP (x) ans=query(x,"go on"); // asl not working
#define AST vecans=query("?","ASL DB goon",__LINE__,__FILE__);
<<"ASL   $(_ASL_) CPP $(_CPP_)\n"
printf("_ASL_ %d _CPP_ %d\n", _ASL_,_CPP_);
#define CDBP //
#endif






//////////////////////////  CPP MAIN /////////////////////
#if _CPP_
#warning USING_CPP
int main( int argc, char *argv[] ) { 
        cpp_init();
        init_debug ("cpp.dbg", 1, "1.2");
        cprintf("%s\n",MYFILE);

#endif               

// trans int IV3[10] ==> Vec<int> IV3(20) ;
int IV3[20]

  IV3.pinfo();
 //          Vec<float> IGCLONG(70) ;
//	     IGCLONG.pinfo()


  char CV[32]

   CV = " a char string"
  //<<"CV is %s $CV\n"

 CV.pinfo()



 //cprintf("  IGC %f \n",IGCLONG[2])    ;
 
// D = vgen(DOUBLE_,10,6,-2) ; // trans to Vec<double> D(10,6,-2);

 Vec<double> D(10,6,-2);
//Vec<double> D(10); 

 D.pinfo()

<<"%V $D[4] \n"

//<<"%V $D[1:-1:2] \n"  // trans cprintf("D %f\n",D(1,-1,2));

Vec<float> F(10,6,0.5); // vec  type sequence
//Vec<float> F(10); // vec  type sequence

  F.pinfo()
//<< "%V $F \n" ; // prep should allow << WS "  

<<"%V $F[2] \n" ;  

   F[2] = 66.77;


<<"%V $F[2] \n" ;  




// int IV[20] ;   // trans to Vec<int> IV(10)
  Vec<int> IV(10)
 <<" $IV[0]\n"
 IV.pinfo()

  IV[2:9:2] = 76; // trans == > IV(2,9,2) = 76;

 // IV(2,9,2) = 77;
  IV[0] = 787;
 IV.pinfo();
 
  Vec<int> IV2(10)


  IV2 = IV[0:6:1]

  IV2.pinfo()


  F = IV

 F.pinfo()

 double D2[10]

   D2 = F

D2.pinfo()

short SV[10]

   SV = IV

 SV.pinfo()


#if _CPP_              
  //////////////////////////////////
  cprintf("Exit CPP \n");
  exit(0);
 }  /// end of C++ main   
#endif               
