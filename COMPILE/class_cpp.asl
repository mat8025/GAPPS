//%*********************************************** 
//*  @script class_cpp.asl 
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
 extern "C" int class_cpp(Svarg * sarg)  {
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

cout << "hello simple class test" << endl;



////////////////////////
#include "tpclass.asl"


class Add
 {
  public:
   
   float x ;
   float y;
   int id;
   
// cmf Add()
 Add()
  {
    id = Obid++;
 //   <<"CONS $_cobj %V $id\n"
    x = 0;
    y = 0;

  };


  float  sum (float a, float b)
  {
   int t = a +b;
   return t;
  };

  int  sum (int a,int b)
  {
 // <<"$_proc $a $b \n"
   int t = a +b;

   return t;
  };

  int  diff (int a,int b)
  {
   int t;
   t = a -b;
   return t;
  };
  
/*
  Str say()
  {
   //<<"$_proc hey there I exist\n";
   Str isay ("hey hey");
   return isay;
  }

  Str isay()
  {
   //<<"$_proc hey there I exist\n";
   isay="Do what I say";
   return isay;
  }
 */ 
};


int s;

//pinfo(s);

Add  tc;   

//Add.pinfo();

    s= tc.sum(n,m);

chkN(s,(n+m));

//<<"%V $s $(typeof(s)) \n";

cout << " sum s " << s << endl;

      s= tc.diff(n,m);

cout << " diff s " << s << endl;

chkN(s,(n-m));

chkOut();



}






/*

 cmf  remove

 after class {}  need ;

 need a translate of <<"%V $s\n"
 to cout

 chkIn ==> checkIN()


 all member functions need terminating ;




classtest(Svarg * sarg) 

avoid using sarg name

 X.pinfo()  // vmf ??

*/
