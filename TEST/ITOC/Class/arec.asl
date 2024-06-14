///
///  our simple class for testing
///

  int Rec_id = 0;

class Arec {

  public:
  
  Svar srec;

  int a;

  int id;

  Str sr;
  int IV[20]

  Str Get(int wf)
  {
  
   Str val;
  <<"wf $wf \n"

  wf.pinfo()

  srec.pinfo()

  val = srec[wf];
  
  <<"$val \n"

  val.pinfo()
ans=ask("%V $val $__FILE__   $__FUNC__  $__LINE__ $_scope $_include $_script [y,n,q]",0);
  return val;
  };

//[MF]================//
  void Describe()
  {
    <<"$_proc \n"

   <<" $srec \n"


  }
  
//[MF]================//

 Str SetVal(Str val, int wf) {
   <<"$_proc  $val  $wf \n"
  wf.pinfo()
  srec[wf] = val;
  rval =  srec[wf];
//  return srec[wf];
  rval.pinfo()
  
     return rval;
  };


  Str Set(Str val, int wf) {
  wf.pinfo()
  srec[wf] = val;
  rval =  srec[wf];
//  return srec[wf];
  rval.pinfo()
  
     return rval;
  };
// currently need cmf keyword for constructor

/*
  Str Oset(Str val) {
    int si =3
  srec[si] = val;
  rval =  srec[si];
//  return srec[wf];
  rval.pinfo()
  
     return rval;
  };
*/


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
  <<"cons $a $id\n"
  IV.pinfo()
  IV[id] = id;
//  srec = "xxx $id";
    sr.pinfo();
    sr = "xxx $id";
  <<"cons  %V $sr  $IV\n";
  };

  }
//===========================//



<<" loaded  arec $_include \n"