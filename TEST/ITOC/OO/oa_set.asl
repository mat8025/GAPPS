///
/// oa_set
///


setDebug(1,@trace,@pline,@soe)

int Act_ocnt = 0;

class Act {

 public:

 int type;
 int mins; 
 int t;

 CMF Set(s)
 {
     obid = _cobj->obid()
     <<"Act Set  $_cobj \n" 
      type = s;
     <<"type  $s $type\n"
     return type;
 }

 CMF Get()
 {
   return type;
 }

 CMF Act() 
 {
   <<"Act cons of $_cobj $Act_ocnt\n"

    Act_ocnt++ ;

   type = 1;

   mins = 10;

   t = 0;
 }

};
//================================

chkIn();

Act a;

    a->type = 2;
<<"%V$a->type \n"
    a->type = 3;
<<"%V$a->type \n"
    a->Set(5);
<<"%V$a->type \n"


 Act X[4];


 X[3]->type = 66

 yt = X[3]->type;
<<" 66? %V $yt\n"
 chkN(yt,66);




 X[0]->type = 47;
 
 yt = X[3]->type;
<<" 66? %V $yt\n"
 chkN(yt,66);

 yt = X[0]->type;
<<" 47? %V $yt\n"
 chkN(yt,47);


 X[0]->type = 50;
 X[1]->type = 79;
 X[2]->type = 47;
 X[3]->type = 80;

yt = X[2]->type

<<"47? type for X[2] $yt $(typeof(yt)) \n"

 chkN(yt,47);

yt = X[3]->type;

<<"80? type for X[3] $yt \n"

 chkN(yt,80);

chkOut()

