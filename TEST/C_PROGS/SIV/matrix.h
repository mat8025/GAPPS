#ifndef _MATRIX_H
#define _MATRIX_H 1


#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "siv.h"
#include "svar.h"
#include "aop.h"

class Matrix: public Siv {

 public:

  void prstatus () { cout << "Siv type Matrix [][] " << "\n"; };
  void *memp;
  int memsize;
  Aop aop;

  int getBounds(int wb) { return aop.getBounds(wb);};
  int getND() { return aop.getND();};
  int reallocMem(int r, int c);

  void storeRow( int *vec, int row, int n);
  void Print();
  Matrix(int wt = INT) {
    memp = NULL;
    memsize = 0;
    size = 0;
    dtype = wt;
    setType ( DS_MATRIX); 
    aop.setND(2);
    aop.initBounds(2);
    aop.setBounds(0,2);
    aop.setBounds(1,2);    
    setCW(SI_ARRAY,ON); // set dimn [1][1]
    reallocMem(2,2);
  };

  ~Matrix () {
    if (memp != NULL) {
      sfree(memp);
    }
    
    };
};




#endif
