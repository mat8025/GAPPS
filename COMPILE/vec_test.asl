/* 
 *  @script vec_test.asl  
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
///  include  ---  chain of include asl - cpp compile OK?
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
#define cout //
#define COUT //
 run_vec asl = runASL();
printf("run_asl %d\n",run_vec_asl);

printf("ASL %d CPP %d\n", ASL,CPP);
#define CDB ans=query("go on");
//#define CDBP (x) ans=query(x,"go on"); // asl not working
#define CDBP //
#endif




#if CPP
#warning USING_CPP
#define CDBP(x) ans=query(x,"go on",__LINE__,__FILE__);
#define CDB ans=query("?","go on",__LINE__,__FILE__);


#define  CHKNE(x,y)  chkN(x,y,EQU_, __LINE__);

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
   RUN_ASL = 0;
#endif


  Siv M(INT_);

  M=14;

//  pra(M);

// ans=query("?",lastStatement(),__LINE__);

 //pra(M);

//cout << "Siv M " << M << endl;
  
double rms;
double val;

//  pra(lastStatement(3),__LINE__);

 Vec<double> D(20);

//pra(D,"@ ",__LINE__);

D.pinfo();

//ans=query("?",lastStatement(),__LINE__);

// need Vec<DOUBLE> V (10,10,1)   // so that compiler knows type of vector
         // at moment it is hidden and need to access via V(4) instead of V[4]

 //Vec V(DOUBLE,10,10,1);

  Vec<double> V(10,10,1.50);

  V.pinfo(); // info about variable

//pra("?",lastStatement(),__LINE__);

#if CPP
cout << "V = " << V << endl;
cout << " trying access " << endl;
#endif

int index = 6;

 printf("? is this in the DLL\n");
  // pra(index,__LINE__);

  pra(V[7]);

CHKNE(V[0],10.0)



#if ASL

<<"%V $index $V[7] \n";

#endif


 Siv SV(INT_,1,10,-3,1);
 
 SV.pinfo();

  index = SV[2];

/*  
  SV[3] = 67;
 pra(index);
 pra(SV);
*/

pra("?","SV $index",__LINE__);
  
// rms = V.getVal(index);

  rms = V[index]; // [] access


//pra( " rms =V[6] ",rms);

//pra(V(index));

// will only work for Vec type double
 V[4] = 37; // [] LH access

//cout << "V[4]= 37 " << V[4] << endl;

//pra(V[4],__LINE__);

 short jj = 9;


 printf("[j] LH access \n");

 V[jj] = 98; 

#if ASL
<<"%V $jj $V[jj] \n";
pra(jj, V[jj]);
#else
 cout << "V(9)= 98 " << V[9] << endl;

pra(V[9]);
#endif

printf(" V[4] = 15 \n");
 V[4] = 15;

printf("V[4]= 15  %f \n",V[4]);

//pra(V[4]);

 //chkN(V[4],15);

// ans= query("??V[4]");

  printf("vec  type sequence\n");

 Vec<float> F(10,6,0.5); // vec  type sequence

 //pra(F);

 Vec<float>  G(10,0,0.5);

cout << " print V " << V << endl;

cout << " print g " << G << endl;
// CDBP(" G?");
//pra("G ?", G); // won't work for templated Vec - use print char* ?

 CHKNE(G[1],0.5)


 rms = F.rms();  // ASL parse?
 CDB;

 // pra(rms );

// pra(F);
  cout << " print F " << F << endl;



 
  cout << " print g 0,0.5,1.0 ... " << G << endl;

  CDBP(" G= F.rng(1,6,2)")

  G = F.rng(1,6,2);
  
  cout << " print g 6.5 7.5 8.5 ... " << G << endl;


  CDBP("G ?");
  CHKNE(G[0],6.5)
  CHKNE(G[1],7.5)


 // CDBP(" G?");
 
  COUT(F);
  COUT(G);

 // CDBP("G ?");

