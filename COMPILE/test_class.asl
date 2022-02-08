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



void
Uac::objWorld(int n, int m)
{

   cout << "hello simple Obj/class test  " << endl;


chkIn(1);

/// simple class test

//<<"simple class test\n"

////////////////////////
//#include "tpclass.asl"


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
    x = Obid;
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



int s;


Add  tc;   


//Add.pinfo();

    s= tc.sum(n,m);

chkN(s,(n+m));

//<<"%V $s $(typeof(s)) \n";

//cout << " sum s " << s << endl;



      s= tc.diff(n,m);
      cout << " diff s " << s << endl;

chkN(s,(n-m));

 Vec V(DOUBLE_,10,10,1);

  V.pinfo();
double rms;

  rms = V.rms();

cout <<"rms " << rms << endl;

Add  am[5];

   s= am[0].sum(n,m);
chkN(s,(n+m));

cout << "am[1].x " << am[1].x << endl;

chkOut();


}
//==============================//


 extern "C" int test_class(Svarg * sarg)  {


 int n = sarg->getArgI() ;
 int m = sarg->getArgI() ;
 cout << " Simple class demo "  << endl;
 cout << " paras are n " <<  n << " m " << m << endl;

    Uac *o_uac = new Uac;

   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 


    o_uac->objWorld(n,m);

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
