/* 
 *  @script cinclude.asl  
 * 
 *  @comment test cpp compile include and sfunc 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.73 C-Li-Ta]                                
 *  @date 01/16/2022 10:43:41 
 *  @cdate 01/16/2022 10:43:41 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//

/*
<|Use_= 
Demo  of test cpp compile include and sfunc 
/////////////////////// 
|>


#include "debug" 
  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 

  chkIn(_dblevel)

  chkT(1);
*/
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
