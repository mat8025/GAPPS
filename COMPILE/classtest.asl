//%*********************************************** 
//*  @script class.asl 
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



#define ASL 0
#define CPP 1

#if CPP
 extern "C" int classtest(Svarg * s)  {
#endif


#if CPP
 n = s->getArgI() ;
 cout << " para is " <<  n  << endl;
#endif




chkIn(_dblevel)

/// simple class test

<<"simple class test\n"



////////////////////////
int Obid = 0;

class Add
 {
  public:

   float x ;
   float y;
   int id;
   
 cmf Add()
  {
    id = Obid++;
    <<"CONS $_cobj %V $id\n"
    x = 0;
    y = 0;

  }


  real  sum (real a,real b)
  {
   t = a +b;
   return t;
  }

  int  sum (int a,int b)
  {
  <<"$_proc $a $b \n"
   t = a +b;

   return t;
  }

  int  diff (int a,int b)
  {
   int t;
   t = a -b;
   return t;
  }

  str say()
  {
   <<"$_proc hey there I exist\n";
   isay="hey hey"
   return ("hey hey");
  }

  str isay()
  {
   <<"$_proc hey there I exist\n";
   isay="Do what I say"
   return isay;
  }
  
}

//int s;

Add  tc;   

Add.pinfo();

    s= tc->sum(4,5);

chkN(s,9);

<<"%V $s $(typeof(s)) \n";

      s= tc->diff(30,20);


chkN(s,10);

chkOut();



}




