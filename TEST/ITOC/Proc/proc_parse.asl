////
///
///

setdebug(1)

proc foo()
{

 <<"$_proc \n"

a= 1
   if (a > 0) {
<<"$_proc in if\n"
   }
   else {
<<"$_proc in else\n"
   }


}

////////////////////

proc goo()
{

 <<"$_proc \n"

a= 1
   if (a > 0) {
<<"$_proc in if\n"
   }
   else {
<<"$_proc in else\n"
   }
}





///////////////


  foo()

  goo()

proc hoo()
{

 <<"$_proc \n"

a= 1
   if (a > 0) {
<<"$_proc in if\n"
   }
   else {
<<"$_proc in else\n"
   }

}

 hoo()


