/* 
 *  @script chain_mfcall.asl 
 * 
 *  @comment show mf call 
 *  @release CARBON 
 *  @vers 1.3 Li 6.3.87 C-Li-Fr 
 *  @date 02/23/2022 10:51:05          
 *  @cdate Tue Mar 31 20:10:28 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                 

///
///
///
#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn (_dblevel);

   real goo( real x)
   {
     a= 2* x;
     <<"$_proc real %V $x $a\n";
     return a;
     }
//======================================//



    gr=goo(sin(0.707));

     <<"%V$gr\n";




 chkT(gr > 0.0)



   double dgoo( double x)
   {
     double a= 2* x;
     <<"$_proc double %V $x $a\n";
     return a;
     }

//======================================//



   class Scalc {

     public:

     float a;

     float b;

     void seta (real x)
     {

       a= x;

       <<"$_proc %V $x $a\n";
             <<"calling cmf myprint from $_proc\n"
         this->myprint();
	 
       }
//==========================

     float geta ()
     {

       <<"$_proc getting $a\n";
       <<"calling cmf myprint from $_proc\n"
         this->myprint();
	 
         return a;
       }
 //==========================

     int mul (int x,int y)
     {
       <<"in $_proc $x $y\n";
       int z;
       z = x*y;
       return z;
       }
//==========================

     float mul (double x,double y)
     {
       <<"in DOUBLE $_proc $x $y\n";
       float z;
       z = x*y;
       return z;
       }
//==========================

     real mul (real x,real y)
     {

       <<"in REAL $_proc $x $y\n";

       real z;

       z = x*y;

       return z;

       }
//==========================

     void set (real x, real y)
     {

       a= x;

       b =y;

       }

     void set (float x, float y)
     {

       a= x;

       b =y;

       myprint ()

       }

     void myprint ()
      {
       <<"cmf myprint %V $a $b\n";
       }
//===============================//

     cmf Scalc()
     {

       <<"constructing Scalc \n";

       a = 1;

       b = 1;

       }

  };

fix_bug = 1;

     x = sin(0.8);

<<"%V $x \n"





     gr=goo(3.14);

     <<"%V$gr\n";

    x = 0.8;
     gr=goo(sin(x));

     <<"%V$gr\n";

if (fix_bug) {
    gr=goo(sin(0.8));

     <<"%V$gr\n";
}


     Scalc acalc;

     int c =2;

     int d =4;

     double w = 3.3;

     acalc.seta(sin(0.8));

   //  acalc.seta(sin(x));

     wr = acalc.geta();

     <<" $acalc.a\n";

     <<" $wr\n";

     chkR (wr, sin(0.8)); // TBF

 //  chkR (wr, sin(w));

     acalc.seta(w);

     wr = acalc.geta();

     <<" $acalc.a\n";


     <<" $wr\n";

     chkR (wr, w);

     w= Sin(0.7);

     acalc.seta(w);

     <<" $acalc.a\n";

     wr = acalc.geta();

     <<" $wr\n";

     <<" $acalc.geta() \n";
//<<" $acalc.x\n"  // should give error

     <<"%V $acalc.x  $w\n";

     ans = acalc.mul(c,d);

     chkN(ans,8);

     <<"$ans \n";

     w = 2.2;

     double r = 3.3;

     fans = acalc.mul(w,r);

     <<"$fans \n";

     chkN(fans,7.26);

     <<" $(infoof(acalc))\n";

     float fw = 3.3;

     float fr = 3.3;

     fans = acalc.mul(fw,fr);

     <<"$fans \n";

     chkR(fans,10.89);

     fans = acalc.mul(2.0,5.0);

     <<"$fans \n";

     chkN(fans,10.0);

     real r1 = 2.2;

     real r2 = 3.3;

     r1.pinfo();

     r2.pinfo();

     fans = acalc.mul(r1,r2);

     <<"$fans \n";

     chkR(fans,7.26);

     int ag = 47;

     acalc.set(ag,79.0);

     acalc.set(47.0,79.0);

     acalc.myprint();

     FV = fgen(10,0,1);

     <<"$FV \n";

     ok=examine(FV);

     <<"%V $ok\n";

     ok=examine(acalc);

     <<"%V $ok\n";

     chkOut();
//////////////////////////////////////////////////

     svar S;

     S = "how can we move forward";

     ok=examine(S);

     <<"%V $ok\n";
/*
// so as yet  no overloading via prototyping --- just replaces
     cmf mul (int x,int y)
     {
       <<"in $_proc $x $y\n";
       int z;
       z = x*y;
       return z;
       }
//==========================
     cmf mul (float x,float y)
     {
       <<"in $_proc $x $y\n";
       float z;
       z = x*y;
       return z;
       }
//==========================
*/

//===***===//
