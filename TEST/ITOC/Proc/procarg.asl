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

  db_ask = 0;
  db_step = 0;  

//  fileDB(ALLOW_,"spe_proc,spe_args")
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

  <<"$_proc $vsv \n";
  vsv.pinfo()

//  arginfo = vsv.info()
//  <<"$arginfo \n"

  <<"arg should be a Svar! \n"
  <<"%V $vsv[0] $vsv[1] \n";
//  Svar mstr;
  //mstr = split(vsv);
  //mstr.pinfo()

  s = vsv[0];

  m = vsv[1];

  <<"%V <|$s|> <|$m|> \n";
ans=ask(" $s[0] $m[1] OK?:",db_ask)

}
//------------------------------
// TBF call Str or Svar ?
  void soo (Str vstr)
  {

  <<"%V $_proc $vstr \n";

   vstr.pinfo()

   <<"arg to  soo (Str) should be a Str! ptr to str? \n"

   <<"$vstr[0] $vstr[1] \n";

   ms = vstr
   
   ms.pinfo()
  <<"%V $ms\n";
ans=ask(" $vstr OK?:",db_ask)
  }
//------------------------------

  void Foo(Str vstr)
  {

  <<" $_proc $vstr \n";
  vstr.pinfo()
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

  //chkOut();

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



  <<"%V $db_action $A\n"
  
 ans=ask(DB_prompt,db_ask)
// break on ReadWords ERROR?
while (k < 4) {

  nwr = sen.ReadWords(A);
ans=ask("$k $nwr OK?:",db_ask)


  if (nwr > 0) {

  <<"$nwr $k $sen[0] $sen[1] $sen[2] $sen[3]\n";
  //  sen->split()

 ans=ask("$k $sen[0] $sen[1] OK?:",db_ask)

  soo(sen);
//  Foo(sen)

  }



  k++;

  }

 <<" done loop %V $k \n";



  ast = "Once upon a time"
  ast.pinfo()

ans=ask("$k  OK?:",db_ask)
  
  soo("Once upon a time");

 ans=ask(DB_prompt,db_ask)

 
  Svar st = "Twice upon a time"

  soo(st);

 ans=ask(DB_prompt,db_ask)

 soo("Thrice upon a time");

 ans=ask(DB_prompt,db_ask)
wdb=  DBaction((DBSTEP_),db_step)
<<"$wdb \n"
soo("Thrice upon a time");
soo("il etait une fois");


  chkOut();

  exit(-1)
//==============\_(^-^)_/==================//
