/* 
 *  @script class2.asl 
 *  @comment test class member set/access                               
 *  @release Holmium                                                    
 *  @vers 1.4 Be Beryllium [asl 5.67 : B Ho]                            
 *  @date 12/31/2023 08:15:17                                           
 *  @cdate 1/1/2003                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 


<|Usage_=
  simple class Svar member
|>

#include "debug"

  if (_dblevel >0) {

  debugON();

  }

  allowErrors(-1);

  chkIn(_dblevel);
/// simple class test


  <<"$Usage_\n";

DB_action = 0;
int db_step = 0; // set to zero for no step

db_ask =0
db_allow = 1

 Str pset(str val, int wf)
  {
    loc[wf] = val;
    return loc[wf];
  }

///////////////////////////////////////
#include "arec.asl"

#include "add_class.asl"

//allowDB("oo_,ic,spe_,tok_func,ic_",db_allow)

  Str bike ="bike harder"


   <<"$bike \n"


   lyons = bike.cptr()


<<"%V $lyons \n"

ans=ask("¿Es eso correcto?  [y,n,q]",0);


allowDB("oo_,ic,spe_,ic_",0)

  Svar loc;

  loc[2] = "hey buddy"

  ans = loc[2]

<<"%V $ans \n"

//  pinfo(ans)
//ask("¿Es eso correcto?  [y,n,q]",DB_action);

  wi = 7;


  loc[wi] = "Por favor hable más despacio y utilice palabras sencillas."

  ans = loc[wi]

<<"%V $ans \n"
   wi++
   pset("entonces tal vez pueda entenderte. Gracias.",wi)

  ans = loc[wi]

<<"%V $ans \n"


Arec R;

  ans = "Est-ce exact?"
  ans.pinfo()

//wdb=DBaction((DBSTEP_),ON_)

  Str tans = "OK";

  tans.pinfo()
  
  // error msg should say prototype and call args don't match can't promote/demote or ambiguous

//allowDB("oo_,ic,spe_,ic_,ds_store",1)
//wdb=DBaction((DBSTEP_),ON_)
  R.Set(tans,5)

  wans =R.Set(tans,4)
  
  chkStr(wans,tans)

  gans = R.Get(4)

  chkStr(gans,tans)

 <<"%V $ans $wans $gans\n"
//ans=ask("¿Es eso correcto?  [y,n,q]",DB_action);

  ga= R.get_a()

<<"R a %V $ga\n"





Arec T;

  ga= T.get_a()

<<"T a %V $ga\n"

//ask(" %V  $__FILE__ $__FUNC__ $__LINE__ $_proc $_scope $_include $_script [y,n,q]",DB_action);




  Arec FL[10];



  FL.pinfo()

  ans=ask("FL[10]¿Es eso correcto?  [y,n,q]",0);


 Arec AI[5];

 ans = "le plus tôt possible"
  gans = AI[2].Get(3)
 //  wans = AI[2].SetVal(ans,3)

wans = AI[2].Set(ans,3)

  gans = AI[2].Get(3)

   wans = AI[2].SetVal(ans,3)


 <<"%V $ans $wans $gans\n"

  ans=ask("¿AI[10]Es eso correcto?  [y,n,q]",0);

  chkStage("OBj array")
// chkOut(1)
 ans = "Ich denke, also bin ich"

 wans = FL[2].Set(ans,4)

  gans = FL[2].Get(4)

 <<"%V $ans $wans $gans\n"

  ans=ask("¿Es eso correcto?  [y,n,q]",0);



  chkT(1);




  loc = Split("how did we get here");

  <<"$loc[1]\n";
//<<"$loc[::]\n"

  FL[0].srec = Split("how did we get here");

  <<"$FL[0].srec[2] \n";

  <<"$FL[0].srec[3] \n";
  
ans=ask("¿Es eso correcto? we ?  [y,n,q]",db_ask);

  FL[1].srec = Split("just evolved with many trials");


  <<"$FL[1].srec[2] \n";
    <<"$FL[1].srec[3] \n";
allowDB("oo_,rdp,spe_,ds_",1)  
ans=ask("¿Es eso correcto? with ?  [y,n,q]",db_ask);

    <<"$FL[0].srec[3] \n";
    
//  FL[1].srec = Split("Be positive focus forward with strength")
   FL[3].srec = Split("ABCD HOW DID WE GET HERE WXYZ");
   FL[3].Describe()

   val0 = FL[3].srec[0]
   val0.pinfo()
   val6 = FL[3].srec[6]
   val6.pinfo()
<<"%V $val0 $val6\n"


  <<"$FL[3].srec[0] \n";

  <<"$FL[3].srec[6] \n";


   FL[2].srec = Split("XXX how did we get here YYYY");

   FL[2].Describe()

   val0 = FL[2].srec[0]
   val0.pinfo()
   val6 = FL[2].srec[6]
   val6.pinfo()
<<"%V $val0 $val6\n"

  <<"$FL[2].srec[0] \n";

   
  <<"$FL[2].srec[6] \n";

ans=ask("¿Es eso correcto? focus ?  [y,n,q]",0);

   FL[8].srec = Split("XXX how did we get here YYYY");

   FL[8].Describe()

   val0 = FL[8].srec[0]
   val0.pinfo()
   val6 = FL[8].srec[6]
   val6.pinfo()
<<"%V $val0 $val6\n"

  <<"$FL[8].srec[0] \n";

   
  <<"$FL[8].srec[6] \n";


ans=ask("¿Es eso correcto? focus ?  [y,n,q]",0);



   FL[3].Describe()

   FL[2].Describe()

   FL[1].Describe()

   FL[0].Describe()





  <<"$FL[0].srec[0:2:1] \n";

  <<"$FL[0].srec[::] \n";

  r00 = FL[0].srec[0];

  <<"%V $r00 \n";

  chkStr(r00,"how");

  r10 = FL[1].srec[0];

  chkStr(r10,"just");

  r01 = FL[0].srec[1];

  <<"%V $r01 \n";

  chkStr(r01,"did");

  r02 = FL[0].srec[2];

  chkStr(r02,"we");
 
  rg2 = FL[1].srec[2];

  rg2.pinfo()

ans=ask("$rg2 with ",db_ask)

  chkStr(rg2,"with");

  rg3 = FL[0].Get(2);

  rg3.pinfo()

  chkStr(rg3,"we");



  r32 = FL[3].srec[2];

  r32.pinfo()


 chkStr(r32,"DID");

ans=ask("$r32 focus ",db_ask)


  rg4 = FL[1].Get(2);

  rg4.pinfo()

  chkStr(rg4,"with");


ans=ask("$rg4 with ",0)


  //chkOut(1)

  rg3 = FL[0].Get(3);

  rg3.pinfo()

  chkStr(rg3,"get");

  <<"%V $r00 $r01 $r02 $rg2 $rg3\n";






  <<"$FL[1].srec[::] \n";

  r10 = FL[1].srec[0];

  r11 = FL[1].srec[1];

  r12 = FL[1].Get(2);

  <<"%V $r10 $r11 $r12\n";

  r10 = FL[1].srec[0];

  r11 = FL[1].srec[1];

  r12 = FL[1].srec[2];

  <<"%V $FL[1].srec[2]\n";

  <<"%V $r10 $r11 $r12\n";

  chkStr(r10,"just");

  chkStr(r11,"evolved");

  chkStr(r12,"with");

//ask("¿Es eso correcto? <|$r10|> <|$r11|> $r12 [y,n,q]",DB_action);




  ans=FL[3].Set("Yes",2);

//ask("¿Es eso correcto?  after set 2 <|$ans|> [y,n,q]",DB_action);

  r32 = FL[3].Get(2);

//ask("¿Es eso correcto?  after get 2 <|$ans|> [y,n,q]",DB_action);

  <<"%V <|$r32|> $ans\n";

  chkStr(r32,"Yes");



  r12 = FL[1].Get(2);

  chkStr(r12,"with");
////////////////////////

 


  Add  tc;   //FIX;

  s= tc.sum(4,5);

  chkN(s,9);

  <<"%V $s $(typeof(s)) \n";

  r= tc.sum(4.2,5.6);

  <<"%V $r $(typeof(r)) \n";

  chkN(r,9.8);

///  !a  !b  margin calls do we want them?

  Add  mc;

  s= mc.sum(4,5);

  <<"%V $s \n";

  Add  nc[2];

  s= nc[0].sum(4,5);

  <<"%V $s $(typeof(s))\n";

  s= nc[1].sum(47,79);

  <<"%V $s \n";

  chkN(s,126);

  s= nc[0].diff(47,79);

  chkN(s,-32);

  <<"%V $s $(typeof(s))\n";

  s= mc.diff(47,79);

  <<"%V $s $(typeof(s))\n";

  chkN(s,-32);

  what = mc.say();

  <<"%V$what $(typeof(what))\n";

  chkStr(what,"hey hey");

  what=nc[0].say();

  <<"%V$what $(typeof(what))\n";

  chkStr(what,"hey hey");

  what = mc.isay();

  <<"%V$what $(typeof(what))\n";

  chkStr(what,"Do what I say");


//////////////////////////////////////////////////
wdb=  DBaction((DBSTEP_),db_step)
<<"$wdb \n"

  class Turnpt {

  public:

  Str Lat;

  Str Lon;

  Str Place;

  void Tset (Svar wval)
  {

    wval.pinfo()
//<<"%V $wval[::]\n"
// TBF 2/2/24  only refers to first field

<<"0 <|$wval[0]|>\n"
<<"1 <|$wval[1]|>\n"
<<"2 <|$wval[2]|>\n"

  Str val;

  <<"cmf %V $_scope $_cmfnest $_proc $_pnest\n";

  val = dewhite(wval[0]);

  val.pinfo()

  <<"%V $val  \n"

  val = scut(val,1);

  val = scut(val,-1);

  Lat = wval[3]; // wayp;

  Lon = wval[4];

  };

  }



  Turnpt  Wtp[5];

  Svar SV;

  SV = split("one day at 40.09 105.09 dude");

  <<"%V$SV \n";
  sz= SV.Caz();

<<"%V $sz\n"

  <<"%V $SV[1] \n"
  <<"%V $SV[2] \n"


  Wtp[1].Tset(SV);

  <<"%V $Wtp[1].Lat \n";

  <<"%V $Wtp[1].Lon \n";

  chkOut(1);


//==============\_(^-^)_/==================//


//  TBF  current OBJ ele on stack is broke
//   TBF FI  2 corrupt