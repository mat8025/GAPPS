/*//////////////////////////////////<**|**>///////////////////////////////////
//                           vmf_l.asl 
//		          
//    @comment  var 
//    @release   5.59 Boron_Praseodymium  
//    @vers 1.37 Rb Rubidium  
//    @date 12/18/2023 09:49:44    
//    @cdate @cdate 11:04:40 Thulium 6.4.76 C-Be-Os    
//    @author: Mark Terry                                  
//    @Copyright   RootMeanSquare - 1990,2023 --> 
//  
// ^.  .^ 
//  ( ^ ) 
//    - 
///////////////////////////////////<v_&_v>//////////////////////////////////*/ 


#include "vmf_l.h"

 //  asl variables are modified by calling  a member function
  //  e.g.   f->Limit(0,1)
  //  limits a variable to => 0 <=1
  //  asl variable can be array

//Svar srv;

int
Vmf::fl (Siv * sivp,Svarg * s)
{
  int flen = 0;
  if (sivp->checkType(PAN)) {
    sivp->getPan()->setExpZero();
    return s->result->Store (sivp->getPan()->flength);
    
  }
  else {
    if (!sivp->isIntType()) {
      // convert double
      // trunc
      // get fraction
      // convert to pan dec radix
      // flen ? 
      
    }
    return s->result->Store (flen);
  }

}

//[EF]===========================================//
