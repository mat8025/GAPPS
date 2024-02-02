///
///
///

<|Use_=
  demo some OO syntax/ops
|>


#include "debug"


if (_dblevel >0) {
   debugON()
    <<"$Use_\n"   

}

allowErrors(-1)

   

chkIn (_dblevel);


class Simple {


 public:

 int sa;
 str pn;

 void Print()
  {
    <<"$sa\n"
   pn = pt(sa)
    <<"$pn\n"
  }


 void Set (int val)
  {
     sa = val;

  }

 int Get ()
  {
     
     sa.pinfo();
     return sa;
  }

 int Getlocalpv ()
  {
     int new_sa;
     new_sa = sa+1;
     <<"%V $sa $new_sa\n"
     return new_sa;
  }

  void Simple()
  {
    
    sa = 19;
    <<"%V$sa\n"
    pn = pt(sa)
   <<"$pn"
  }

}
//----------------------------------------------


 Simple S;


 S.Set(67)

 S.Print();

 val = S.Get();

 chkN(val,67);

 S.Set(71)

 S.Print();

mval = 63;


 S.Set(mval)

 S.Print();

nval = S.Get()

//!i nval


Simple oa[5];

mval = 37;

 oa[1].Set(mval)

nval = oa[1].Get()

  nval.pinfo()

mval = 79
 oa[3].Set(mval)

nval = oa[3].Get()

 nval.pinfo()


mval = 82
wo = 4;
 oa[wo].Set(mval)

nval = oa[wo].Get()


nval = oa[wo].Getlocalpv()



mval = 33
wo = 2;

oa[wo].Set(mval)

nval = oa[wo].Get()


nval = oa[wo].Getlocalpv()


mval = 33
wo = 3;

 oa[wo].Set(34)

nval = oa[wo].Get()


nval = oa[wo].Getlocalpv()

nval.pinfo()


chkOut()

