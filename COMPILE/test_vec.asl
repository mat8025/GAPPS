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
int run_vec_asl = 0;
Str vecans="xxx";
#define ASL 1
#define CPP 0

//printf("ASL %d CPP %d\n", ASL,CPP); // not CPP outside of main


#if ASL
// the include  when cpp compiling will re-define ASL 0 and CPP 1
#include "compile.asl"
#define AST vecans=query("?","ASL DB goon",__LINE__,__FILE__);
//  printf("ASL %d CPP %d\n",ASL,CPP);
#endif






#if ASL
<<"ASL   $(ASL) CPP $(CPP)\n"
printf("ASL %d CPP %d\n", ASL,CPP);
#define COUT //
 run_vec asl = runASL();
printf("run_asl %d\n",run_vec_asl);

printf("ASL %d CPP %d\n", ASL,CPP);

#endif




#if CPP
#warning USING_CPP

#define CDB ans=query("?","goon",__LINE__,__FILE__);
#define CDBP(x) ans=query(x,"goon",__LINE__,__FILE__);

#include <iostream>
#include <ostream>

#include "vec.h"
#include "uac.h"

#include "gline.h"
#include "glargs.h"
#include "winargs.h"
#include "woargs.h"
#include "vargs.h"
#include "gevent.h"

