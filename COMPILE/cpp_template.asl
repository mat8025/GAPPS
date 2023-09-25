///            
///            
///            
#define _CPP_ 0
#if _CPP_      
#include "cpp_head.h" 
	Str myvers = MYFILE;
#endif         
               
#if _ASL_      
#include "hv.asl"
myvers =Hdr_vers
#define cout //
#define COUT //
#define CDB ans=query("go on");
//#define CDBP (x) ans=query(x,"go on"); // asl not working
#define AST matans=query("?","ASL DB go_on?",__LINE__,__FILE__);
<<"ASL   $(_ASL_) CPP $(_CPP_)\n"
printf("_ASL_ %d _CPP_ %d\n", _ASL_,_CPP_);
#define CDBP //
#endif         
               
               
               
#if _CPP_      
#warning USING_CPP
#define CDBP(x) ans=query(x,"go on",__LINE__,__FILE__);
#define CDB ans=query("?","go on",__LINE__,__FILE__);
#define  CHKNISEQ(x,y)  chkN(x,y,EQU_, __LINE__);
#endif         

//////////////////////// INCLUDES ////////////////////////////////


//////////////////////// GLOBALS ////////////////////////////////



//////////////////////////  CPP BEGIN MAIN /////////////////////
#if _CPP_

int main( int argc, char *argv[] ) { 
        cpp_init();
        init_debug ("mat.dbg", 1, "1.2");
        cprintf("%s\n",MYFILE);

#endif               










//////////////////////////  CPP END OF MAIN /////////////////////
#if _CPP_              
  //////////////////////////////////
  cprintf("Exit CPP \n");
  exit(0);
 }  /// end of C++ main   
#endif               

