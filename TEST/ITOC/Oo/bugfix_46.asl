
//setDebug(1)

CheckIn()

int i = 0

<<" i $(IDof(&i)) \n"

vid = i->vid()

//FIXME <<" $vid $(i->vid())\n"


<<"%V $vid \n"


float F[10]


vid = F->vid()

<<"Fid $vid \n"

vid = F[2]->vid()

<<"F[2] $vid \n"

int act_ocnt = 0

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
   act_ocnt++
   type = 1
   mins = 10;
   t = 0;

 }

}


Act A

Act G[3]

Act F[3]
we = si_error()
<<" %v $we \n"
 if (si_error()) {

<<"we $(get_si_error_name())\n"

 }
 CheckNum(we,28)
 CheckOut()

stop!
