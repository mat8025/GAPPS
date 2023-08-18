///
///   create an asc file (cpp compatible) from asl script
///



#define _CPP_ 0
// asl  -T  flag to produce cpp compilable code 
//  the script xyz.asl  is converted to xyz.asc  and that file can be compled with cpp
//  the translation flips the _CPP_ define to 1  in the resulting asc file
//  the make_asc  script  will compile  asc code
//  e.g. make_asc  xyz.asc

//  just using asl  interpreter skips over _CPP_ sections in the asl script
//  and defines _ASL_ and _TRANS_ to 1
//

#if _CPP_
#include <iostream>
#include <ostream>

using namespace std;
#include "vargs.h"
#include "cpp_head.h" 
#include "consts.h"
#define PXS  cout<<



#define _ASL_ 0
#define _TRANS_ 0
#endif


double  A_ = 3.142

const double He = 1.2

const float Li = 1.2
#if _TRANS_
const float LegK_ =  0.5 * (7915.6 * 0.86838)
const float  nm2km_ = 1.852
#endif

#if _TRANS_
//#include "consts"
#endif
///////////////  GLOBALS //////////////////


////////////////////////////////////////////////



#define WX 1

///////////////  GLOBALS //////////////////

#include "inc1.asl"

void setScreen()
{
  bX = 0.4
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 bY = by - ypad // FIX no semi
   by = bY - yht
 

<<" %V $bY $by $ypad \n"
}

#define ASZ 10
int N = 12

int Veci[ASZ]

////////////////////////////////////////////////


               
  float computeGCD(float la1,float la2,float lo1,float lo2)
  {
///  input lat and long degrees - GCD in km
     //float rL1,rL2
     
     float rlo1,rlo2,D, km;
     
  // TBF 8/12/23  -- ideally all rL1,...  should auto_dec
               
     rL1 = d2r(la1) 
               
     rL2 = d2r(la2) 
               
     rlo1 = d2r(lo1) 
               
     rlo2 = d2r(lo2) 
               
     D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2)) 
               
     km = LegK_ * D  * nm2km_ 
 // printargs ("km ",km)
     return km 
               
  }
//==================================================
               
   





#if _CPP_

int main( int argc, char *argv[] ) { // main start
///
#endif               
   ignoreErrors()
   
int a =1
int b= 0
int t
int i

int j
float MidLat


  <<" $(getVersion()) \n"

   release = "";

   pinfo(release);

   release = "5.16"

   <<"$release\n"

   k = 80;

   release = itoa(k)
   
<<"%V $k ==>$release\n"



   m = 92
   r = 3.142

  MidLat = (r - m)/2.0 + r   

 for (j=0; j < 6; j++) {
    a= 1
    b= 0
    for (i=0; i<N;i++) {

       Veci[i] = b
       t = a
       a = t + b
       b = t
   <<"%V $t $b $a\n"
    }

<<"$Veci \n"

  <<" $Veci[j] \n"
//  ans=query(">")
  }

<<"%V $Inc1_val \n"

   while (j < 10) {
<<"%V $j \n"
    j++
   }

#if _CPP_              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
