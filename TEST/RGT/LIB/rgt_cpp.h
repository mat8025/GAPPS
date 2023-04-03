
#warning USING_CPP
extern Str Qans;
#define CDBP(x) ans=query(x,"go on",__LINE__,__FILE__);
#define CDB Qans=query("?","go on",__LINE__,__FILE__);
#define QANS Qans=query("?","go on",__LINE__,__FILE__);
#define chkEQ(x,y)  chkN(x,y,EQU_, __LINE__);

#include <iostream>
#include <ostream>

#include "vec.h"
#include "uac.h"
#include "gline.h"
#include "glargs.h"
//  IF USING  graphics
#include "winargs.h"
#include "woargs.h"
#include "vargs.h"
#include "gevent.h"

