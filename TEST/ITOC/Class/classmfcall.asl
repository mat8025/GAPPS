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

///
///   try Class DLL for cpp compile
///   

///
///  need to sort out procrefargs
///



#include "debug"

   if (_dblevel >0) {

     debugON();

     }

#define ASL 1

   chkIn (_dblevel);

   ok = 1;
   
   int showVec(int vect[], int j, int k)
   {
     // <<"IN $_proc args $j $k  $_pargv[1] \n";
     <<"IN $_proc args $j $k   \n";

      aslpinfo(j)
      aslpinfo(vect)

      m = vect[j];
      n = vect[k];

<<"%V $m $n\n"

     aslpinfo(m);
     return n;
   }


     Veci = vgen(INT_,10,0,1);

aslpinfo(Veci)

  <<"$Veci \n"
  
int ji = 3;
int ki = 5;
int q = -3;

     q=showVec(Veci,ji,ki);

aslpinfo(q);

    ok =chkN(q,5);
  if (!ok) {
    <<"test fail \n"
!a
  }
     q=showVec(Veci,ji+1,ki+1);

aslpinfo(q);

    ok=chkN(q,6);
  if (!ok) {
    <<"test fail \n"
!a
  }
 for (ki= 3; ki < 8; ki++) {

       q=showVec(Veci,ji,ki);
           chkN(q,ki);
 }




     



   float goo(float x)
   {

     <<"$_proc float arg $x \n";

      aslpinfo(x);
      
      a= 2* x;

     aslpinfo(a);


      return a;
     }
//======================================//


   double goo(double x)
   {

     <<"$_proc double arg $x \n";

      aslpinfo(x);
      
      a= 2* x;

     aslpinfo(a);


      return a;
     }
//======================================//

float x = 0.707;

    gr=goo(x);

     <<"%V $gr\n";

   aslpinfo(gr);


 chkT(gr > 0.0)

    gr=goo(sin(0.707));

     <<"%V $gr\n";

   aslpinfo(gr);


 chkT(gr > 0.0)




double y = 1.707;

    gr=goo(y);

     <<"%V $gr\n";

   aslpinfo(gr);


 chkT(gr > 0.0)





    gr=goo(0.707);

     <<"%V $gr\n";

   aslpinfo(gr);









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

     float mul (float x, float y)
     {
       <<"in DOUBLE $_proc $x $y\n";
       float z;
       z = x*y;
       return z;
       }
//==========================

     void swap (float& x, float& y)
     {
        <<"in  $_proc $x $y\n";
        float tmp;
	tmp =x;
	x =y;
	y = tmp;
	   <<"out  $_proc $x $y\n";


     }

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



     x = sin(0.8);

<<"%V $x \n"


     gr=goo(3.14);



     x = 0.8;
     gr=goo(sin(x));

     <<"%V$gr\n";

    gr2=goo(sin(0.8));


     <<"%V$gr gr2\n";


     ok=chkN(gr,gr2);
  if (!ok) {
    <<"test fail \n"
!a
  }



     Scalc acalc;

     int c =2;

     int d =4;

     double w = 3.3;


     acalc.seta(w);


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
    aslpinfo(w);
     acalc.seta(w);

     <<" $acalc.a\n";



     wr = acalc.geta();

     <<" $wr\n";

     <<" $acalc.geta() \n";
//<<" $acalc.x\n"  // should give error

     <<"%V $acalc.x  $w\n";

     ans = acalc.mul(c,d);

     ok=chkN(ans,8);
  if (!ok) {
    <<"test fail \n"
!a
  }
     <<"$ans \n";

     w = 2.2;

     double r = 3.3;

     fans = acalc.mul(w,r);

     <<"$fans \n";

     ok=chkN(fans,7.26);
  if (!ok) {
    <<"test fail \n"
!a
  }
     <<" $(infoof(acalc))\n";

     float fw = 3.3;

     float fr = 2.4;
<<"%V $fw $fr \n";

     fans = acalc.mul(fw,fr);

     <<"$fans \n";

 fans = acalc.swap(fw,fr);

     chkR(fans,7.92);

