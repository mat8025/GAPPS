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


exit_si()

