
//  cpp_head.h

#define ASL 0
#define CPP 1
#define USE_GRAPHICS 0

#if CPP
#warning USING_CPP
#define CDBP(x) ans=query(x,"go on",__LINE__,__FILE__);
#define CDB ans=query("?","go on",__LINE__,__FILE__);
#define chkNE(x,y)  chkN(x,y,EQU_, __LINE__);

#include <iostream>
#include <ostream>
#include "utils.h"
#include "vec.h"
#include "uac.h"
#include "cppi.h"

//  IF USING  graphics  - also need to opendll("plot") 
#if USE_GRAPHICS
#include "gline.h"
#include "glargs.h"
#include "winargs.h"
#include "woargs.h"
#include "gevent.h"
#endif
#include "vargs.h"


#endif
           
