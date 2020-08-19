///
/// icall --- use variable string value to call proc
///


// bug -- XIC - if proc not found the XIC CALLIP is not inserted
// needs to be be inserted regardless is proc is found/valid

// what about call func -- indirect ??

include "debug.asl"
debugON();
setdebug(1,@trace);



 x = 0.5;

 y=Sin(x);

<<" Sin($x) = $y\n"

 fname = "_cos";

<<"calling $fname\n"

 y= $fname (x);

<<" $fname ($x) $y\n"




 while (1) {

 fname = i_read("which tfun?:")
 <<"calling $fname\n"
 if (fname @= "quit") {
     break;
 }
 else {
  y= $fname(x);
  <<"$fname ($x) = $y\n"
 }
 
 }


exit()

