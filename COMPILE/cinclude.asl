///
///  cinclude  ---  chain of include asl - cpp compile OK?
///
#define ASL 0
#define CPP 1

#if CPP
 extern "C" int cinclude(Svarg * sarg)  {
#endif
 int n = sarg->getArgI() ;
chkIn(1);
 int A= 59;
cout << " main  arg " << n << " global A " << A  << endl;

#include "pt.asl"


cout << " back in main  " << A  << " from pt " << ele << endl;

chkN(1,1);
chkOut();


#if CPP
 }
#endif
