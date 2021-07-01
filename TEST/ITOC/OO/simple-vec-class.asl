///
///
///
//include "debug"
//debugON()



chkIn (_dblevel);
//setdebug(2,@keep,@trace@pline,@~step)

class Simple {


 public:

 int sa;
 str pn;
 int avec[20];
 
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

  cmf Simple()

  {
    
    sa = 19;
    <<"%V$sa\n"
    pn = pt(sa)
   <<"$pn"
    avec[0] = 67;
    
  }

}
//----------------------------------------------


 Simple S;


 S->Set(67)

 S->Print();

 S->Set(71)

 S->Print();

exit();