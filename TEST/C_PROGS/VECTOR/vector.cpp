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

    V[3]= 28;

  cout << "vector V "<< V << endl;

  Vector <double> D(10);

  
  D[1]= 77.66;
  D[3]= 47.99;  

  cout << "vector D "<< D << endl;


  double d = D[1];



  

  cout << " d =  D[1];  "<< d << endl;


  D = V;

    cout << "vector D "<< D << endl;

  Vector <float> F(10);

  
  F[1]= 13.66;
  F[3]= 74.99;  

cout << "vector F "<< F << endl;
  
D = F;
  
  cout << "vector D "<< D << endl;


  d = D[1];

  cout << " d =  D[1];  "<< d << endl;

  float f = F[3];

  cout << " F =  F[3];  "<< f << endl;

  f = 123.456;

  F[5] = f;

  cout << "vector F "<< F << endl;
  
    
}
