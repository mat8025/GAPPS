/* 
 *  @script test_vec.asl  
 * 
 *  @comment test cpp compile include and sfunc 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.73 C-Li-Ta]                                
 *  @date 01/16/2022 10:43:41 
 *  @cdate 01/16/2022 10:43:41 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//

///
///  cinclude  ---  chain of include asl - cpp compile OK?
///

/// cpp debug ??
#include <iostream>
#include <ostream>

#define ASL 0
#define CPP 1
void
Uac::vecWorld(Svarg * sarg)  
{
   dbt("debug 1\n");
   Str ans= "xyz";
   cout << "hello simple Vec test  " << ans << endl;
   setDebug(2,"pline");
   dbt("debug in vecWorld\n");

  Siv M(INT_);

  M=14;

  cout << "Siv M " << M << endl;
  
double rms;
double val;

// need Vec<DOUBLE> V (10,10,1)   // so that compiler knows type of vector
         // at moment it is hidden and need to access via V(4) instead of V[4]

 //Vec V(DOUBLE,10,10,1);

 Vec<double> V(10,10,1.50);

  V.pinfo();

cout << "V = " << V << endl;



cout << " trying access " << endl;
COUT(V[7]);

 int index = 6;
// rms = V.getVal(index);

  rms = V[index];
cout << " rms =V[6] " << rms << endl;

//COUT(V(index));

// will only work for Vec type double
 V[4] = 37;

 cout << "V[4]= 37 " << V[4] << endl;

COUT(V[4]);
 short jj = 9;
 V[jj] = 98;

 cout << "V(9)= 98 " << V[9] << endl;

COUT(V[9]);


 V[4] = 15;

 cout << "V[4]= 15 " << V[4] << endl;

COUT(V[4]);

//ans= query("??V[4]");


 Vec<float> F(10,0,0.5);

 Vec<float> G(10,7,0.5);

 Vec<float> H(5,0,0.5);
  


 COUT(F);

 F[3]=16.78;

 COUT(F);

 COUT(G);

ans= query("?? G = 45.67 "); 

  G= 45.57;

COUT(G);

ans= query("?? G = F "); 

  G = F ;
  
COUT(G);

ans= query("?? G += 23.45;");

  G += 23.45;

COUT(G);


ans= query("?? G *= 11.5;");

  G *= 11.5;

COUT(G);

ans= query("?? G = F * 5.01;"); 

  G = F * 5.01;
  
COUT(G);

ans= query("?? G = F(1,5,1);");


  G = F(1,7,1);

COUT(G);

COUT(H);
ans= query("?? H = F(1,7,1);");

  H = F(1,7,1);

COUT(H);


ans= query("?? F(1)= ");

  F[1] = 42;

COUT(F);

ans= query("?? F(1,6,1) = 48.0");

  F(1,6,1) = 48.0;


 COUT(F);

ans= query("?? F(2,7,1) = 56.3;");

  F(2,7,1) = 56.3;
  
COUT(F);

ans= query("?? rms = 35;");

 rms = F(1,7,1).rms();

COUT(rms);

 float f = F[6];
long rng = 2;
COUT(f);

ans= query("?? F(rng)");
      F[rng] = 35;

COUT(F);
ans= query("?? f=F(4) = 35;");
f= F[4];

COUT(f);

   F[rng] = 35;
   
COUT(F);

 //Vec<Str> S(10);


/*

 Vec U(DOUBLE,10,-1,-2);

  U.pinfo();

cout << "U = " << U << endl;

 Vec W(DOUBLE_,10,20,1);

 W.pinfo();

//ans= query("W = V");

  W = V ;

  W.pinfo();

 cout << " W = V " << W << endl;



V.pinfo();

U.pinfo();

//ans= query("V + U");

 W = V + U;

 cout << " W = V+U " << W << endl;

//ans= query("V + U");

 //W[2] = 2222;
    dbt("debug val %f\n",val); // appears in debug file
 val = 2.2;
 
 W *= val;
 
 cout << " W *= val " << val <<" " << W << endl;

//ans= query("W *= val;");

  W += val;
 cout << " W += val " << val <<" " << W << endl;
 
cout << "U = " << U << endl;

  U *= val;

 cout << " U *= val " << val <<" " << U << endl;
//ans= query(" U *= val");


//Vec T(DOUBLE,10,-1,-2.5);

 //cout << "T = " << T << endl;

//ans= query("T = W + U;");

Vec T =  U + W +V ; // not filled correctly TBF

cout << " T = U +W+V " << T << endl;


rms = V().rms();

  cout << "V().rms() " << rms << endl;

  V(4) = 82;

  cout << "V(4) " << V(4) << endl;

//Str prompt = "?:";

 cout << "ans " << ans << endl;

//ans= query("??:");

    V[5] = 54.67;

cout << "V[5] " << V[5] << endl;

 cout << "ans " << ans << endl;
 
ans= query("??:");


    W[7] = 85;

cout << "W[7] " << W[7] << endl;

 cout << "ans " << ans << endl;
 
ans= query("??:");


    val = W[7];

 cout << "val " << val << endl;

  int N = 200;
 double pi = 4.0 * atan(1.0); 

cout << "pi " << pi << endl;

 Vec Xvec(DOUBLE_,N,0.0, (6.0*pi/(1.0*N)));

cout << " Xvec " << Xvec << endl;

    Vec Svec(DOUBLE_,N);


  Svec = Xvec;
  Svec.Sin();

cout << " Svec " << Svec << endl;


rms = V().rms();

  cout << "V().rms() " << rms << endl;


rms = V(0,-1,1).rms();

  cout << "V(0,-1,1).rms() " << rms << endl;

 rms = V(2,7,1).rms();
//rms = V(Rng(2,7,1)).rms();

  cout << "V(2,7,1).rms() " << rms << endl;


 rms = V(2,-3,1).rms();

  cout << "V(2,-3,1).rms() " << rms << endl;


 rms = V(3,-2,2).rms();

  cout << "V(3,-2,1).rms() " << rms << endl;


rms = V(9,2,-1).rms();

  cout << "V(9,2,-1).rms() " << rms << endl;

double d = 77.66;

 V(1,9,2) = d;

cout <<" V range assign\n" << V << endl ;


  cout << "Siv V " << V << endl;

  Vec T2 = V;

  cout << "Siv T2 " << T2 << endl;

  T2.pinfo();

//  Vec R = T;

  //Vec R = T;
  Vec R ;

  R.pinfo();

  T2(6) = 66;

  cout << "Siv T2 " << T2 << endl;

  R = T2;  // x  TBF

  R.pinfo();

  cout << "Siv R " << R << endl;
*/
cout << "Exit cpp testing Vec " << endl;
  dbt("done debug vecworlds\n");
}
  
 
 

//==============================//



 extern "C" int test_vec(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 

    dbt("extern C test_vec\n");
    o_uac->vecWorld(sarg);
        dbt("EXIT extern C test_vec\n");
    //o_uac->newWorld();
     return 1;
  }



//================================//






