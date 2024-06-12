/* 
 *  @script proccall.asl 
 * 
 *  @comment test out name mangling for proc/cmf 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.61 C-Li-Pm] 
 *  @date 11/23/2021 12:11:15          
 *  @cdate Tue Mar 31 14:52:28 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///
///
///
#include "debug"

  if (_dblevel >0) {

  debugON();

  }

  allowErrors(-1) ;  // keep going;

  chkIn();
  
   if (_dblevel < 1) DB_action = 0;
   
  int n1 = 3;

  <<"%V$n1\n";

  chkN (n1,3);

  n1++;

  <<"%V$n1\n";

  chkN (n1,4);

  ++n1;

  <<"%V$n1\n";

  chkN (n1,5);

  int moo(int a)
  {

  <<" $_proc $a \n";

  a.pinfo();

  return a;

  }

  <<"moo(float) ?\n";

  float moo(float x)
  {

  <<" $_proc $x \n";

  x.pinfo();

  return x;

  }

  <<"moo(short,char) ?\n";

  char  moo(short s, char c)
  {

  <<" $_proc $s $c\n";
  char d;
  s.pinfo();

  c.pinfo();
//  allowDB("opera_")
  d= s + c;
  d.pinfo()
  return d;

  }

  <<"moo(pan , pan) ?\n";

  pan moo (pan m, pan n)
  {

  pan    d;

  d = m + n;

  <<" $_proc %V $m $n $d \n";

  return d;

  }
//===============

  <<"moo(double, int ) ?\n";

  double moo (double m, double n)
  {

  double d;

  d = m + n;

  <<" $_proc %V $m $n $d \n";

  return d;

  }
//===============

  int j = 52;

  <<"call moo int\n";

  k= moo(j);

  chkN (k,52);

  float y = 2.1;

  <<"call moo float\n";

  z= moo(y);

  chkN (z,2.1);

  short s1 = 67;

  char c1 = 33;

  <<"call moo short,char\n";

  s2 = moo(s1,c1);

 s2.pinfo()

  chkN (s2,100);

  pan p  = 3.4;

  pan q = 1.2;

  <<" call  moo (pan , pan) \n";

  d4 = moo(p,q);

  d4.pinfo();

  <<"%V$d4\n";

  ans = "mark";

  <<"Que pasa $ans ?\n";

  double g = 3.4;

  double h = 8;

  <<" call  moo (double , double) \n";

  d3 = moo(g,h);

  chkN (d3,11.4);

  g = 77;

  h = 23.0;

  d3 = moo(h,g);
//<<"%V$d3\n"

  d3.pinfo();

  chkN (d3,100);

  a  = sin(0.5);

  <<"%v$a \n";

  chkOut();


//==============\_(^-^)_/==================//
