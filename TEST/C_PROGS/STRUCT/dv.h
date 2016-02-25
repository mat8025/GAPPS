#ifndef _DV_H
#define _DV_H 1

//typedef struct Ddma *DmaPtr;
typedef struct Dmcbsp *McbspPtr;

//struct Ddma;

typedef struct D708V
{
  char name[100];
//  DmaPtr dma;
  struct Ddma *dma;
  McbspPtr mcbsp;
}
  DV;

#endif