<<"%V $fw $fr \n";


     fans = acalc.mul(2.0,5.0);

     <<"$fans \n";

     ok=chkN(fans,10.0);
  if (!ok) {
    <<"test fail \n"
!a
  }


     fans = acalc.mul(2,5);

     <<"$fans \n";

     ok=chkN(fans,10.0);
  if (!ok) {
    <<"test fail \n"
!a
  }

     fans = acalc.mul(2.0,5);

     <<"$fans \n";

     ok=chkN(fans,10.0);
  if (!ok) {
    <<"test fail \n"
!a
  }



     double r1 = 2.2;

     double r2 = 3.3;
     double r3;

   for (i=0; i < 4; i++) {
     r3 = r1 * r2;


     r1.aslpinfo();

     r2.aslpinfo();

     fans = acalc.mul(r1,r2);

     <<"[$i] $fans \n";

     chkR(fans,r3);
     r1++;
     r2++;
     
  }







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

  void setName( Str nm)
   {
     <<" In $_proc  $nm\n";
     Name = nm;
   };

  Str getName ()   
   {
       return Name; 
   }

 // void Set(int id, Str nm, int shp, float d, float x, float y)
  void SetIns(int id, Str nm,int shp, float d, float x, float y)
  {
  <<" In Set ! %V $id $shp $d $x $y \n";
    //<<"Set    $shp     $ x $ y \n";
    wid = id;
    Name = nm;
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


float ShowMxy(Instrum wins[],int j, int k)
  {

  <<"$_proc  $j $k\n";
  aslpinfo(j);

  aslpinfo(wins);


  float x = -1;
  float y = -1;
  aslpinfo(x);
  
  x = wins[j].mx;
aslpinfo(x);
  y = wins[k].my;

<<"%V $x $y \n";
   <<" $VB_ins[j].mx   $VB_ins[k].my\n";
  return y;
}

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
    
    iname = "Airspeed";
    
    VB_ins[0].SetIns(vario1_wo,iname,1,idia, imx, imy);
    vario1_wo++; imx += 1; imy += 2;
    VB_ins[1].SetIns(vario1_wo,"ins1",1,idia, imx, imy);
    vario1_wo++; imx += 1; imy += 2;
    VB_ins[2].SetIns(vario1_wo,"ins2",1,idia, imx, imy);
    vario1_wo++; imx += 1; imy += 2;
    VB_ins[3].SetIns(vario1_wo,"ins3",1,idia, imx, imy);
    vario1_wo++; imx += 1; imy += 2;
    VB_ins[4].SetIns(vario1_wo,"ins4",1,idia, imx, imy);     
    vario1_wo++; imx += 1; imy += 2;
    VB_ins[5].SetIns(vario1_wo,"ins5",1,idia, imx, imy);     

    VB_ins[0].Print();

    VB_ins[1].Print();

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
      ok=chkN(mr,r2);


        mr= imx * 30;
	// 30.0 is a double needs to match arg
    r2=VB_ins[0].SetMid(imx,30.0);
    
    VB_ins[0].Print();
    <<"%V $mr $r2\n";

ok = chkN(mr,r2);
<<"%V $ok \n"




iname = "Altimeter";
  VB_ins[0].setName(iname);

  VB_ins[0].Print();

  VB_ins[0].setName("Sage");

  VB_ins[0].Print();

   int j1 = 1;
   int k1 = 2;

   <<" $VB_ins[1].mx   $VB_ins[1].my\n";

float gmx;

    gmx = VB_ins[j1].mx;


aslpinfo(gmx);



     gmx = ShowMxy(VB_ins,j1, k1);
<<"%V $gmx\n"
//aslpinfo(gmx);
     ok = chkN(gmx,-1.0,GT_)
<<"%V $ok \n"
  if (!ok) {
    <<"test fail \n"
!a
  }





     j1++;
     k1++;

     gmx= ShowMxy(VB_ins,j1, k1);
<<"%V $gmx\n"


   ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"
  if (!ok) {
    <<"test fail \n"
!a
  }


//aslpinfo(gmx);

    gmx = ShowMxy(VB_ins,j1+1, k1+1);
<<"%V $gmx\n"
//aslpinfo(gmx);

 ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"
  if (!ok) {
    <<"test fail \n"
!a
  }

    gmx = ShowMxy(VB_ins,j1+2, k1+2);
<<"%V $gmx\n"
//aslpinfo(gmx);

 ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"
  if (!ok) {
    <<"test fail \n"
!a
  }



     chkOut();

exit(-1);
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