// pra(G);

  CHKNE(G[0],6.5)
  CHKNE(G[1],7.5)

  cout <<"G:  " << G << endl;
  
  G = F.rng(0,-1,2);
  
  cout <<"F: " << F << endl;
  cout <<"G: 6 7 8 ... " << G << endl;

//pra(G ); // working?


    CHKNE(G[0],6.0)
    
    CHKNE(G[1],7.0)
    
    CHKNE(G[2],8.0)
printf("test G[] %f %f %f\n",G[0],G[1],G[2]);
printf("test F[] %f %f %f\n",F[0],F[1],F[2]);
 //CDBP(" G?");

 //pra(G);

   G = F;

 //pra(G);
  

 ///G[0:-1:1] = F.rng(1,-1,2);  // this is ASL syntax
 // can't do an exact cpp operator version
//  can do G(0,-1,2) for cpp
//  but then require revise for asl - or translate/prep program
//  can use vmf,cpp functions
//   srng  - set the range of vec to RHS
//   rng  -  get the range values of vec

 G.srng(0,-1,2) = F.rng(1,-1,2);
  cout <<"F: " << F << endl;
  cout <<"G:  " << G << endl;

 printf("test F[] %f %f %f\n",F[0],F[1],F[2]);
 printf("test G[] %f %f %f\n",G[0],G[1],G[2]);  

 CHKNE(G[0],F[1]);
// CDBP(" G?");

// for Matrix
// instead of M[0:3:1][0:-1:1]
// need M(rng(0,3,1), rng(0,1,1))

//  3,4,5 D
// has to be vargs 

 cout << "fill subset range 0,-1,2) " << G << endl;


 Vec<float> Z(10,20,2.5);

 Vec<float> H(5,0,0.5);

 Vec<float> X(20,0,0.5);

 Vec<float> Y(20,0,-0.5);


  Vec<float> R(20);

   Vec<int>  I(10);
   
   Vec<long> L(20);

   Vec<short> S(20);
  
  X[3] = 3.7;
  X[5] = 2.1;


 //pra(F);

 F[3]=16.78;

 F[7]= 26.25;
 
 //ans= query("?? G=  F;","?",__LINE__);

 cout <<"F:  " << F << endl;  
   G = F;
 cout <<"G:  " << G << endl;
 CDBP("G=F")
 CHKNE(G[3],16.78);

 //pra(G);

 //pra(I);

//  ans= query("?? G=  F + I;",ans,__LINE__);
  
  G = F + I;
 cout <<"I:  " << I << endl;
 cout <<"G: F + I " << G << endl;
  CHKNE(G[1], (F[1] + I[1]));
  
 //pra(G);

// ans= query("OK? G=  F + I;",ans,__LINE__);

 //pra(Z);

  //ans= query("?? G=  F + Z;",ans,__LINE__);
  
  G = F +Z;


 //pra(G);

  //ans= query("OK?");
  

  G = F + 5.01;

//  ans= query("OK G=  F + 5.01;",ans,__LINE__);


//pra(F);

// pra(F);

 //pra(G);

//ans= query("?? G = 45.67 "); 

//cout<<" // vec set to value \n";

  G= 45.57; 

//pra(G);

//ans= query("?? G = F ");

//cout<<"G = F vec copy \n"; 

  G = F ;  // vec copy
   cout <<"G: = F " << G << endl;
//pra(G);

//ans= query("?? G += 23.45;");
//cout<<"SOP G += 23.45;";

G += 23.45; // self += op
  cout <<"G: += 23.45 " << G << endl;
//pra(G);
  I[5] = 66;

  // pra(I , "\n");

  //pra(I);
  

  L = I;

  // pra(L);

   L += 2;

  // pra(L);

//ans=query("?","L = I",__LINE__);

#if ASL
<<"%V $L\n";
#else
  COUT(I);
  COUT(L);
#endif

    I = L;

  //pra(I);

