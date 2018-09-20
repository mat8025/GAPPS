#ifndef _AOP_H
#define _AOP_H       1

//#include "sitypes.h"
//#include "types.h"
//#include "win.h"
//#include "simem.h"
#include "siv.h"
#include "range.h"

#include "debug.h"


class Range;
class Siv;

class Aop {

  //friend class Siv;
public:
        int32_t  subnd;
        int32_t  subi_nd;
        int32_t  lhsize;
        int32_t  size;  
        int  *bounds;  
        int nb;
        int nd;
  //public:

        int32_t subsize;

        int  *subset;
        int  *subdimn;

        uint *lhset;
        char **subi;

        Range range;
        Range lhrange;
        Range *crange;

        int  *lhsubset;

  
	int16_t  rcol;  // used for the record col index 
	int16_t  lh_rcol;  // used for the record col index 
	/// Methods
        void makeAop();
        void setSize( int sz ) { size =sz; };
        int getLHsize() { return lhsize;};
        void setLHsize(int sz) { lhsize = sz;};
        int getBounds(int wb );
        int* getBounds() { return bounds; };
        int getND() {return nd;};
        int setND(int snd) {nd = snd;};
        int getSubSize() { return subsize; };
        int ReallocBounds(int newd);
        int InitBounds();
        int initBounds(int nb);
        int setBounds(int dimn, int n);
        int decrBounds(int dimn, int n = 1);
        int incrBounds(int dimn, int n = 1);
        void freeBounds();
        int CopyBounds(Siv *v);
        int setArrayNDB (int newnd);
        int checkVectorBounds (int n, int wtype);
        int CheckBounds();
        void setRcol (int lh, int k);
        int getRcol (int lh);
        int getInnerStep( );
        int computeOffSet(int nds[]);
        int checkValidBounds ();
         int VrangeToSubSet ();
        int SetUpSubi ();
        void freeSubi ();
        int RangeExtend(int wd, int newbd);
	Aop() {

          nd = 0;
          nb = 0;
	  rcol = 0;
	  lh_rcol = 0;
          subnd = 0;
          subi_nd = 0;
          subsize = 0;
          lhsize = 0;

	  bounds = NULL;
          subset = NULL;
          lhsubset = NULL;
          lhset = NULL;
          subdimn = NULL;
          subi = NULL;

          crange = &range;
	};

	~Aop();
};



#endif
