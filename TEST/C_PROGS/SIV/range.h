#ifndef _RANGE_H
#define _RANGE_H  1


#define RANGESEP ':'


// subset operations
#define SUBOP_RNG 1
#define SUBOP_VEC 2
#define SUBOP_ELE 3
#define SUBOP_INV 4


#define RNGSTART   01    // range start specified
#define RNGSTOP    02    // range stop specified
#define RNGSTRIDE  04    // range stride specified
#define RNGALL     010   // range all eles specified
#define RNGINV     020   // range inv op specified
#define RNGFE      040   // range function expression
#define RNGLSET    0100  // range function lset
#define RNGUPREV   0200  // range use previous subset
#define RNGATEND   0400  // range found end of subscript expression
#define RNGEXP     01000 // range found end of subscript expression
#define RNGVALID   02000 // range is valid


//#include "aop.h"

class Aop;
//class Svar;
//class Parset;

class Range
{
 int cw;

 public:

  int start;
  int end;
  int stride;
  int ne;
  int size; // set this
  char rc;
  char gotstart;
  char gotend;
  char gotstride;
  char inv;


  
  Range ()
  {
    Reset();
    size = 0;
  };

  void Reset() ;

  int Compute();
  int Set( int val, int pos, int na) ;
  void setCW(int wd, int on) { cw = (on) ? (cw | wd) : (cw & ~wd); };
  int testCW(int wd) {  return ((cw & wd) == wd); };
  int getCW() { return cw; };
  int getStart(int sz);
  int getEnd();
  int getStride();
  int getSize() { return size;};
  void EvalRange (Aop *aop, int wd, int val, int val_status);
  void ClearCW() { cw =0; };
  char *PrintCW();

};



void circular_address ( int &cele, int stride, int vsize);
//char *check_sub_ele (int subs, Svar * val, char *dep, Range * range);
void EvalRange (Range * range, char * val2, char *dp, int nb, int atend,  int gotval);
#endif
