/* 
   *  @script xicfast.asl
   *
  *  @comment test of xic go fast mods
  *  @release CARBON
  *  @vers 1.2 He Helium [asl 6.3.67 C-Li-Ho]
  *  @date 12/17/2021 09:28:34
  *  @cdate 12/17/2021 09:28:34
  *  @author Mark Terry
  *  @Copyright © RootMeanSquare  2010,2021 →
  *
  *  \\-----------------<v_&_v>--------------------------; //
 */ 


  ;//----------------------//;
<|Use_= 
  Demo  of test of xic go fast mods
/////////////////////// 
|>

#include "debug"

  if (_dblevel >0) {

  debugON();

  <<"$Use_ \n";

  }

  allowErrors(-1);

  chkIn();


  int on = 0;

  if (argc() > 1) {

     on =atoi(_clarg[1]);
  }

<<"fast is $on\n"

  int m = 1;

  int n = 1;

  n++;

  <<"%V$n $m\n";

  m--;

  <<"%V$n $m\n";

  int l =3 ;

  m -= l;

  <<"%V$n $m $l\n";

  fastx(on);

  double a = 1;

  double b = 2.3;

  double c = 4.8;

  <<"%V$a $b $c\n";

  b++;

  <<"%V$a $b $c\n";

  Ut = fineTime();

  int N = 1000;

  for (i = 0 ; i <N ; i++) {

  a = b + c;

  c = a;
//<<"%V$i $a $b $c\n"      

  b++;

  }

  dt1 = fineTimeSince(Ut);

  tpl = dt1/(1000.0*N);

  <<"%V$a $b $c\n";

  <<"%V$dt1 $tpl\n";

  chkT(1);

  chkOut();

//==============\_(^-^)_/==================//
