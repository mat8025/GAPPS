
//setDebug(1)

///   --- retyping an existing variable
/// should throw an error but not crash

CheckIn()

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

setdebug(1,"trace")


act_ocnt++;


<<"%V$act_ocnt \n";

Act A

Act G[3]


 checkNum(A->t,0)

set_si_error(0)

we = si_error()

<<" %v $we \n"

//CheckNum(we,we)

/{
Act A[3];

we = si_error()

<<" %v $we \n"
 if (si_error()) {

<<"we $(get_si_error_name())\n"
  CheckNum(we,28)

 }
/}

 CheckOut()

stop!
