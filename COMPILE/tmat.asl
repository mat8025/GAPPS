//%*********************************************** 
//*  @script tmat.asl 
//* 
//*  @comment test Mat class compiled to cpp 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.87 C-He-Fr]                                
//*  @date Mon Nov 23 09:20:23 2020 
//*  @cdate Mon Nov 23 09:20:23 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%



#include <iostream>
#include <ostream>
#include <fstream>
#include <limits.h>
#include <string.h>
#include <iomanip>
#include <stdio.h>
#include <stdlib.h>
#include "df.h"
#include "uac.h"
#include "mat.h"
using namespace std;

//////////////   GLOBALS ///////////////


extern "C" int
tmat(Svarg * s)
{


Svar sv;
 long mrow,mcol;
 double d;
 double val;
 uint mre = 1;

 cout <<  __FUNCTION__  <<" as cpp compiled version " << endl ;
  
int V[10] = {1,2,3,4,5,6,7,8,9,10};

   printf("%d\n",V[1]);


int M[10][10];

     M[1][2] = ptan("Er");
     M[2][3] = ptan("Hg");     

printf("%d\n",M[1][2]);
printf("%d\n",M[2][3]);
printf("%d\n",M[3][4]);

cout << "M[][] " << M[1][2] << " " << M[2][3] << " " << M[3][4] << endl;


//V->info(1)


//E->info(1);

Siv D(INT_, 2, 2, 3);

  printf("D:%s \n",D.info());

Mat MA(INT_,5,4);


printf("M:%s \n",MA.info());

    cout <<  MA.info() << endl;



    MA += (int) 54;
    MA.setRow(3,V);
      
cout << endl << "MA  " << MA << endl ;   

Mat MB(INT,5,4);

printf("MB:%s \n",MB.info());

      MB += 5;
      MB.setRow(2,V);

cout << endl << "MB setRow(2,V) \n" << MB << endl ;   

Mat MC(INT,5,5);

    MC += ptan("krypton");

cout << endl << "MC  \n" << MC << endl ;   

  Vec V2(INT,4,64,1);

cout << endl << "V2  \n" << V2 << endl ;   


cout << endl << "MA  \n" << MA << endl ;

    MC = MA ;

cout << endl << "MC  = MA  \n" << MC << endl ;


  mrow = 3;
  MB(3L,RALL) = V2;


cout << endl << "MB  \n" << MB << endl ;   

     MB(3L,2L) = 79.0D;

cout << endl << "MB  \n" << MB << endl ;   

     val = MB(3U,2U);

cout << endl << "val " << val << endl ;   

MB.pinfo();

     MB.Transpose();

cout << endl << "MB Transpose() \n" << MB << endl ;

/*
//    MC = MA + MB;

//cout << endl << "MC  = MA + MB \n" << MC << endl ;





   MC = MA * MB;

cout << endl << "MC = MA * MB " << MC << endl ;


//
*/

    d=  MB(mre,2);
cout << " ele " << mre << " " << d << endl;

    d += 14;
     MB((long) mre,2) = d;

cout << endl << "MB  \n" << MB << endl ;   

Str sa;
Siv v;


//  Siv *sivp =va_arg(args, Siv*);
 
  testargs(6,&v,&MA,&MB,&V2,&sa,&sv);
//   testargs(&v);
  
  Vec I(INT,30,0,1);

I.pinfo();
//printf("I:%s \n",I.info());

chkN(I[29],29);
I.info();

I.Reverse();

printf("I:%s \n",I.info());

chkN(I[29],0);
//I.info();

I.Reverse();

I.pinfo();

//printf("I:%s \n",I.info());

chkOut();

}

