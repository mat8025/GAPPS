#ifndef _VECTOR_H
#define _VECTOR_H 1


#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "siv.h"
#include "svar.h"
#include "aop.h"


class Vector: public Siv {

 public:
  
  void prstatus () { cout << "Siv type vector[] of number types" << "\n"; };
  void *memp;
  int memsize;
  Aop aop;
  
  int getBounds(int wb) { return aop.getBounds(0);};
  int getND() { return aop.getND();};
  int reallocMem(int n);

  void Store( char *vec, int n);    
  void Store( short *vec, int n);    
  void Store( int *vec, int n);
  void Store( long *vec, int n);    
  void Store( float *vec, int n);
  void Store( double *vec, int n);

  void Print();

  Vector(int wt = INT) {
    memp = NULL;
    memsize = 0;
    size = 0;
    dtype = wt;
    setType ( DS_VECTOR);  
    aop.setND(1);
    aop.initBounds(1);
    aop.setBounds(0,1);
    setCW(SI_ARRAY,ON);
    reallocMem(1);
  };

  
  ~Vector () {
    //cout << "destructing vector " << "\n";
    // delete aop;
    if (memp != NULL) {
      sfree(memp);
    }
    //cout << "destructed vector " << "\n";
  };

};



#endif