void
Uac::vecWorld(Svarg * sarg)  
{
   dbt("debug \n");
   Str ans= "xyz";
   cout << "Hello simple Vec test  " << ans << endl;
   //setDebug(2,"pline");
   dbt("debug in vecWorld\n");

#endif



  Siv M(INT_);

  M=14;

  COUT(M);

 //pa(M);

//cout << "Siv M " << M << endl;
  
double rms;
double val;

   Vec<double> D(20);

   D.pinfo();
ans=query("?","Vec D(20) ",__LINE__);

// need Vec<DOUBLE> V (10,10,1)   // so that compiler knows type of vector
         // at moment it is hidden and need to access via V(4) instead of V[4]

 //Vec V(DOUBLE,10,10,1);

  Vec<double> V(10,10,1.50);

  V.pinfo(); // info about variable
  ans=query("?","Vec V(10,10,1.50); ",__LINE__);
#if CPP
cout << "V = " << V << endl;
cout << " trying access " << endl;
#endif

int index = 6;

   COUT(index)

   COUT(V[7]);

#if ASL

<<"%V $index $V[7] \n";

#endif





 Siv SV(INT_,1,10,-3,1);
 
 SV.pinfo();

  index = SV[2];

/*  
  SV[3] = 67;
 COUT(index);
 COUT(SV);
*/

ans=query("?","SV $index",__LINE__);
  
// rms = V.getVal(index);

  rms = V[index]; // [] access


//pa( " rms =V[6] ",rms);

//COUT(V(index));

// will only work for Vec type double
 V[4] = 37; // [] LH access

//cout << "V[4]= 37 " << V[4] << endl;

COUT(V[4]);

 short jj = 9;


 printf("[j] LH access \n");

 V[jj] = 98; 

#if ASL
<<"%V $jj $V[jj] \n";
pa(jj, V[jj]);
#else
 cout << "V(9)= 98 " << V[9] << endl;

COUT(V[9]);
#endif

 V[4] = 15;

printf("V[4]= 15  %f \n",V[4]);

COUT(V[4]);

//ans= query("??V[4]");

//cout <<"vec  type sequence\n";

 Vec<float> F(10,0,0.5); // vec  type sequence

 Vec<float> G(10,7,0.5);

 Vec<float> Z(10,20,2.5);

 Vec<float> H(5,0,0.5);

 Vec<float> X(20,0,0.5);

 Vec<float> Y(20,0,-0.5);


  Vec<float> R(20);

   Vec<int>   I(10,0,1);
   
   Vec<long> L(20);

   Vec<short> S(20);


  
  X[3] =3.7;
  X[5] = 2.1;


 COUT(F);

 F[3]=16.78;

 F[7]= 26.25;
 
 ans= query("?? G=  F;");
  
   G = F;

 COUT(G);

 COUT(I);

  ans= query("?? G=  F + I;");
  
  G = F + I;

 COUT(G);

 ans= query("OK? G=  F + I;");

 COUT(Z);

  ans= query("?? G=  F + Z;");
  
  G = F +Z;


 COUT(G);

  ans= query("OK?");
  

  G = F + 5.01;

  ans= query("OK G=  F + 5.01;");


//pa(F);

 COUT(F);

 COUT(G);

//ans= query("?? G = 45.67 "); 

//cout<<" // vec set to value \n";

  G= 45.57; 

COUT(G);

//ans= query("?? G = F ");

//cout<<"G = F vec copy \n"; 

  G = F ;  // vec copy
  
COUT(G);

//ans= query("?? G += 23.45;");
//cout<<"SOP G += 23.45;";

G += 23.45; // self += op

COUT(G);
  I[5] = 66;

  // pa(I , "\n");

  COUT(I);
  

  L = I;

   COUT(L);

   L += 2;

   COUT(L);

ans=query("?","L = I",__LINE__);

#if ASL
<<"%V $L\n";
#else
  COUT(I);
  COUT(L);
#endif

    I = L;

  COUT(I);

ans=query("?","I $I = L $L",__LINE__);


   S = I;

  COUT(S);

ans=query("?","S $S = I $I",__LINE__);

  S += 3;

  I = S;

  COUT(I);

ans=query("?","I  = S",__LINE__);

COUT(D)

   D = F;

COUT(D)

ans=query("?","D = F",__LINE__);


  COUT(D);

  D += 5.4;

  COUT(D);

  ans=query("?","D += 5.4",__LINE__);



//cout<<"SOP G *= 11.5;";

  G *= 11.5;





 COUT(G);

 ans= query("?? G *= 11.5;");
 

  G = F ;

COUT(G);

 ans= query("??  F * 5.01;");
 
  G = F * 5.01;

 COUT(G);

ans= query("OK G = F * 5.01;"); 

//cout<<"range set G = F(1,5,1);\n";

COUT(F);



#if ASL
  G = F[1:7:1];  // ASL parse?
<<"%V $G\n";
#endif

ans= query("??  G = F.rng(1,7,1); ");

  G = F.rng(1,7,1);  // ASL parse?

 COUT(G);

vecans= query("?? op range?");

 //cout <<"G[0] " << G[0] << endl;
 
 //cout <<"F[1] " << F[1] << endl;

  chkF(G[0],F[1]);

//ans= query("?? G[0] = F[1]");

COUT(H);

//cout<<"?? H = F(1,7,1);\n";

  H = F(1,7,1);

COUT(H);

  H(1,3,1) = F(3,1,-1);

COUT(F);
COUT(H);

ans= query("?? H(1,3,1) = F(3,1,-1);");

//cout<<" F[1] = 42; ele set \n";

F[1] = 42;

  chkN(F[1],42);
  
COUT(F);

//ans= query("?? F(1,6,1) = 48.0");
//cout<<"vec range set F(1,6,1) = 48.0";
  F(1,6,1) = 48.0;

chkF(F[1],48.0);
 COUT(F);

//cout<<"?? F(2,7,1) = 56.3;";

  F(2,7,1) = 56.3;

chkF(F[3],56.3);

COUT(F);

//cout<<"?? rms = 35;";

 rms = F(1,7,1).rms();

COUT(rms);

float f = F[6];
long rng = 2;

COUT(f);

//cout<<"?? F(rng)";
      F[rng] = 35;

COUT(F);

//cout<<"?? f=F[4] = 35;";

f= F[4];

COUT(f);

   F[rng] = 35;
   
COUT(F);

COUT(X);

COUT(Y);

R= Lfit(X,Y,-1);

COUT(R);
 //Vec<Str> S(10);


/*

 Vec U(DOUBLE,10,-1,-2);

  U.pinfo();

cout << "U = " << U << endl;

 Vec W(DOUBLE_,10,20,1);

 W.pinfo();

//cout<<"W = V");

  W = V ;

  W.pinfo();

 cout << " W = V " << W << endl;



V.pinfo();

U.pinfo();

//cout<<"V + U");

 W = V + U;

 cout << " W = V+U " << W << endl;

//cout<<"V + U");

 //W[2] = 2222;
    dbt("debug val %f\n",val); // appears in debug file
 val = 2.2;
 
 W *= val;
 
 cout << " W *= val " << val <<" " << W << endl;

//cout<<"W *= val;");

  W += val;
 cout << " W += val " << val <<" " << W << endl;
 
cout << "U = " << U << endl;

  U *= val;

 cout << " U *= val " << val <<" " << U << endl;
//cout<<" U *= val");


//Vec T(DOUBLE,10,-1,-2.5);

 //cout << "T = " << T << endl;

//cout<<"T = W + U;");

Vec T =  U + W +V ; // not filled correctly TBF

cout << " T = U +W+V " << T << endl;


rms = V().rms();

  cout << "V().rms() " << rms << endl;

  V(4) = 82;

  cout << "V(4) " << V(4) << endl;

//Str prompt = "?:";

 cout << "ans " << ans << endl;

//cout<<"??:");

    V[5] = 54.67;

cout << "V[5] " << V[5] << endl;

 cout << "ans " << ans << endl;
 
cout<<"??:");


    W[7] = 85;

cout << "W[7] " << W[7] << endl;

 cout << "ans " << ans << endl;
 
cout<<"??:");


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
  chkOut();
  dbt("Exit cpp testing Vec \n");

  dbt("done debug vecworlds\n");

#if CPP
}

//==============================//

 extern "C" int test_vec(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to select uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 

    dbt("extern C test_vec\n");
    o_uac->vecWorld(sarg);
        dbt("EXIT extern C test_vec\n");
    //o_uac->newWorld();
     return 1;
  }

#endif

//================================//






