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

#define ASL 0
#define CPP 1
void
Uac::vecWorld(Svarg * sarg)  
{

   cout << "hello simple Vec test  " << endl;

  Siv M(INT_);

  M=14;

  cout << "Siv M " << M << endl;
double rms;

 Vec V(DOUBLE,10,10,1);

  V.pinfo();

rms = V().rms();

  cout << "V().rms() " << rms << endl;

  V(4) = 82;

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


  cout << "Exit cpp HelloVec " << endl;

}
  
 
 

//==============================//



 extern "C" int test_vec(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 


    o_uac->vecWorld(sarg);
    //o_uac->newWorld();

  }



//================================//






