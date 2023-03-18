/*//////////////////////////////////<**|**>///////////////////////////////////
//                            glide.h 
//		          
//    @comment  glide task apps
//    @release   Beryllium  
//    @vers 1.33 As Arsenic 6.4.48 C-Be-Cd 
//    @date 07/23/2022 13:29:35    
//    @cdate 7/23/2022         
//    @author: Mark Terry                                  
//    @Copyright   RootMeanSquare - 1990,2022 --> 
//  
// ^.  .^ 
//  ( ^ ) 
//    - 
///////////////////////////////////<v_&_v>//////////////////////////////////*/ 

  
                              

#ifndef _GLIDE_H
#define _GLIDE_H 1



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


class Glide {
  static uint32_t GLIDEID; /// only one - it is initialized to zero in global storage

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

  uint32_t getGlideID() { return id;};
  // add new app extern C calls

  void glideTask(Svarg * sarg);
  void showTask(Svarg * sarg);  
 
  Glide() { id= ++GLIDEID;};
  ~Glide(){};
};

#endif
  
