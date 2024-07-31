/* 
 *  @script vec.asl                                                     
 * 
 *  @comment test vec class                                             
 *  @release 6.38 : C Sr                                                
 *  @vers 1.2 H Hydrogen [asl 6.38 : C Sr]                              
 *  @date 06/26/2024 20:42:01                                           
 *  @cdate 11/05/2021                                                   
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


#define __CPP__ 0

#if __ASL__
Str Use_= " Demo  of test vec class      ";
 Svar argv = _argv;  // allows asl and cpp to refer to clargs
 argc = argc();
 
  allowDB("spe_declare,ic_,prep_",1)

/*
#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 
*/

   allowErrors(-1); // set number of errors allowed -1 keep going 

#endif       

// CPP main statement goes after all procs
#if __CPP__

#define USE_GRAPHICS 0

#include <iostream>
#include <ostream>
using namespace std;
#include "vargs.h"
#include "cpp_head.h"
#define PXS  cout<<

#define CPP_DB 0

  int main( int argc, char *argv[] ) {  
     init_cpp(argv[0]); 

#endif       


  chkIn(1) ;

  chkT(1);

  ka = 23


//  n.pinfo();

  m = 128
  
  n= 10;
  Vec U92(< int >,n,m,1) ;
  U92.pinfo();  
  <<"U92 \n"
  
  Vec<int> V1(12,32,1);  // TBF 6/26/24  trans ===> Vec<int> V(12,255,0)

 // Vec U1(INT_,n,m,1) ;

//  U1.pinfo()


//NIF 11/05/21 - declare via function


  Vec U(<int>,n,m,1) ;

  chkN(U[0],128);

  chkN(U[9],137);


 // type  num_of_vals, initial_value , step_value


  Vec V(< int>,12,32,1);  // TBF 6/26/24  trans ===> Vec<int> V(12,255,0);
  // does  Vec V(int,12,32,1)  work or can be parsed correctly also < int > ?
  V.pinfo();

  chkN(V[0],32);

  chkN(V[11],43);







 // Vec D(double_,n,0.1,0.1) ;
  Vec D(<double>,n,0.1,0.2,1) ;
//NIF 11/05/21 - declare via function

  D.pinfo();

  chkN(D[0],0.1);

  chkN(D[n-1],1.9);



  Vec<float> F(n,0.1,0.1) ;


  F.pinfo();

  chkN(F[0],0.1);

  chkN(F[n-1],1.0);

  F[2] = 0.787;

  f3 = F[3]
  f4 = F[4]
  <<"F[2] $F[2] $f3 $f4\n"

  Vec<short> S(n,1,1) ;


  S.pinfo();

  S[2] = 77

  s3 = S[3]

  <<"%V $S[2] $s3 \n"


  chkN(S[0],1);

  chkN(S[n-1],10);


  Vec<char> C(n,1,1) ;  // TBF Vec< char>  fails rm WS between < char> ?


  C.pinfo();

  chkN(C[0],1);

  chkN(C[n-1],10);

///
//  int rwo,bwo,gwo = 1; // TBF 7/6/24

  rwo = 1
  bwo = 2
  gwo = 3

  int rgbiv[] = {rwo, gwo, bwo,  -1 , 4, 8} 

<<" %V $rgbiv[2] \n"

//  Vec<int> rgbwo( {rwo, gwo, bwo,  -1 , 4, 8} ); // TBF 7/6/24 ASL



  //rgbwo.pinfo()

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
