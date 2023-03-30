/*//////////////////////////////////<**|**>///////////////////////////////////
//                            rgt.h 
//		          
//    @comment  regression tests for asl xic and cpp
//    @release   Beryllium  
//    @vers 1.1 As Arsenic 6.4.48 C-Be-Cd 
//    @date 03/29/2023 13:29:35    
//    @cdate 03/29/2023         
//    @author: Mark Terry                                  
//    @Copyright   RootMeanSquare - 1990,2023 --> 
//  
// ^.  .^ 
//  ( ^ ) 
//    - 
///////////////////////////////////<v_&_v>//////////////////////////////////*/ 

  
                              

#ifndef _RGT_H
#define _RGT_H 1



#include <iostream>
#include <ostream>

#include "test_l.h"
#include "wotypes.h"
#include "vec.h"
#include "siv.h"
#include "svar.h"
#include "str.h"
#include "list.h"
#include "gevent.h"
#include "mat.h"
#include "gsfont.h"
#include "cppi.h"


class Rgt {
  static uint32_t RGTID; /// only one - it is initialized to zero in global storage

 public:
  uint32_t id;
  Siv Res;
  Siv Isv;
  Vec<double> Vres;
  Vec<float> Vresf;  
  Svar fr;    // function return
  Siv  lastr; // last result
  Str Sres;
 //////////////////////////////////////  METHODS////////////////////////////////////

  uint32_t getRGTD() { return id;};
  // add new app extern C calls

 #include "rgt_methods.h"


 
  Rgt() { id= ++RGTID;};
  ~Rgt(){};
};

#endif
  
