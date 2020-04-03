//%*********************************************** 
//*  @script class_mfcall.asl 
//* 
//*  @comment show mf call 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Tue Mar 31 20:10:28 2020 
//*  @cdate Tue Mar 31 20:10:28 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///
#include "debug"




filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOW_,"proc_","args_","scope_","class_");

debugON()
setdebug(1,@pline,@~trace)

checkIn(0)


Class Scalc
{

 public:
  float a;
  float b;


 CMF mul (int x,int y)
  {
   <<"in $_proc $x $y\n";
    int z;
    z = x*y;
    return z;
  }
//==========================
/{/*
 CMF mul (double x,double y)
  {
   <<"in DOUBLE $_proc $x $y\n";
   float z;
   z = x*y;
    return z;
  }
  /}*/
//==========================

 CMF mul (real x,real y)
  {
   <<"in REAL $_proc $x $y\n";
   real z;
   z = x*y;
    return z;
  }
//==========================



 CMF set (x,y)
 {
   a= x;
   b =y;
 }
 
 CMF print ()
 {
  <<"%V $a $b\n"
 }



//===============================//



};





Scalc acalc;

int c =2;
int d =4;

    ans = acalc->mul(c,d);

 checkNum(ans,8)
<<"$ans \n"

double w = 2.2
double r = 3.3

    fans = acalc->mul(w,r);

<<"$fans \n"
 checkNum(fans,7.26)
<<" $(infoof(acalc))\n"

float fw = 3.3
float fr = 3.3

    fans = acalc->mul(fw,fr);

<<"$fans \n"
checkRnum(fans,10.89)

    fans = acalc->mul(2.0,5.0);

<<"$fans \n"

 checkNum(fans,10.0)

real r1 = 2.2
real r2 = 3.3

r1->info(1)
r2->info(1)

    fans = acalc->mul(r1,r2);

<<"$fans \n"

 checkRNum(fans,7.26)
 checkOut()


    acalc->set(47,79)

    acalc->print();

FV = fgen(10,0,1);

<<"$FV \n"

    ok=examine(FV);

<<"%V $ok\n"



    ok=examine(acalc);

<<"%V $ok\n"

 checkOut()


//////////////////////////////////////////////////

svar S;

  S = "how can we move forward";

    ok=examine(S);

<<"%V $ok\n"




/{/*

// so as yet  no overloading via prototyping --- just replaces

 CMF mul (int x,int y)
  {
   <<"in $_proc $x $y\n";
    int z;
    z = x*y;
    return z;
  }
//==========================

 CMF mul (float x,float y)
  {
   <<"in $_proc $x $y\n";
   float z;
   z = x*y;
    return z;
  }
//==========================


/}*/
