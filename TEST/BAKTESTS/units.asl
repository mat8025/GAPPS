///
///
///
setdebug(1,"trace")
setap(100)
 int M = 4 *5;
 <<"$M\n"

 //double F = 3 * 1.0e9;
 double x;
 
  x=  1.234567e-15 ;
  y = x;
  <<"%V %e $x $y  %40.20f $y\n"

 pan p ;

  p = x ;

<<"%V  $p \n"

 p=  1.123456e-9 ;

<<"%V %e $p\n"
 p = x * 10^-3;

<<"%V %e $p\n"
 p = 123460.000000000000000000700000000000001;
 q = p * 10000000000.0

 <<"%V %p $p $q\n"
  <<"%V  $q  $(typeof(q))\n"
    <<"%V  $p  $(typeof(p))\n"

    <<"%V  %e $p  \n"
exit()

double F = 3 * (4.0 * 1.0e2) ;
 <<"%V $F\n"

 double G = 4.0 * 5;
 <<"%V $G\n"

 double am = 1.0e0;

<<"%V %12.9f $am   %e $am\n"

double olen = 3.0 * 1.0e9;

<<"%V $olen %e $olen\n"

 c = 1.0/1000.0;


<<"%V %12.9f $c   %e $c\n"



 double nm = 1.0e-9;

<<"%v %12.9f $nm   %e $nm\n"


 d = 10.0^1;

<<"%V $d %e $d\n"

 d = 10.0^2;

<<"%V $d %e $d\n"

 d = 10.0^9;

<<"%V $d %e $d\n"

 e = pow(10.0,9);

<<"%V $e %e $e\n"

 x = 10.0^-2;

<<"%V $x %e $x\n"

