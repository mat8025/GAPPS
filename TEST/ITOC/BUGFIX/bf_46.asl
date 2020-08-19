
//setDebug(1)

///   --- retyping an existing variable
/// should throw an error but not crash

include "debug.asl"
debugON()
setdebug(1,@keep,@pline)
FilterFileDebug(REJECT_,"storetype_e",)


chkIn()

int i = 0

<<" i $(IDof(&i)) \n"

vid = i->vid()

//FIXME <<" $vid $(i->vid())\n"


<<"%V $vid \n"


float F[10];

vid = F->vid()

<<"Fid $vid \n"

vid = F[2]->vid()

<<"F[2] $vid \n"


int act_ocnt = 0;


act_ocnt++;


<<"%V$act_ocnt \n";




class Act {

 public:

 int type;
 int mins; 
 int t;

 CMF Set(s)
 {
     obid = _cobj->obid()
//     <<"Act Set  $_cobj  $obid $(offsetof(&_cobj)) $(IDof(&_cobj))\n" 
     <<"Act Set  $_cobj \n" 
      type = s
     <<"type  $s $type\n"
     return type
 }

 CMF Get()
 {

   return type

 }

 CMF Act() 
 {
//FIXME   <<"cons of Act $_cobj $(_cobj->obid())  $(IDof(&_cobj))\n" 
//   co = _cobj->offset()
//   <<"cons of Act $_cobj   $(IDof(&_cobj)) $(offsetof(&_cobj)) co $co\n" 
   <<"Act cons of $_cobj $act_ocnt\n"
   //act_ocnt += 1;
   act_ocnt++
   
   type = 1
   mins = 10;
   t = 0;

 }

}


act_ocnt++;


<<"%V$act_ocnt \n";

Act A

Act G[3]


chkN(A->t,0)

setErrorNum(1)
we = lastError()
en =  ErrorName()
<<" %v $we $en\n"


seterrorNum(2)
we = lastError()
en =  ErrorName()
<<" %v $we $en\n"

//chkN(we,we)

/{
Act A[3];

we = si_error()

<<" %v $we \n"
 if (si_error()) {

<<"we $(get_si_error_name())\n"
  chkN(we,28)

 }
/}

 chkOut()


