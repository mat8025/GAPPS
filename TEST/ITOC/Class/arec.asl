
///
///  our simple class for testing
///

  int Rec_id = 0;

class Arec {

  public:

  Svar srec;

  int a;

  int id;

  Str Get( int wf) {
   Str val;
  <<"wf $wf \n"
  wf.pinfo()
  val = srec[wf];
  
  <<"$val \n"

  pinfo(val);
//ask("%V $__FILE__   $__FUNC__  $__LINE__ $_scope $_include $_script [y,n,q]",DB_action);
  return val;
  };

  Str Set(Str val, int wf) {
  wf.pinfo()
  srec[wf] = val;
  rval =  srec[wf];
//  return srec[wf];

     return rval;
  };
// currently need cmf keyword for constructor

 int get_a()
 {
   <<"$_proc $a\n"
   a.pinfo();
   return a;
  }

  void Arec ()
  {

  id=Rec_id++;

  a = id;
      //id = Rec_id;

  <<"constructing  %V $id  $Rec_id\n";

  };

  }
//===========================//



<<" loaded  arec $_include \n"