//ans=query("?","I $I = L $L",__LINE__);


   S = I;

  //pra(S);

//ans=query("?","S $S = I $I",__LINE__);

  S += 3;

  I = S;

//  pra(I);

//ans=query("?","I  = S",__LINE__);

 //pra(D);

   D = F;

 //pra(D);

//ans=query("?","D = F",__LINE__);


//  pra(D);

  D += 5.4;

 // pra(D);

// ans=query("?","D += 5.4",__LINE__);



//cout<<"SOP G *= 11.5;";


  G *= 11.5;

// pra(G);

 //ans= query("?? G *= 11.5;",__LINE__);
 

  G = F ;

// pra(G);

 //ans= query("??  F * 5.01;",ans,__LINE__);
 
  G = F * 5.01;

// pra(G);

//ans= query("OK G = F * 5.01;",ans,__LINE__);

//cout<<"range set G = F(1,5,1);\n";

 //pra(F);

 F[1] = 92;

#if ASL
  G = F[1:7:1];  // ASL parse?
<<"%V $G\n";
#endif
   F[2] = 111.7;
   F[4] = -77.0;
 //pra("rms = F.rms; ",ans,__LINE__);
   F.srng(0,-1,1);
  rms = F.rms();  // ASL parse?
  
<<" F.srng(0,-1,1)  $rms \n"

F.srng(1,-1,2);
  rms = F.rms();  // ASL parse?
<<" F.srng(1,-1,2)  $rms \n"
!a  
 //pra("??  G = F.vrng(1,7,1); ",__LINE__);


G = F.rng();  // ASL parse?


//pra(G);

G = F.rng(1,7,1);  // ASL parse?
!a
//pra("print out G?\n", G); // can't get this to work - template version?

//pra(G);

 cout << "F: " <<  F<< endl; 
 cout << "G: " << G << endl; 

//vecans= query("OK op range?",ans,__LINE__);

 //cout <<"G[0] " << G[0] << endl;
 
 //cout <<"F[1] " << F[1] << endl;

  CHKNE(G[0],F[1]);

//ans= query("?? G[0] = F[1]");

 //pra(H);

//cout<<"?? H = F(1,7,1);\n";

  H = F.rng(1,7,1);

 //pra(H);

  H.srng(1,3,1) = F.rng(3,1,-1);


 //pra(F);
 //pra(H);

//ans= query("?? H.srng(1,3,1) = F.rng(3,1,-1);",__LINE__);

//cout<<" F[1] = 42; ele set \n";

 F[1] = 42;

  CHKNE(F[1],42.0);
  
 //pra(F);

//ans= query("?? F(1,6,1) = 48.0");
//cout<<"vec range set F(1,6,1) = 48.0";
  F.srng(1,6,1) = 48.0;

 chkF(F[1],48.0);

 //pra(F);

//cout<<"?? F(2,7,1) = 56.3;";

  F.srng(2,5,1) = 56.3;

chkF(F[3],56.3);

  F[6] = -13.4;
  //pra(F);

//cout<<"?? rms = 35;";

// rms = F(1,7,1).rms();
  F.srng(0,-1,2);
  
  rms = F.rms();
pra(rms);

  //rms = Rms(F(1,7,1));

  F.srng(2,5,1);
pra(rms);

 rms = F.rms();
//pra(rms);

 CDB

float f = F[6];
long rindex = 2;

//pra(f);

//cout<<"?? F(rng)";
      F[rindex] = 35;

 //pra(F);

//cout<<"?? f=F[4] = 35;";

 f= F[4];

 //pra(f);

 F[rindex] = 35;
   
 //pra(F);

 //pra(X);

 //pra(Y);

 R= Lfit(X,Y,-1);

  //pra(R);
 //Vec<Str> S(10);


 Vec<double> U(10,-1,-2);

  U.pinfo();

  //pra(U);




/*

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

 extern "C" int vec_test(Svarg * sarg)  {

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






