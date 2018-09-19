#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;


#include "defs.h"
#include "svar.h"
#include "siv.h"

#include "scalar.h"
#include "record.h"
#include "vector.h"
#include "array.h"
#include "pan.h"
#include "list.h"
#include "strv.h"

int
main ()
{

  Siv *sivs[20];
  Siv **sivp;
  Siv *bp;

  Scalar scalarv(INT);
  Scalar scalarf(FLOAT);
  Scalar scalard(DOUBLE);  

  Scalar *scalarp;


  Vector vector;
  Vector *vectorp;
  
  Array array;
  Array *arrayp;

  List list;
  List *listp;

  Strv strv;
  Strv *strvp;



  Pan pan;
  Pan *panp;


  Record record;
  Record *recp;

  

  Svar svar;



  int na = 9;			// #num of Siv types so far

  char c;
  bool bl;
  short si;
  long k;
  long long j;
  float f;
  double d;
  long double dl;

  cout << " char " << sizeof (c) << " bool " << sizeof (bl) << " short "
    << sizeof (si) << " int " << "\n";
  cout << sizeof (na) << " long " << sizeof (k) << " long long " << sizeof (j)
    << "\n";
  cout << " float " << sizeof (f) << " double " << sizeof (d) << " ld " <<
    sizeof (dl) << " \n";



  cout << " Scalar " << sizeof (scalarv) << "\n";
  cout << " Vector " << sizeof (vector) << "\n";  
  cout << " Array " << sizeof (array) << "\n";
  cout << " Strv " << sizeof (strv) << "\n";
  cout << " Record " << sizeof (record) << "\n";
  cout << " Pan " << sizeof (pan) << "\n";
  cout << " List " << sizeof (list) << "\n";


  cout << " Svar " << sizeof (svar) << "\n";


  vectorp = &vector;
  vectorp->prstatus ();
  

  strvp = &strv;
  strvp->prstatus ();

  recp = &record;
  recp->prstatus ();

  listp = &list;
  listp->prstatus ();


  sivp = &sivs[0];

  *sivp++ = &scalarv;
  *sivp++ = &vector;  
  *sivp++ = &array;
  *sivp++ = &strv;
  *sivp++ = &record;
  *sivp++ = &pan;
  *sivp++ = &list;
  *sivp++ = &scalarf;
  *sivp++ = &scalard;


  int val = 80;
  scalarv.Store(val);

  
  sivp = &sivs[0];
  



  for (int i = 0; i < na; i++)
    {
      bp = sivs[i];
      bp->prstatus ();
      bp->getSize ();
    }

  cout << "base ptr set to element of ptr array " << "\n";

  for (int i = 0; i < na; i++)
    {
      bp = *sivp++;
      bp->prstatus ();

    }

  sivp = &sivs[0];

  cout << "using double ptrs " << "\n";

  for (int i = 0; i < na; i++)
    {
      (*sivp)->prstatus ();
      (*sivp++)->getSize ();
    }


  // STRV OPS
  //strvp->v->cpy("Hi How are you!\n");
  printf("Strv siv\n");
  strvp->Cpy ("Hola como estas\n");
  strvp->Print ();

  strvp->Store ("Bien - Mucho gusto\n");
  
  strvp->Print ();




  scalarv.showMem();
  
  printf("Scalar siv\n");
  printf("INT\n");


   int i =0;
   scalarv.Store(i);
   scalarv.showMem();
   i = 1;
   scalarv.Store(i);
   scalarv.showMem();
   i = -1;
   scalarv.Store(i);
   scalarv.showMem();   

   
   printf("FLOAT\n");

   //   for (int i = 0; i < 3; f=i, i++) {

   scalarv.Store(f);
   scalarv.showMem();
   f = 1;
   scalarv.Store(f);
   scalarv.showMem();
   f = -1;   
   scalarv.Store(f);
   scalarv.showMem();

   printf("DOUBLE\n");


   scalarv.Store(d);
   scalarv.showMem();
   d = 1;
   scalarv.Store(d);
   scalarv.showMem();
   d = -1;   
   scalarv.Store(d);
   scalarv.showMem();

   /*
   for (int i = 0; i < 3; d=i, i++) {
     scalarv.Store(d);
     scalarv.showMem();
   }
   */

   int vec[10];

   for (int i = 0; i < 10; i++) {
     vec[i] =i;
   }

   vectorp->Store(vec,10);

   printf(" vec contents:\n");
      vectorp->Print();


   Vector fvector(FLOAT);
   float fvec[50];

   for (int i = 0; i < 50; i++) {
     fvec[i] =i;
   }

   vectorp = &fvector;
   
   vectorp->Store(fvec,10);

   printf(" vec contents:\n");
      vectorp->Print();


  vectorp->Store(fvec,50);
      
  vectorp->Print();

   double dvec[50];

   for (int i = 0; i < 50; i++) {
     dvec[i] = i * 0.05;
   }

   
   Vector dvector(DOUBLE);
   vectorp = &dvector;
   vectorp->Store(dvec,50);
   vectorp->Print();

   
  
  // RECORD OPS
  // make a 10 row record -- split a string into fields
  // input row Split("a,b,c,d,e") into row0
  // copy row0 to row1
  // input another row Split("a,b,c,d,e")
  // print record

}
