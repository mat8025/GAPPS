

////
///

include  "consts"
setap(100);
<<"$(typeof(_c)) $_c m/s %e $_c\n"


//double olen;

// BUG TBF soon
//  precision of pan eqn not >= DOUBLE why??

pan olen;
pan pf;

 pf = 1.0e-9;
 //pf *= 1.0e-5;

// olen =  1.0e-9 * 380 ;

 olen =  pf * 380 ;

<<" $(typeof(olen)) %V %e $olen \n"

  t = olen/_c;

<<"time %V %e $t\n"

  f = 1.0/t;

<<"f %V %e $f Hz\n"

  fth = f/1.0e12;

<<"%V  $fth  THz\n"