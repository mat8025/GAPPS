#include <stdio.h>
#include <string.h>

#include "dv.h"
#include "dma.h"



int
main(int argc, char *argv[])
{
  DV dv1;
  DV dv2;
  DMA chan0;
  DMA chan1;

  dv1.dma = &chan0;
  chan0.dv = &dv1;
  strcpy(chan0.name, "dma_chan0");
  printf("chan0 %s dv_chan %s\n",chan0.name,dv1.dma->name);
  

  return 0;
}

