#ifndef _ARRAY_H
#define _ARRAY_H 1


#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>

#include "siv.h"
#include "svar.h"
#include "aop.h"

class Array: public Siv {

 public:

  void prstatus () { cout << "Siv type MD array[][]..." << "\n"; };
  void *memp;
  int memsize;
  Aop aop; 

  int getBounds(int wb) { return aop.getBounds(wb);};

  int getND() { return aop.getND();};
  int reallocMem();

  void storeRow( int *vec, int sb[]);
  void printDimn(int wb, int index);
  void printInnerMatrix(int index);
  void Print();
  
  Array(int wt, int nb, const std::vector<int>& bounds) {
    memp = NULL;
    memsize = 0;
    size = 0;
    dtype = wt;
    setType ( DS_ARRAY); 
    aop.setND(nb);
    aop.initBounds(nb);
    for (int i = 0; i < nb; i++)
      aop.setBounds(i,bounds[i]);
    
    setCW(SI_ARRAY,ON);
    reallocMem();
  };

  ~Array () {
    if (memp != NULL) {
      sfree(memp);
    }
    
    };

};




#endif
