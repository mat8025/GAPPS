

////
///
  
include  "consts"

<<"$_c m/s %e $_c\n"

double f = (1.0e2  * 2);

<<"%V $f\n"







<<"%e $_c \n"
nano = 10.0e-9;

//double olen = 380.0 * 1.0e-9 ;

double olen = (380.0 / 1.0e9);
//double olen = 380.0 ;

//olen *= nano;
<<"%V %e $olen\n"



e= olen/_c; // time to go olen metres

f =  1.0/e;  // freq HZ

//f /= 1.0e9; // Ghz
giga = 10.0e9;

//g = f * 10.0e-9;
//t = g * 10.0e-3;

g = f / 1.0e9;
t = g / 1.0e3;

  g1 = f / 1000000000.0;
  t1 = g1 / 1000.0;

  g2 = f / 10.0^9;
  t2 = g1 / 10.0^3;



<<"%e $_c  $e  %f $f Hz $g GHz $t Thz \n %e $f $g $t\n"

<<"%e $_c  $e  %f $f Hz $g1 GHz $t1 Thz \n %e $f $g1 $t1\n"

<<"%e $_c  $e  %f $f Hz $g2 GHz $t2 Thz \n %e $f $g2 $t2\n"

pan t3 = f;

<<"%V $t3 %e $t3 $f\n"