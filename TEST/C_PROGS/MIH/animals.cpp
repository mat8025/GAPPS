#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

class Animal {
public:
  virtual void eat () = 0;
  virtual void breath () = 0;

  Animal() { };
  ~Animal () {};

};

class Mamal: public Animal {

 public:
  virtual void eat () {};
  void breath () { cout << " Mamals breath air " << "\n"; };

  Mamal() { };
  ~Mamal () {};

};


class Fish: public Animal {

 public:
  virtual void eat () {};
  void breath () { cout << " Fish breath oxygenated water " << "\n"; };

  Fish() { };
  ~Fish () {};

};


class Reptile: public Animal {

 public:
  virtual void eat () {};
  void breath () { cout << " Reptiles breath air " << "\n"; };

  Reptile() { };
  ~Reptile () {};

};

class Tiger: public Mamal {

public:
  void eat () {
    std::cout << " tigers eats meat - men too!" << "\n";
  }

  Tiger () {};
  ~Tiger () {};
};


class Lamb: public Mamal {

public:
  void eat () {
    cout << " lambs eats grass" << "\n";
  }

  Lamb () { printf("cons a lamb \n");};
  ~Lamb () {};
};

class Shark: public Fish {

public:
  void eat () {
    cout << " sharks eats fish - sometimes men" << "\n";
  }

  Shark () { cout << "cons a Shark \n" ; };
  ~Shark () {};
};


class Bird: public Reptile {

public:
  void eat () {
    cout << " birds eats seeds and worms" << "\n";
  }

  Bird () {  };
  ~Bird () {};
};


int main ()
{
  // Animal a;
  Animal *animals[10];
  Animal **ap;
  Animal *bp;
  Tiger t;
  Lamb l;
  Bird b;
  Shark s;
  Tiger *tp;
  Lamb *lp;
  int na = 4;
  char c;
  bool bl;
  short si;
  long k;
  long long j;
  float f;
  double d;
  long double dl;

  cout << " char " << sizeof (c) << " bool " << sizeof (bl) << " short " << sizeof (si) << " int " << "\n" ;
  cout <<  sizeof (na) << " long " << sizeof(k) << " long long " << sizeof (j) << "\n";
  cout << " float " << sizeof (f) << " double " << sizeof (d) << " ld " << sizeof (dl) << " \n";


  tp = &t;
  tp->eat();
  lp = &l;
  lp->eat();
  lp->breath();

  animals[0] = &t;
  animals[1] = &l;
  animals[2] = &s;
  animals[3] = &b;

  ap= &animals[0];

  for (int i = 0; i < na; i++) {
  bp = animals[i];
  bp->eat();
  bp->breath();
  }

  cout << "base ptr set to element of ptr array " << "\n";

  for (int i = 0; i < na; i++) {
  bp = *ap++;
  bp->eat();
  bp->breath();
  }

  ap= &animals[0];

  cout << "using double ptrs " << "\n";

  for (int i = 0; i < na; i++) {
    (*ap)->eat();
    (*ap++)->breath();
  }


}
