///////////////////////////////////<**|**>///////////////////////////////////
//                                   range.h 
//       
//    @comment  class for vec/array range specs  
//    @release   CARBON  
//    @vers 1.14 Si Silicon                                              
//    @date Thu Nov 26 14:13:42 2020    
//    @cdate 1/1/2002              
//    @Copyright   RootMeanSquare - 1990,2019 --> 
//    @author: Mark Terry                                  
//  
// ^. .^ 
// ( ' ) 
//   - 
///////////////////////////////////<v_&_v>/////////////////////////////////// 

#ifndef _RANGE_H
#define _RANGE_H  1


#define RANGESEP ':'

#define RALL  (long)-1     //  all rows, all cols
#define RINIT (long)-2     // reset so RHS overwrites
#define RALL_ RALL
#define RINIT_ RINIT


// subset operations
#define SUBOP_NOP 0
#define SUBOP_RNG BIT1
#define SUBOP_LIST BIT2
#define SUBOP_VEC  BIT3
#define SUBOP_ELE  BIT4
#define SUBOP_INV  BIT5
#define SUBOP_REP  BIT6
#define SUBOP_NOT  BIT7


#define RNGSTART    01    // range start specified
#define RNGSTOP     02    // range stop specified
#define RNGSTRIDE  04    // range stride specified
#define RNGALL        010   // range all eles specified
#define RNGINV        020   // range inv op specified
#define RNGFE         040   // range function expression
#define RNGLSET      0100  // range function lset
#define RNGUPREV   0200  // range use previous subset
#define RNGATEND   0400  // range found end of subscript expression
#define RNGEXP      01000 // range found end of subscript expression
#define RNGVALID   02000 // range is valid
#define RNGLH        04000 // range is for LH side
#define RNGELE     010000 //


//#include "svar.h"

//class Siv;
//class Svar;
//class Parset;
struct bes
{
  int rvec[4]; //  start,end,stride
};

class Range
{
 int cw;

 public:

  int start;
  int end;
  int stride;
  int ne;
  int cindex;
  long  range;
  char rc;
  char gotstart;
  char gotend;
  char gotstride;
  char inv;

  // Siv *sivp;
  
  Range ()
  {
    //   sivp = NULL;
    Reset();
  };

  void Reset() ;
  void setRange( long rng) { range = rng;};
  void setRange( int b, int e, int s) { start=b;end = e; stride = s;};
  long getRange( ) { return range;};
  
  void codeRange();
  void decodeRange();

  int Compute();
  int Set( int val, int pos, int na) ;
  void setCW(int wd, int on) { cw = (on) ? (cw | wd) : (cw & ~wd); };
  int testCW(int wd) {  return ((cw & wd) == wd); };
  int getCW() { return cw; };
  int getStart();
  int getEnd();
  int getStride();
  int validate();

  void ClearCW() { cw =0; };
  char *PrintCW();

};



int circular_address ( int& cele, int stride, int vsize, int end = -1);
//char *check_sub_ele (int subs, Svar * val, char *dep, Range * range);
void EvalRange (Range * range, char * val2, char *dp, int nb, int atend,  int gotval);

long Rng(int beg,int end, int stride);
int Dcr(long Rng,int *beg,int *end, int *stride);

#endif
