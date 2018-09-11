///
/// icall --- use variable string value to call proc
///


// bug -- XIC - if proc not found the XIC CALLIP is not inserted
// needs to be be inserted regardless is proc is found/valid

// what about call func -- indirect ??

include "debug.asl"


debugON();

N = 0;


proc Foo()
{

<<"in $_proc \n"

   N = 1;


}


proc Goo()
{

<<"in $_proc \n"

   N = 2;
}


proc Zoo()
{

<<"in $_proc \n"

   N = 3;
}



   Foo();

<<"%V $N\n"


   Goo();

<<"%V $N\n"


 pname = "Foo";

<<"calling $pname\n"
 $pname();

<<"%V $N\n"


 pname = "Goo";

<<"calling $pname\n"

 $pname();

<<"%V $N\n"


 pname = "Zoo";
<<"calling $pname\n"
 $pname();

<<"%V $N\n"

 while (1) {

 pname = i_read("which proc?:")
 <<"calling $pname\n"
 if (pname @= "quit") {
     break;
 }
 else {
  $pname();
  <<"$pname sets %V $N\n"
 }
 
 }


 while (1) {

 pname = i_read("which proc?:")
 <<"calling $pname\n"
 if (pname @= "quit") {
     break;
 }
 else {
  $pname();
  <<"$pname sets %V $N\n"
 }
 
 }




exit()

