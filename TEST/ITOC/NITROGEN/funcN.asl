///
///
///





 z = Sin(1.234);

<<"sin (1.234) = $z \n"


 double a = 0.5;

<<"%V $a\n";

 y = Sin(a);

<<"Sin $a = $y \n"



 y = Cos(a)

<<"Cos( $a ) = $y \n"


 double x = 0.75;

<<"%V $x\n";


 z = Sin(x);

<<"Sin( $x ) = $z \n"


 y2 = Tan(x);

<<"Tan( $x ) = $y2 \n"


exit();

 sfoo();

<<"after no arg, no return func call \n";

 ret_res=sfoo();

<<"after no arg func call \n";
<<"%V $ret_res\n"

 exit()
 
/{
 i=findfunc();

<<"%V$i\n"


 i=findfunc("scat");

<<"%V$i\n"



 getsig();


 a= date();
 <<"$a\n"


str ws ="hola"

<<"$ws\n"

nws = scat(ws," que tal");

<<"$nws\n"


  y = sin(1.0)

<<"%V $y\n"
/}

exit()

