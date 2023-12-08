/* 
 *  @script procarg.asl 
 * 
 *  @comment test some usage of proc args 
 *  @release CARBON 
 *  @vers 1.7 N Nitrogen [asl 6.3.11 C-Li-Na] 
 *  @date Sun Jan 17 11:08:15 2021 
 *  @cdate Sat May 9 14:53:10 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


 


#include "debug.asl"

  if (_dblevel >0) {

  debugON();



  }

  showUsage("Demo  of proc arg scalar")
  
  chkIn(_dblevel);
  fileDB(ALLOW_,"spe_proc,spe_args")
  int sumarg(int a, int b)
  {

  <<" sumarg int vers\n";

  c = a+ b;

  <<" %V$a + $b = $c \n";

  return c;

  }

  real sumarg(real a, real b)
  {

  c = a+ b;

  <<" %V$a + $b = $c \n";

  return c;

  }

  int ReadPulseFile(Str pfname)
  {

  <<" %i $pfname \n";

  len =0;

  len = slen(pfname);

  <<"%I $pfname $len\n";

  <<" $_proc $pfname \n";

  return len;

  }

  void soo (Svar vsv)
  {

  <<"$_proc $vssv \n";
  arginfo = vsv.info()
  <<"$arginfo \n"
  vsv.pinfo()
  <<"arg should be a Svar! \n"
  <<"$vsv[0] $vsv[1] \n";

  mstr = split(vsv);

  s = mstr[0];

  m = mstr[1];

  <<"%V $s $m\n";

  }
//------------------------------
// TBF call Str or Svar ?
  void soo (Str vstr)
  {

  <<"%V $_proc $vstr \n";
  vstr.pinfo()

   <<"arg should be a Str! \n"

   <<"$vstr[0] $vstr[1] \n";

   ms = vstr
   
   ms.pinfo()
  <<"%V $ms\n";

  }
//------------------------------

  void Foo(Str vstr)
  {

  <<" $_proc $vstr \n";

  mstr = split(vstr);

  s = mstr[0];

  m = mstr[1];

  <<"  $s $m\n";
  }
//------------------------------

  x = 3;

  y = 7;

  z= sumarg( x,y);

  <<" $x + $y = $z \n";

  chkN(z,10);

  chkOut();

  I = Igen(10,0,1);

  I.pinfo();

  <<"$I \n";

  tot =   sumarg(I[1],I[2]);

  <<"%V$tot \n";

  chkN(tot,3);

  fname= "procarg.asl";
//  fileDB(ALLOW_,"paramexp")
  <<" %V$fname \n";

  k=ReadPulseFile(fname);

  <<" %v$k \n";
//ttyin()

  sen = Split("the message was gobbledegook");

  <<"$sen \n";

  <<"sen $(typeof(sen)) \n";
//FIX <<" %i $sen \n"

  <<"$sen \n";

  <<"$sen[0] \n";

  psa = "the";

  ssa = sen[0];

  <<"ssa $(typeof(ssa)) $ssa \n";

  ok = chkStr(ssa,psa);

  <<"test 1 $ok\n";

  ok =chkStr(sen[0],psa);

  <<"test 2 $ok\n";

  ok = chkStr(sen[0],"the");

  <<"test 3 $ok\n";

  ok = chkStr(sen[3],"gobbledegook");

  <<"test 4 $ok\n";

  <<"crash  $sen\n";

  A=ofr("procarg.asl");

  if (A == -1) {

  A=ofr("procarg.asl");

  }

  k = 0;

  while (k < 100) {

  nwr = sen->ReadWords(A);

  if (nwr > 0) {

  <<"$nwr $k $sen[0] $sen[1] $sen[2] $sen[3]\n";
  //  sen->split()

  soo(sen);
//  Foo(sen)

  }

  k++;

  }

 <<" done loop %V $k \n";

  soo("Once upon a time");
  
 db_action =0


 ans=ask(DB_prompt,db_action)
 
  Svar st = "Twice upon a time"

  soo(st);

 ans=ask(DB_prompt,db_action)

  soo("Thrice upon a time");

 ans=ask(DB_prompt,db_action)



  chkOut();

//==============\_(^-^)_/==================//
