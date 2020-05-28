<<" first line\n"

include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_","hop_");

setdebug(1,@pline,@trace)

checkin()


proc Sin (real a)
{
<<"$_proc  $a \n"
real y;
 y = sin(a)
 <<" out $y \n" 
  return y
}
//=================//


<<"Proc Sin defined \n"

  my =  Sin(0.5) 

<<" %V $my   \n"

checkRnum(my,sin(0.5))


checkOut()

