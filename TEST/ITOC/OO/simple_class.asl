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

 cmf Print()
  {
    <<"$sa\n"
   pn = pt(sa)
    <<"$pn\n"
  }


 cmf Set (int val)
  {
     sa = val;

  }

 cmf Get ()
  {
     //sa->info(1);
     sa<-pinfo();
     return sa;
  }

 cmf Getlocalpv ()
  {
     int new_sa;
     new_sa = sa+1;
     <<"%V $sa $new_sa\n"
     return new_sa;
  }

  cmf Simple()

  {
    
    sa = 19;
    <<"%V$sa\n"
    pn = pt(sa)
   <<"$pn"
    
  }

}
//----------------------------------------------


 Simple S;


 S->Set(67)

 S->Print();

 val = S->Get();

 chkN(val,67);
 
!p val



 S->Set(71)

 S->Print();

mval = 63;


 S->Set(mval)

 S->Print();

nval = S->Get()

!i nval


Simple oa[5];

mval = 37;

 oa[1]->Set(mval)

nval = oa[1]->Get()

!i nval

mval = 79
 oa[3]->Set(mval)

nval = oa[3]->Get()

!i nval


mval = 82
wo = 4;
 oa[wo]->Set(mval)

nval = oa[wo]->Get()

!p wo
!i nval

nval = oa[wo]->Getlocalpv()

!p wo
!i nval

mval = 33
wo = 2;
 oa[wo]->Set(mval)

nval = oa[wo]->Get()

!p wo
!i nval

nval = oa[wo]->Getlocalpv()

!p wo
!i nval

mval = 33
wo = 3;

 oa[wo]->Set(34)

nval = oa[wo]->Get()

!p wo
!i nval

nval = oa[wo]->Getlocalpv()

!i nval


chkOut()