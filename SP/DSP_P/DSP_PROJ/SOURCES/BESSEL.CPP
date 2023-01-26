//
//  File = bessel.cpp
//
//  modifed bessel function of the first kind
//  and order zero

#include <stdlib.h>
#include "bessel.h"

double bessel_I_zero(double x)
{
  double sum, numer, denom, term, half_x;
  sum = 1.0;
  half_x = x/2.0;
  denom = 1.0;
  numer = 1.0;
  for( int m=1; m<=32 ; m++)
    {
    numer *= half_x;
    denom *= m;
    term = numer/denom;
    sum += term*term;
    }
  return(sum);
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
