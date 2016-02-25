setdebug(1)

proc foo()
{

<<"IN FOO $_proc\n"


}

proc goo()
{

<<"IN GOO $_proc\n"


}


   goo()
   foo()

fname = "goo"

$fname()

fname = "foo"

$fname()




  for (i = 0; i < 10; i++) {
   if((i %2) == 0) {

       fname = "foo"

   }
   else 
       fname = "goo"
    <<" should be calling $fname now\n"

// don't compile this - always interp
   $fname()

  }
