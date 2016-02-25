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
  operator double()
  {
    return (double) y;
  }

};

class Foo
{
  double value;
  int k;
  public:
  Foo() { value = 3.14259; k = 787;};
  operator double()
  {
    return (double) value;
  }
  operator int()
  {
    //       return k;
    return value;

  }


};


main() 
  {

  T *p = new T[10];

  p->k = 2;
  p->y = 31.42;
  p->print();
  Foo F;

  double d = F;
  int j = F;

  cout << " d " << d << " j " << j << endl ;

  }
