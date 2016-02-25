#include <iostream>
#include <vector>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

using namespace std;


class Ovl 
{
  int i;
  int m;

public:

  Ovl() { i = 1; m = 2;};

  Ovl(int j, int q) { i = j; m = q;};

 
 Ovl operator+(Ovl op2 ) {
    Ovl tmp;
    tmp.m = m;
    tmp.i = i + op2.i;
    return (tmp);
  };

  void Print() {

    cout << " i " << i << " m " << m << endl;

  };

};




  int main ()
  {

    Ovl x(3,4);
    Ovl y(5,6);

    x.Print();
    y.Print();

    x = x + y;
    
    x.Print();



  }
