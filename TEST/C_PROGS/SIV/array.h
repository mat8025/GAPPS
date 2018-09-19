#ifndef _ARRAY_H
#define _ARRAY_H 1


#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "siv.h"
#include "svar.h"
#include "aop.h"

class Array: public Siv {

 public:
  virtual void Store () {};
  void prstatus () { cout << "Array is an array or matrix " << "\n"; };
  
  Aop aop;
  int getBounds(int wb) { return aop.getBounds(wb);};
  int getND() { return aop.getND();};
  Array() { size = 1;  setType ( DS_MATRIX); };
  ~Array () {};

};




#endif
