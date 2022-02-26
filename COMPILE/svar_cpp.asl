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


#define ASL 0
#define CPP 1

#if CPP
 extern "C" int svar_cpp(Svarg * sarg)  {
#endif


#if CPP
 int n = sarg->getArgI() ;
 int m = sarg->getArgI() ;

DB_xic_bp = 0;
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
r =t;
r.scut(3);

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


float f = 4.2;
int cnt = 2;
uint ucnt = 34;
short si = 35;
ulong ul = 36;
ushort us = 37;
cout<<"cnt is of type: "<<typeid(cnt).name()<<std::endl;

    char FMT[256];
    FMT[0] = '\0';

    strcat(FMT,typeid(cnt).name());
    strcat(FMT,",");

    strcat(FMT,typeid(ucnt).name());
    strcat(FMT,",");
    strcat(FMT,typeid(si).name());
    strcat(FMT,",");
    strcat(FMT,typeid(ul).name());
    strcat(FMT,",");
    strcat(FMT,typeid(us).name());
    strcat(FMT,",");            
    strcat(FMT,typeid(&cnt).name());
    strcat(FMT,",");
    strcat(FMT,typeid(&Lat).name());
    strcat(FMT,",");
    strcat(FMT,typeid("Voy a dar un paseo ahora").name());
    strcat(FMT,",");    
    strcat(FMT,typeid((cnt*ucnt)).name());
    strcat(FMT,",");
    strcat(FMT,typeid((cnt*f)).name());
    strcat(FMT,",");        
    printf("FMT %s\n",FMT);
//

//  Ladeg = cpp2asl (3,"coorToDeg", Lat, 2);
//  Ladeg = cpp2asl (3,"coorToDeg", "S,I,", Lat, 2);

//
//

//  Ladeg =  coorToDeg(Lat,2);  ==>

///  FMT = scat(typeid(Lat).name(),typeid(M).name(), typeid(2).name());

    FMT[0] = '\0';
    strcat(FMT,typeid(Lat).name());
    strcat(FMT,",");
    strcat(FMT,typeid(M).name());
    strcat(FMT,",");
    strcat(FMT,typeid(2).name());
    strcat(FMT,",");
    strcat(FMT,typeid(q).name());
    strcat(FMT,",");    

    printf("FMT %s\n",FMT);


//  Ladeg =  coorToDeg(Lat,1);
//  preprocess to
//    Ladeg = cpp2asl ("coorToDeg",FMT,&Lat,1);
//  which will construct args into Svarg form
//  and call asl function
//  return Siv*

   FMT[0] = '\0';
    strcat(FMT,typeid(Lat).name());
    strcat(FMT,",");
    strcat(FMT,typeid(2).name());
    strcat(FMT,",");
    printf("FMT %s\n",FMT);


   Ladeg = cpp2asl ("coorToDeg",FMT,&Lat,1);


cout << "Lat " << Lat << " Siv Ladeg " << Ladeg << endl;


cout<<"Lat is of type: "<<typeid(Lat).name()<<std::endl;
cout<<"M is of type: "<<typeid(M).name()<<std::endl;
cout<<"R is of type: "<<typeid(R).name()<<std::endl;
cout<<"W is of type: "<<typeid(W).name()<<std::endl;
cout<<"2 is of type: "<<typeid(2).name()<<std::endl;


  //         q=scat(t,r);
  //    ==> 
    FMT[0] = '\0';
    strcat(FMT,typeid(t).name());
    strcat(FMT,",");
    strcat(FMT,typeid(r).name());
    strcat(FMT,",");    
    printf("FMT %s\n",FMT);

    t = "One feature ";
    r = "at a time! ";
    // afmt(2,FMT,typeid(&t).name(),typeid(&r).name());

    R =cpp2asl ("scat",FMT,&t,&r);

cout << "str R = "  << R << " str t " << t << " str r " << r << endl;

chkN(1,1);
chkOut();



}






/*

  W.split("one day at a time", sindex) // split WS 


*/
