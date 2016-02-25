
include "rl"

<<" got lib \n"

do_it = 0

 while (1) {

   foo()

  

   do_it = i_read(":->")
   if (do_it) {
 <<"reloading includes \n"
    reload_src(1)
   }
 }