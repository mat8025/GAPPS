//%*********************************************** 
//*  @script svar_cpp.asl 
//* 
//*  @comment test class member set/access 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sun Mar  3 12:41:16 2019 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

// Any Globals


int Obid = 0;

#define ASL 0
#define CPP 1

#if CPP
 extern "C" int svar_cpp(Svarg * sarg)  {
#endif


#if CPP
 int n = sarg->getArgI() ;
 int m = sarg->getArgI() ;
  cout << " Simple class demo "  << endl;
 cout << " paras are n " <<  n << " m " << m << endl;
#endif


chkIn(1);

/// simple class test

//<<"simple class test\n"

cout << "hello simple Siv/Str/Svar test  " << endl;

////////////////////////
Siv M(INT_);



M=14;

cout << "Siv M " << M << endl;

Svar W;

   W= "just one feature at a time ";

//   W[1] = "OK?";

Str s;

   s = "try";
   
cout << " str s = "  << s << endl;

   s= W[0];

cout << " str s = "  << s << endl;

Svar T;

    T.findWords("just one feature at a time ",0);


Str t;

    t= T[3];

cout << " str t = "  << t << endl;


    t= T[2];

cout << "[2] str t = "  << t << endl;
Str r;

r = scut(t,3);

cout << "str r = "  << r << endl;

Str q;

Siv S(STRV);

     S = "hey now";

cout << "Siv S " << S << endl;

   q = S.getSivVal();

cout << "str q = "  << q << endl;


Siv R(STRV);

     R = "I got programs that run in my head";

cout << "Siv R " << R << endl;



    S= &R;

cout << "Siv S after  S= &R " << S << endl;



   S= strcat(t,s);

cout << "Siv S " << S << endl;

   q = S.getSivVal();

cout << "str q = "  << q << endl;






   q = M.getSivVal();

cout << "str q = "  << q << endl;

   q = S.getSivVal();

cout << "str q = "  << q << endl;


  q  = "40,02.37,N";

cout << "str q = "  << q << endl;

Str Lat = q;

cout << "str Lat = "  << Lat << endl;


Siv Ladeg(DOUBLE_);


 Ladeg = 40.05;


cout << "Siv Ladeg " << Ladeg << endl;

//
//  Ladeg =  coorToDeg(Lat,2);
//  preprocess to
//  Ladeg = cpp2asl (3,"coorToDeg", Lat, 2);
//  Ladeg = cpp2asl (3,"coorToDeg", "S,I,", Lat, 2);
//  which will construct args inst Svarg form
//  and call asl function
//  return Siv*
//
//



    Ladeg = cpp2asl (3,"coorToDeg", M, Lat);
   // cpp2asl (3,"coorToDeg", M, Lat);

cout << "Siv Ladeg " << Ladeg << endl;



chkN(1,1);
chkOut();



}






/*

  W.split("one day at a time", sindex) // split WS 


*/
