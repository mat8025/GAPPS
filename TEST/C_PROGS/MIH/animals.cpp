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

class Mammal: public Animal {

 public:
  virtual void eat () {};
  void breath () { cout << " Mammals breath air " << "\n"; };

  Mammal() { };
  ~Mammal () {};

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

class Tiger: public Mammal {

public:
  void eat () {
    std::cout << " tigers eat meat - men too!" << "\n";
  }

  Tiger () {};
  ~Tiger () {};
};


class Lamb: public Mammal {

public:
  void eat () {
    cout << " lambs eat grass" << "\n";
  }

  Lamb () { printf("cons a lamb \n");};
  ~Lamb () {};
};

class Shark: public Fish {

public:
  void eat () {
    cout << " sharks eat fish - sometimes men" << "\n";
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


class Dog: public Mammal {

public:
  void eat () {
    cout << " dogs eat meat and bread" << "\n";
  }

  Dog () { printf("cons a dog \n");};
  ~Dog () {};
};

class Cat: public Mammal {

public:
  void eat () {
    cout << " cats eat chicken and fish" << "\n";
  }

  Cat () { printf("cons a cat \n");};
  ~Cat () {};
};

int main ()
{
  Animal *animals[20];
  Animal **ap;
  Animal *bp;
  
  Tiger tiger;
  Lamb lamb;
  Bird bird;
  Shark shark;
  Dog dog;
  Cat cat;  

  Tiger *tp;
  Lamb *lp;
  Bird *birdp;
  Shark *sp;  
  Dog *dp;
  Cat *cp;

  
  int na = 6;

  cout << " cat " << sizeof (cat) << " bird " << sizeof (bird) << " shark " << sizeof (shark) << " dog " << sizeof (dog) <<  "\n" ;


  tp = &tiger;
  tp->eat();
  lp = &lamb;
  lp->eat();
  lp->breath();


  cp = &cat;
  cp->eat();
  
  
  animals[0] = &tiger;
  animals[1] = &lamb;
  animals[2] = &shark;
  animals[3] = &bird; 
  animals[4] = &dog;
  animals[5] = &cat; 

 cout  <<  "\n" ;

  for (int i = 0; i < na; i++) {
   bp = animals[i];
   bp->eat();
   bp->breath();
  }

  cout << "base ptr set to element of ptr array " << "\n";

  
  ap= &animals[0];
  
  for (int i = 0; i < na; i++) {
   bp = *ap++;
   bp->eat();
   bp->breath();
  }

  ap= &animals[0];
  cout  <<  "\n" ;
 
  cout << "using double ptrs " << "\n";

  for (int i = 0; i < na; i++) {
    (*ap)->eat();
    (*ap++)->breath();
  }


}
