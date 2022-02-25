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
Uac::objWorld(Svarg * sarg)  
{

   cout << "hello simple Obj/class test  " << endl;

 Str a0  = sarg->getArgStr(0) ;

 Svar sa;

 sa.split(a0.cptr(),' ');

//Str a1  = sarg->getArgStr(1) ;
// Str a2 = sarg->getArgStr(2) ;
//  Str a3 = sarg->getArgStr(3) ;

 cout << " objWorld paras are: a0 "  << a0 << endl;

 cout << " objWorld paras are: sa "  << sa << endl;

int n = atoi(sa.cptr(0));
int m = atoi(sa.cptr(1));

 cout << " objWorld paras are: n "  << n << " n " << m << endl;


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
   float z;
// cmf Add()
  Add()
  {
    id = Obid++;
 //   <<"CONS $_cobj %V $id\n"
    x = Obid;
    y = 0;
    z = 0.0;
  };


  float  sum (float a, float b)
  {
     printf("float sum  a %f b %f \n",a,b);
   int t = a +b;
   z = a + b;
   myprint();
   return t;
  };

  int  sum (int a,int b)
  {
 // <<"$_proc $a $b \n"
   printf("int sum  a %d b %d \n",a,b);
   int t = a +b;
   this->myprint();
   return t;
  };

  int  diff (int a,int b)
  {
  printf("in diff a %d b %d \n",a,b);
   int t;
   t = a -b;
   z = a -b;
   myprint();
   return t;
  };

  void myprint()
  {

    printf("myprint: id %d  x%f y %f  z %f\n",id,x,y,z);

  }


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

   s= am[1].diff(n,m);


cout << "am[1].x " << am[1].x << endl;

   s= am[2].sum(n,m);


   s= am[3].sum(4.67f,8.123f);

chkOut();


}
//==============================//


 extern "C" int test_class(Svarg * sarg)  {


 //Svar *args = sarg->getArgSvar(0) ;

 //cout << "args[0]: " << args.cptr(0) << endl;

 //cout << "args: " << args << endl;


 Str a0 = sarg->getArgStr(0) ;
 
 //Str a1 = sarg->getArgStr(1);
// Str a2 = sarg->getArgStr(2) ;
 // Str a3 = sarg->getArgStr(3) ;
  
 cout << " Simple class demo "  << endl;
 cout << " paras are: "  << " a0 " <<  a0 << endl;


//<< " a2 " << a2
// << " a3 " << a3

Svar z;
  CLarg.pinfo();

 z.getVarAsStr(&CLarg,2);

cout << "clargs?? " << z << endl;


    Uac *o_uac = new Uac;

   // can use sargs to selec uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 


   o_uac->objWorld(sarg);

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
