#include <iostream>
#include <vector>
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
  T() { k = 0; y = 1.0;
    printf("contructor %u\n",this);}
  ~T() { printf("calling destructor %u\n",this); } ;

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
  Foo() { value = 3.14259; k = 797;};
  Foo(int j, float y) {  k = j; value = y;};
  ~Foo() { printf("calling destructor %u\n",this); } ;
  operator double()
  {
    return (double) value;
  }
  operator int()
  {
    //       return k;
    return value;

  }
  void print()
  {
    cout << value << " " << k << endl;

  };

};


main() 
  {

  char mem[sizeof(Foo)];
  void *place = mem;
  char *cp = mem;
  Foo *Fm = new(place) Foo;
  
  Fm->print();
  cout << " ---------------------" << endl;
  for (int i = 0; i < sizeof(Foo) ; i++){
  printf("%X \n",*cp++);
  }
  cout << " ---------------------" << endl;
  T *q;
  Fm->~Foo();
  {
  T *p = new T[10];
  q = p;
  p->k = 2;
  p->y = 31.42;
  p->print();
  p++;
  p->print();
  p--;

  //  delete [] p;

  Foo F;

  double d = F;
  int j = F;

  cout << " d " << d << " j " << j << endl ;
  }

  q->print();

  std::vector<Foo> a(10,Foo(3,4.5));

  a[0].print();

  delete [] q;
  cout << "that's all " << endl ;
  }
