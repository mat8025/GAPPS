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

#define ASL 1
#define CPP 0

#if ASL
 int n = 4;
 int m = 5;
  <<" Simple class demo \n";
 <<" paras are %V $n $m\n";
#endif


#if CPP
 extern "C" int class_cpp(Svarg * sarg)  {
#endif


#if CPP
 int n = sarg->getArgI() ;
 int m = sarg->getArgI() ;
  cout << " Simple class demo "  << endl;
 cout << " paras are n " <<  n << " m " << m << endl;
#endif


<<"Hey \n"



chkIn(1);

/// simple class test

//<<"simple class test\n"
#if CPP
cout << "hello simple class test" << endl;
#endif


////////////////////////
//#include "tpclass.asl"


class Add
 {
 
  public:
   
   float x ;
   float y;
   int id;
   
// cmf Add()
  void Add()
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
 
};

<<"hey now\n"


int s;

pinfo(s);

Add  tc;   


//Add.pinfo();

    s= tc->sum(n,m);

chkN(s,(n+m));

//<<"%V $s $(typeof(s)) \n";
#if CPP
//cout << " sum s " << s << endl;
#endif

#if ASL
s= tc.diff(n,m);  // ? fix tc.diff - asl convention  but tc not ptr 

 <<" diff $s ";
#endif

#if CPP
      s= tc.diff(n,m);
      cout << " diff s " << s << endl;
#endif

chkN(s,(n-m));

 Vec V(DOUBLE_,10,10,1);

  V.pinfo();
double rms;

  rms = V.rms();

<<"%V $rms \n";





chkOut();


#if CPP
}
#endif





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
