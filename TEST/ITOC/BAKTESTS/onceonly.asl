///
/// Onceonly code
///
///  want something like this
setdebug(1)

A = 0
B = 0
C = 0

  
proc do_this()
{
<<"$_proc\n"
 A++

}

proc do_that()
{
<<"$_proc\n"
 B++
}

proc do_the_other()
{
<<"$_proc\n"
  C++
}


///
///  onceonly function
///  it will be called only once and then that statement
///  is labelled SSOO and would never execute again!
///

// but compiled version does not work!!

topof: <<"at top of \n"

<<" the file \n"
int loop = 0
 while (1) {

   do_this ()
   do_that ()

ooc: <<" yep just once!\n"

ooc: do_the_other()
   

ooc:  <<"%V$A\n";

    loop++
    

    if (loop > 6) { 
      break;
     }
 }


<<"%V $A $B $C \n"