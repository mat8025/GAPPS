#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

using namespace std;


class T 
{
public:
  int k;
  float y;
  void print() { cout << k << " " << y << endl; };
  T() { k = 0; y = 1.0;}
};



main() 
  {

  T *p = new T[10];

  p->k = 2;

  p->print();


  delete [] p;
  

  p->k = 2;

  p->print(); 

  p++;


  p->k = 2;

  p->print(); 


  p[5].k = 3;


  p[5].print(); 


  }
