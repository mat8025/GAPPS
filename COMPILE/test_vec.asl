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

   dbt("debug in vecWorld\n");

  Siv M(INT_);

  M=14;

  cout << "Siv M " << M << endl;
  
double rms;
double val;
 Vec V(DOUBLE,10,10,1);

  V.pinfo();

cout << "V = " << V << endl;

cout << " trying access " << endl;
  rms = V[7];

cout << "V[7] " << rms << endl;

  V[4] = (rms+15);

 cout << "V[4] " << V[4] << endl;


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
 
//ans= query("??:");


    W[7] = 85;

cout << "W[7] " << W[7] << endl;

 cout << "ans " << ans << endl;
 
//ans= query("??:");


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


int do_list = 1;

if (do_list) {

Svar VLS;
Str ls;
    VLS.split("restart math modules");
cout << "VLS " << VLS << endl;

ans=query("do_list");
   List LS(STRV);

ans=query("info?");

 LS.pinfo();

 LS.setType(STRV);

ans=query("insert ?");

    LS.insert( LIEND,VLS);



ans=query("get LIBEG?");

   Siv sli(STRV);


sli= LS.getLitem(LIBEG);

 cout << " test Siv print " << endl;

cout <<"sli  " << sli <<endl;



   sli.pinfo();

ans=query("sli ?");

ls=LS.getItemAsStr(1);

cout <<" ls  " << ls <<endl;

ans=query("get LIEND?");

sli = LS.getLitem(LIEND);


cout <<"WHATS sli  " <<  endl;

cout <<"whats sli  " << sli <<endl;

   sli.pinfo();

cout <<"hot item is sli " << sli << endl;

cout  << "LS "  << LS << endl;

ans=query("seen sli val ?\n");
// try an INT List

   List LSI(INT);

  LSI.insert( LIEND,1);
  LSI.insert( LIEND,2);
  LSI.insert( LIEND,3);
  LSI.insert( LIBEG,4);

cout  << "LSI "  << LSI << endl;

ans=query("List INT ?\n");

}


int do_sop = 1;
if (do_sop )  {
Siv S(STRV);
cout << " doing sop !!" << endl;
  S= "we will attempt just one feature at a time ";



Str q = "at";
Str t = "im";

cout << " t "  << t.pinfo() << endl;

t.pinfo();

Vec index;

cout << "S " << S << " q " << q << endl;

   index = regex(&S,&q);
   
index.pinfo();

cout << "index " << index <<endl;

index = 0;

cout << "index zero? " << index <<endl;

   index = regex(&S,&t);

cout << "index " << index <<endl;

Svar SV("SV");

 cout  << "SV  "  << SV << endl ;

  SV = "esto se esta complicando";

 cout  << "SV  "  << SV << endl ;

  SV.findWsTokens("esto se esta muy complicando");

cout  << "SV  "  << SV << endl ;

Svar VS;

   VS = "esto se esta muy complicando";

 cout  << "VS  "  << VS << endl ;


  VS.split("esto se esta muy complicando");

 cout  << "VS  "  << VS << endl ;

 cout  << "VS  "  << VS[1] << endl ;

}



/*
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



  Vec T = V;

  cout << "Siv T " << T << endl;

  T.pinfo();

//  Vec R = T;

  //Vec R = T;
  Vec R ;

  R.pinfo();

  T(6) = 66;

  cout << "Siv T " << T << endl;

  R = T;  // x  TBF

  R.pinfo();

  cout << "Siv R " << R << endl;

int do_sop = 1;
if (do_sop )  {
Siv S(STRV);
cout << " doing sop !!" << endl;
  S= "we will attempt just one feature at a time ";



Str q = "at";
Str t = "im";

cout << " t "  << t.pinfo() << endl;

t.pinfo();

Vec index;

cout << "S " << S << " q " << q << endl;

   index = regex(&S,&q);
   
index.pinfo();

cout << "index " << index <<endl;

index = 0;

cout << "index zero? " << index <<endl;

   index = regex(&S,&t);

cout << "index " << index <<endl;

Svar SV("SV");

 cout  << "SV  "  << SV << endl ;

  SV = "esto se esta complicando";

 cout  << "SV  "  << SV << endl ;

  SV.findWsTokens("esto se esta muy complicando");

cout  << "SV  "  << SV << endl ;

Siv VS(SVAR);

   VS = "esto se esta muy complicando";

 cout  << "VS  "  << VS << endl ;


  //   VS.split("esto se esta muy complicando");

 //cout  << "VS  "  << VS << endl ;

}
int do_record = 1;


if (do_record )  {


Svar SV;

   SV.findCommaTokens("80,1,2,3,40,5,6,7,8,9");

  //SV.pinfo();

 cout  << "SV  "  << SV  << endl ;

Record R(10);

  R(0) = SV;

 cout  << "done row assign  "  << endl ;

 cout  << "R(0)  "  << R(0)  << endl ;

 SV.findCommaTokens("82,11,2,3,40,5,6,7,8,99");

  R(1) = SV;


 cout  << "R(1)  "  << R(1)  << endl ;


SV.findCommaTokens("9,8,7,6,5,4,3,2,1,0");

cout << "SV  " << SV << endl;

  R(3) = SV;

 cout  << "R()  "  << R(-1)  << endl ;

Svar SV2;
Svar *sp = &SV2;

  SV2 = R(1);

 cout << "SV2  " << SV2 << endl;
 

 cout  << "done record test  "  << endl ;
}

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






