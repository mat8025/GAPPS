
include "rl"
include "rl_cmplx"

proc rewrite ()
{
A=ofw("rl.asl")

<<[A]"//// \n";
<<[A]"//=====// \n";

<<[A]"proc Goo()\n"
<<[A]"{\n"
<<[A]"<<\"\$_proc \\n\"\n"
<<[A]"<<\" HI 1\\n\"\n"
<<[A]"<<\" HI $nrl\\n\"\n"


<<[A]"int a = $nrl;\n"
<<[A]"<<\"\%V\$a \\n\"\n"

<<[A]"a->info(1);\n"
<<[A]"}\n"
cf(A)
}

<<" got lib \n"
nrl =1;
do_it = "xx"

 while (1) {

   Goo()
   Hoo()
   do_it = i_read("reload [y/n/q]:->")
   do_it->info(1)
   if (do_it @="y") {
 <<"reloading includes \n"
    rewrite()
    reloadSrc()
    nrl++;
   }
   if (do_it @="q") {
       break;
   }
   M++;
   <<"%V $M\n"
 }





///////////////////////
/{/*
proc Goo()
{
<<"$_proc\n"

<<" HI 1\n"

<<" HI \n"

int a = 1;
a->info(1);

}
/}*/

