#include <iostream>
#include <vector>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

using namespace std;




struct A { A(){ cout << "A"; } };

struct B { B(){ cout << "B"; } };

struct C { C(){ cout << "C"; } };

struct D { D(){ cout << "D"; } };

struct E : D 
 { 
  E(){ cout << "E"; } 
};

struct F : A, B

{

C c;

D d;

E e;

  //  F() : B(), A(),d(),c(),e() { cout << "F" << endl; }
  F()  { cout << "F" << endl; }

};


int main()
{

  F f;




}
