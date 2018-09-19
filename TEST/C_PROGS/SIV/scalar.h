#ifndef _SCALAR_H
#define _SCALAR_H 1


#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "siv.h"
#include "svar.h"
#include "aop.h"

class Scalar: public Siv {

 public:

  void prstatus () { cout << "Scalar is a scalar " << "dtype " << dtype << "\n"; };
  int getBounds(int wb) { return 0;};
  int getND() { return 0;};

  void *memp; // pointer to memory for standard types and arrays
  char mem[16];
  int ndbs; // set to num bytes needed for the data type;
  
  Scalar(int wt) { size = 1;
                   setType ( DS_SCALAR);
                   dtype = wt;
		   memp = &mem;
		   Store ((int) 0);
                   };
  void Store(int v) { ndbs = sizeof (int); int *vp = (int *) memp ; *vp = v;};
  void Store(float v) {ndbs = sizeof (float); float *vp = (float *) memp ; *vp = v;};
  void Store(long v) { ndbs = sizeof (long); long *vp = (long *) memp ; *vp = v;};
  void Store(double v) {ndbs = sizeof (double); double *vp = (double *) memp ; *vp = v;};
  
  void showMem() { for (int i = 0; i < ndbs; i++) { printf("%x,",mem[i]);} printf("\n");};
  ~Scalar () {};

};




#endif
