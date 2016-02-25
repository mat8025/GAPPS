
#ifndef _DMA_H
#define _DMA_H 1

#include "dv.h"

typedef struct Ddma
{
  char name[100];
  int  chan;
  DV *dv;
}
  DMA;

#endif
