#ifndef _STRV_H
#define _STRV_H 1


#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "siv.h"
#include "svar.h"
#include "aop.h"



class Strv: public Siv {

 public:

  void prstatus () { cout << "Strv is a variable length string " << "\n"; };
  

  Svar v;
  int getBounds(int wb) { return 0;};
  int getND() { return 0;};
  
  void Print() { printf("%s\n",v.cptr(0));};
  void Cpy(const char *msg) { v.cpy(msg);};
  void Store(const char *msg) { v.cpy(msg);};

  
  Strv() {  printf("cons a Strv \n");

    size = 1;
    setType (STRV);
  };
  ~Strv () {};

};


#endif
