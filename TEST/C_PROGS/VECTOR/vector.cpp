#include <iostream>
#include <ostream>
#include <fstream>
#include <limits.h>
#include <string.h>
#include <iomanip>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

#include "vector.h"


int main()
{
  Vector <int> V(10);

  
  V[1]= 77;

  cout << "vector V "<< V << endl;

  Vector <double> D(10);

  
  D[1]= 77.66;

  cout << "vector D "<< D << endl;


  double d = D[1];

  cout << "d=  D[1];  "<< d << endl;


  // D = V;

  // cout << "vector D "<< D << endl;
  
}
