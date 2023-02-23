/* 
 *  @script class_mfcall.asl 
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

#define ASL 1

   chkIn (_dblevel);

   double goo( double x)
   {
     a= 2* x;
     <<"$_proc double %V $x $a\n";
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

     void seta (double x)
     {

       a= x;

       <<"$_proc %V $x $a\n";
           //   myprint ();
       }
//==========================

     float geta ()
     {

       <<"$_proc getting $a\n";
      // print ();
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

     float amul (float x, float y)
     {
       <<"in DOUBLE $_proc $x $y\n";
       float z;
       z = x*y;
       return z;
       }
//==========================

     double mul (double x,double y)
     {

       <<"in DOUBLE $_proc $x $y\n";

       double z;

       z = x*y;

       return z;

       }
//==========================

     void set (double x, double y)
     {

       a= x;

       b =y;

       }

     void set (float x, float y)
     {

       a= x;

       b =y;

       print ()

       }

     void print ()
      {
       <<"cmf print %V $a $b\n";
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
!a
     chkR(fans,10.89);

     fans = acalc.mul(2.0,5.0);

     <<"$fans \n";

     chkN(fans,10.0);

     double r1 = 2.2;

     double r2 = 3.3;

     r1.aslpinfo();

     r2.aslpinfo();

     fans = acalc.mul(r1,r2);

     <<"$fans \n";

     chkR(fans,7.26);

     int ag = 47;

     acalc.set(ag,79.0);

     acalc.set(47.0,79.0);

     acalc.print();

     FV = fgen(10,0,1);

     <<"$FV \n";

     ok=examine(FV);

     <<"%V $ok\n";

     ok=examine(acalc);

     <<"%V $ok\n";


class Instrum 
 {

 public:
  
  
  float mx;
  float my;
  float dia;
  float ht;
  float wd;
  int type;
  float px,py,pX,pY;
  
  int shape;
  Str Name;
  int wid;

#if ASL
 void Instrum()   //  use cons,destroy   -- have then set to NULL in CPP header
#else
  Instrum()
#endif
 {
  shape = 1;  // 1 circle, 2 rectangle
  dia = 3.0;

  wd =1.0;
  ht = 1.0;
  Name = "XI";
  wid = -1;

  mx=0.0;
  my=0.0;
}

  Str getName ()   
   {
       return Name; 
   }

 // void Set(int id, Str nm, int shp, float d, float x, float y)
  void SetIns(int id, int shp, float d, float x, float y)
  {
  <<" In Set ! %V $id $shp $d $x $y \n";
    //<<"Set    $shp     $ x $ y \n";
    wid = id;
  //  Name = nm;
    shape = shp;
    dia = d;
    mx = x;
    my = y;
<<"%V $wid $Name $shape $dia $mx $my \n";
  };

  void SetShape(int shp)
  {
  <<" In $_proc ! %V $shp\n";
     shape = shp;
  };

  void SetDia(float d)
  {
  <<" In $_proc ! %V $d\n";
     dia = d;
  };

/*
  double SetMid(double x, double y)
  {
  <<" In $_proc ! %V $x $y\n";
     mx = x;
     my = y;
     return (mx * my);
  };
*/

  float SetMid(float x, float y)
  {
  <<" In $_proc ! %V $x $y\n";
     mx = x;
     my = y;
     return (mx * my);
  };
/*
  float SetMid(double x, double y)
  {
  <<" In $_proc ! %V $x $y\n";
     mx = x;
     my = y;
     return (mx * my);
  };
*/

  
  void Print()
  {

    <<"%V $wid $Name $shape $dia $mx $my \n";
  }
 
};   




float sx;
Str iname = "X?";
float idia = 4.0;
float imx = -15.1;
float imy = 27.1;

Svar Wval;


Wval.split("XYZ,1,2,$imx,$imy",44);

<<"$Wval \n";

<<"$Wval[0] \n";
<<"$Wval[2] \n";

Svar Wval2;

Wval2.split("ABC 1.3 2.4 $imx $imy");


<<"$Wval2[0] \n";
<<"$Wval2[2] \n";
<<"$Wval2[3] \n";

<<"$Wval2 \n"

  Instrum  VB_ins[16];

int vario1_wo = 42;

float mr;
float dr;

    VB_ins[0].Name = "SN_Vario";
    //VB_ins[0].shape = 1;
    //VB_ins[0].mx = -15;
    //VB_ins[0].my = 27;
    
    iname = "SN_Vario";
    
    VB_ins[0].SetIns(vario1_wo,1,idia, imx, imy); 

    VB_ins[0].Print();

    VB_ins[0].SetShape(3);
    VB_ins[0].Print();

    idia = 4.5;
    VB_ins[0].SetDia(idia);
    VB_ins[0].Print();

    imx =17;
    imy = 42;
    dr = 42;
    mr= imx *imy;
    
    r2=VB_ins[0].SetMid(imx, dr);
    
    VB_ins[0].Print();
    <<"%V $mr $r2\n";
      chkN(mr,r2);
    

        mr= imx * 30;
	// 30.0 is a double needs to match arg
    r2=VB_ins[0].SetMid(imx,30.0);
    
    VB_ins[0].Print();
    <<"%V $mr $r2\n";
          chkN(mr,r2);
!a    






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
