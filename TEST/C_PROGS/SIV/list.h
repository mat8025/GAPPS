#ifndef _LIST_H
#define _LIST_H 1


#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "siv.h"
#include "svar.h"
#include "aop.h"

class List: public Siv {

 public:

  void prstatus () { cout << "list is an list of Svars " << "\n"; };
  
  char *ap;
   Aop aop;
   int getBounds(int wb) { return aop.getBounds(wb);};
   int getND() { return aop.getND();};
  List() { printf("cons a List \n"); size = 1; setType (LIST);};
  ~List () {};

};


#endif
