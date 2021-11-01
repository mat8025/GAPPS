//%*********************************************** 
//*  @script tvec.asl 
//* 
//*  @comment test Vec class and ops compiled to cpp 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.87 C-He-Fr]                               
//*  @date Mon Nov 23 09:24:39 2020 
//*  @cdate Mon Nov 23 09:24:39 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

///
/// test Vec creation and ops
///
#include <iostream>
#include <ostream>
#include <fstream>
#include <limits.h>
#include <string.h>
#include <iomanip>
#include <stdio.h>
#include <stdlib.h>
#include "df.h"
#include "vec.h"
using namespace std;

//////////////   GLOBALS ///////////////



extern "C" int
tvec(Svarg * s)
{
 Svar sv;
 double d,e,f;
 int i;
 cout <<  __FUNCTION__  <<" as cpp  " << endl ;

// int VC[10] = {1,2,3,4,5,6,7,8,9,10};

 Vec V(DOUBLE,10,10,1);

 cout <<  V.info() << endl;
 cout <<" V gen\n" << V ;


 
  V(3) = 76;
  V(8) = 44;
  V(9) = 90;
  cout <<" V element assign\n" << V << endl ;

  d = V[3];
  e  = V[8];
  f = V[9];

  i = V[7];
  V(1) = i;
  cout <<" V element assign\n" << V << endl ;
 cout << " d= V[3]  "<< d <<  endl;
 cout << " e= V[8] "<< e <<  endl;
  cout << " f= V(9) "<< f <<  endl;
  cout << " i= V(7) "<< i <<  endl;

  cout <<  V.info() << endl;

  V(R(1,9,2)) = i;

cout <<" V range assign\n" << V << endl ;

   Vec V2(DOUBLE,10,100,1);

cout <<" V2\n" << V2
<< endl ;


   V(R(1,9,2)) = V2(R(1,9,2));


   cout <<" V subrange set\n" << V << endl ;

   cout << "how did we do? "<< endl;

}