#ifndef _PAN_H
#define _PAN_H 1


#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "siv.h"
#include "svar.h"
#include "aop.h"


class Pan: public Siv {

 public:
  void prstatus () { cout << "Pan is an arbitary length number " << "\n"; };

  int size;
  double d;
  Aop aop;

	////////// Member Functions /////////
        int getBounds(int wb) { return aop.getBounds(wb);};
	int getND() { return aop.getND();};

  Pan() { printf("cons a Pan \n"); size = 1; setType (PAN);};
  ~Pan () {};

};



#endif
