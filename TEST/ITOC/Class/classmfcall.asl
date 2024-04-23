/* 
 *  @script classmfcall.asl                                             
 * 
 *  @comment show mf call                                               
 *  @release Boron                                                      
 *  @vers 1.4 Be Beryllium [asl 5.79 : B Au]                            
 *  @date 01/29/2024 15:24:43                                           
 *  @cdate Tue Mar 31 20:10:28 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


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

#define _ASL_ 1

   chkIn (_dblevel);

   allowErrors(-1)
   echolines(0)
   ok = 1;
   
   int showVec(int vect[], int j, int k)
   {
     // <<"IN $_proc args $j $k  $_pargv[1] \n";
     <<"IN $_proc args $j $k   \n";

      k.pinfo()
      vect.pinfo()

      m = vect[j];
      n = vect[k];

<<"%V $m $n\n"

     m.pinfo();
     return n;
   }

///////////////////////////////////////////////////////////////////
ans ="y"
//DBaction((DBSTEP_),ON_)
// allowDB("ic_,oo_,spe_proc,spe_state,spe_cmf,rdp")

db_ask = 0;


     Veci = vgen(INT_,10,0,1);

     pinfo(Veci)

  <<"$Veci \n"
  
int ji = 3;
int ki = 5;
int q = -3;

     q=showVec(Veci,ji,ki);

     pinfo(q);

    ok =chkN(q,5);
  if (!ok) {
    <<"test fail \n"

  }
     q=showVec(Veci,ji+1,ki+1);

pinfo(q);

    ok=chkN(q,6);
  if (!ok) {
    <<"test fail \n"

  }
 for (ki= 3; ki < 8; ki++) {

       q=showVec(Veci,ji,ki);
           chkN(q,ki);
 }


   float goo(float x)
   {

     <<"$_proc float arg $x \n";

      pinfo(x);
      
      a= 2* x;

     pinfo(a);


      return a;
     }
//======================================//


   double goo(double x)
   {

     <<"$_proc double arg $x \n";

      pinfo(x);
      
      a= 2* x;

     pinfo(a);


      return a;
     }
//======================================//

float x = 0.707;

    gr=goo(x);

     <<"%V $gr\n";

   pinfo(gr);


 chkT(gr > 0.0)

    gr=goo(sin(0.707));

     <<"%V $gr\n";

   pinfo(gr);


 chkT(gr > 0.0)




double y = 1.707;

    gr=goo(y);

     <<"%V $gr\n";

   pinfo(gr);


 chkT(gr > 0.0)





    gr=goo(0.707);

     <<"%V $gr\n";

    gr.pinfo();



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
       //xd.pinfo()
       x.pinfo()
       a= x;

       <<"$_proc  double arg %V   $x $a\n";
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

     void Scalc()
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

  }



     Scalc acalc;

     int c =2;

     int d =4;

     double w = 3.3;
     
<<"%V $ans\n"
ans = ask("1 step  debug? [yes,no]",db_ask);
ans.pinfo()
<<"%V $ans\n"
if (ans == "yes") {
 wdb=DBaction((DBSTEP_),ON_)
<<"%V$wdb\n"
allowDB("ic_,oo_,spe_")
}


w.pinfo()

     acalc.seta(w);

     wr = acalc.geta();

     chkR (wr, w); 

    y = sin(0.8)

     acalc.seta(sin(0.8));

   //  acalc.seta(sin(x));

     wr = acalc.geta();

     <<" $acalc.a\n";

     <<" $wr $y\n";

     chkR (wr, y); // TBF




 //  chkR (wr, sin(w));

     acalc.seta(w);

     wr = acalc.geta();

     <<" $acalc.a\n";


     <<" $wr\n";

     chkR (wr, w);

     w= Sin(0.7);
     w.pinfo()
     acalc.seta(w);

     <<" $acalc.a\n";



     wr = acalc.geta();

     <<" $wr\n";

    // <<" $acalc.geta() \n";
//<<" $acalc.x\n"  // should give error

    // <<"%V $acalc.x  $w\n";

ans=ask("2 acalc.mul  [y,n]",db_ask);
 if (ans == "y") {
   DBaction((DBSTEP_|DBSTRACE_),ON_)
 }
z = acalc.mul(c,d);

     ok=chkN(z,8);

<<"$z \n";

     w = 2.2;

     double r = 3.3;

     fans = acalc.mul(w,r);

     <<"$fans \n";

     ok=chkN(fans,7.26);

     <<" $(infoof(acalc))\n";

     float fw = 3.3;

     float fr = 2.4;
<<"%V $fw $fr \n";

     fans = acalc.mul(fw,fr);

     <<"$fans \n";

     chkR(fans,7.92);


<<"%V $fw $fr \n";





     acalc.swap(fw,fr);

<<"%V $fw $fr \n";

     chkN(fw,2.4)
     
//ans=ask(" $fw == 2.4 ? [y,n]",1);

     fans = acalc.mul(2.0,5.0);

     <<"$fans \n";

     ok=chkN(fans,10.0);



     fans = acalc.mul(2,5);

     <<"$fans \n";

     ok=chkN(fans,10.0);


     fans = acalc.mul(2.0,5);

     <<"$fans \n";

     ok=chkN(fans,10.0);


     double r1 = 2.2;

     double r2 = 3.3;
     double r3;

ans=ask("3step  debug? [y,n]",db_ask);
if (ans == "y") {
  
  allowDB("ic_,oo_,spe_proc,spe_state,spe_cmf")
DBaction((DBSTEP_|DBSTRACE_),ON_)
}

   for (i=0; i < 4; i++) {
     r3 = r1 * r2;


     r1.pinfo();

     r2.pinfo();

     fans = acalc.mul(r1,r2);

     <<"[$i] $fans $r3\n";

     chkR(fans,r3,3);
     r1++;
     r2++;
     
  }







     int ag = 47;

     acalc.set(ag,79.0);

     acalc.set(47.0,79.0);

     acalc.print();

     FV = fgen(10,0,1);

     <<"$FV \n";

     pinfo(FV);


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


 void Instrum()   //  use cons,destroy   -- have then set to NULL in CPP he
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

  
  int Print() {

    <<"%V $wid $Name $shape $dia $mx $my \n";
     return 1;
   }
 
};   

int Showmxy_cnt = 0;

float ShowMxy(Instrum wins[],int j, int k)
{

Showmxy_cnt++;
  <<"$_proc  $j $k $Showmxy_cnt\n";
  j.pinfo()

  wins.pinfo();


  float x = -1;
  float y = -1;
  x.pinfo();
  
  x = wins[j].mx;
   <<"%V $x  \n";
  y = wins[k].my;

   <<"%V $x  \n";
   
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

//ans=ask("4 VB_ins", db_ask);
//DBaction((DBSTEP_|DBSTRACE_),ON_)

     VB_ins[1].Print();
//ans=ask(DB_prompt,db_ask);

    
    VB_ins[2].Print();
//ans=ask(DB_prompt,db_ask);


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


     gmx.pinfo();


ans=ask("ShowMxy  debug? [y,n]",0);
if (ans == "y") {
  wdb=  DBaction((DBSTEP_),ON_)
  <<"$wdb \n"  
allowDB("ic_,oo_,spe_proc,spe,array")
//DBaction((DBSTEP_|DBSTRACE_),ON_)
}

     gmx = ShowMxy(VB_ins,j1, k1);
<<"%V $gmx\n"

     ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"

     j1++;
     k1++;
     



     gmx= ShowMxy(VB_ins,j1, k1);
     
<<"%V $gmx\n"


   ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"



    gmx = ShowMxy(VB_ins,j1+1, k1+1);

    gmx.pinfo();

<<"%V $gmx\n"


 ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"


    gmx = ShowMxy(VB_ins,j1+2, k1+2);
<<"%V $gmx\n"
//pinfo(gmx);

 ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"


     chkOut(1);


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
