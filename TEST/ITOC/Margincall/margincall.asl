///
///
///

/// !x,!a,!l


/// for breakpoint list  ...
/// should not compile this line
/// so that breakpoint can be removed
#include "debug"

#define ASL 1
//#define CPP 0

#if  ASL
<<" ASL $ASL is defined\n"
#endif

//#define SALLY 3

#ifndef  SALLY
<<" SALLY   is not defined\n"
#define SALLY 2
<<"now SALLY   is defined $(SALLY)\n"
#else
<<"now SALLY was already  defined  $(SALLY)\n"
#endif


<<"%V $(ASL) $(SALLY) \n"

#ifdef SALLY
<<"SALLY   is defined $(SALLY) \n"
#endif

#if CPP
<<"CPP is !0 $(CPP)\n"
#else
<<"CPP is 0 $(CPP) \n"
#endif


exit()





int i,k,j,m; // can not do comma del list of vars?? TBF 5/25/2022

<<"%V $i \n";
<<"%V $k  \n";

<<"%V $i $k $j $m \n";

ignoreErrors(-1)
<<"Margin Calls \n"
!a

!l

  i =0;
 while (1) {
 i++;
<<"mc $i \n"

!a

  if (i > 7) {
     break;
  }

 }

!p i

<<"OK Done\n";