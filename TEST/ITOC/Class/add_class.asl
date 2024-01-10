
///
///  our simple add class for testing
///

 int Obid = 0;


  class Add {

  public:

  float x ;

  float y;

  int id;

  cmf Add()
  {
  id = Obid++;

  <<"CONS $_cobj %V $id\n";

  x = 0;

  y = 0;

  }

  real sum (real a,real b)
  {
  t = a +b;
  return t;
  }

  int sum (int a,int b)
  {
  t = a +b;
  t.pinfo()
ask(" %V $__FILE__  $__FUNC__ $__LINE__  $_scope $_include $_script [y,n,q]",DB_action);  
  return t;
  }

  int diff (int a,int b)
  {
//  int t;

  t = a -b;

  return t;

  }

  Str say()
  {

  <<"$_proc hey there I exist\n";

  isay="hey hey";

  return ("hey hey");
   //return isay;

  }

  Str isay()
  {

  <<"$_proc hey there I exist\n";

  isay="Do what I say";

  return isay;

  }

  float where( Str la )
  {

   fla =  coorToDeg(la,2*1); 

   return fla;
 }



  }


<<"include add_class  $_include \n"
