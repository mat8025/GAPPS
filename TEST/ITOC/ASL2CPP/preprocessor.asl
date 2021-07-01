//%*********************************************** 
//*  @script preprocessor.asl 
//* 
//*  @comment test preprocessor directives 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.92 C-He-Ur]                               
//*  @date Fri Dec  4 12:34:59 2020 
//*  @cdate Fri Dec  4 12:34:59 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///   try out some preprocessor macros
///


#define  CPP  1



#if CPP
#define ASL 0
#define  MAT 1
#else
#define ASL 1
#define  MAT 0
#endif


<<"CPP? $(CPP) \n"


  if (CPP) {

<<" sees CPP\n"

  }

#if CPP
<<" test CPP is TRUE\n"
#else 
<<" test CPP is FALSE\n"
#endif



<<"after CPP #if #else #endif section\n"

#if ASL
<<" test ASL is TRUE\n"
#else 
<<" test ASL is FALSE\n"
#endif


#if MAT
<<" MAT CPP is TRUE - use MAT CPP functions here\n"
#else 
<<" MAT CPP is FALSE - so use MAT ASL functions here\n"
#endif


