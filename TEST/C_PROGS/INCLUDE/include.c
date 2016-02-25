
float y = 1.2345;
int n = 0;

#include <stdio.h>
#include "inc.h"



int main (int argc, char **argv)
{
  int blue;
  int yellow;
  int green;

#include "inc2.h"
#include "inc3.h"
  yellow = YELLOW;
  printf("y is %f n is %d\n",y,n);
  blue = BLUE;
  printf("blue is %d\n",blue);

  if (yellow == YELLOW) {

#include "inc4.h"

  }

  green = GREEN;

  printf("green is %d\n",green);

}
