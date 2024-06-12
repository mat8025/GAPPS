/*
 *  @script oa2.asl  
 * 
 *  @comment test object array                                          
 *  @release Osmium                                                     
 *  @vers 1.4 Be Beryllium [asl 5.76 : B Os]                            
 *  @date 01/12/2024 05:00:26                                           
 *  @cdate Tue Apr 28 19:55:01 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

//-----------------<v_&_v>--------------------------//                        

                       ///////////////////////////////////////////////////////////////
<|Use_=
  demo some OO syntax/ops
|>

int db_ask = -17; // set to zero for no ask

 if (db_ask < 0) {
     <<"Setting %V $db_ask  ==>0\n"
   db_ask = 0;

 }

int db_step = 0; // set to zero for no step

//ans=ask("%V $db_ask $__LINE__  ynq [y]\n",1);

#include "debug"

  if (_dblevel >0) {

  debugON();

  <<"$Use_\n";

  }
  db_ask =0
  allowErrors(-1);

  chkIn();

  int i = 0;
//<<" $(i.info()) \n"  // TBF recurses 

  i.pinfo();

  chkN(i,0);

  <<"$i \n";

  iv2 = i.pinfo();

  <<"$iv2 \n";

  

  IV = vgen(INT_,10,0,1);

  iv2 = IV.info();

  <<"$iv2 \n";

  IV[5] = 47;

  iv2 = IV.pinfo();

  <<"$iv2 \n";

  ivec = IV.isvector();

  <<"%v $ivec\n";
//<<"is IV vec?  $(IV.isvector()) \n" // TBF vmf in paramexp print fails!!

  vid = i.varid();
//FIXME <<" $vid $(i.vid())\n"

  <<" $vid \n";

  float F[10];

  chkT(1);
////////////////////////////////////////////////////////////

  void Pset( Svar s)
  {

  <<"proc $_proc   $s \n";

  s.pinfo();

  <<"$s[1] : $s[2]\n";

  val = s[1];

  <<"%V $val\n";

//  val1 = SV[1];

//  <<"%V $val1\n";
  return val;
  }
///////////////////////////////////////////////////////////
SVS = split("estoy bien y tu");

  <<"$SVS[0] $SVS[1]\n"

  val = SVS[0];

  <<"$val\n";

//wdb=  DBaction((DBSTEP_),db_step)
//<<"$wdb \n"

sv = Pset(SVS);


//////////////////////////////
#include "act.asl"


int obid = -1;
//allowDB("spe,oo")
  Act a;

  a.pinfo();

//
//wdb=  DBaction((DBSTEP_),ON_)
//<<"$wdb \n"

  obid = a.ObjID();
  
//

  // obid can not be known -- it increases for every Sclass new op
  od=a.GetWD();

  <<"%V $od\n";


  chkN(od,1);




 Act FA;

  od=FA.GetWD();
  obid = FA.ObjID();
//ans=ask("%V $obid $__LINE__  ynq [y]\n",db_ask);

  chkStage(" Simple ObjID");


 Act G;

  od=G.GetWD();
  obid = G.ObjID();
//ans=ask("%V $obid $__LINE__  ynq [y]\n",db_ask);





  a.otype = 2;

  <<"%V$a.otype \n";

  a.otype = 3;

  <<"%V$a.otype \n";
  int v7 = 7

  at=a.Set(v7);

  <<"%V $at $a.otype \n";

  chkN(at,7);

  od = 33;

  at=a.Set(od);

  <<"%V $at $a.otype \n";

  chkN(at,33);

  a.pinfo()



  chkStage(" Simple Obj reference");



  Act X[7];

  <<"%V $Act_ocnt \n";

  X.pinfo();

  od=X[2].GetWD();

  <<"X[2] %V $od\n";

  chkN(od,6);
ans=ask("%V $obid $__LINE__  ynq [y]\n",db_ask);
  od=X[3].GetWD();

  <<"X[3] %V $od\n";

  chkN(od,7);

  X.pinfo();

  m2 = 2;

  od = 34;

  at = X[m2].Set(od);

  chkN(at,od);
//chkOut()

  chkStage("Array Obj reference");

  Str S = "hey how are you";

  rstr =  X[m2].Set(S);

  <<"rstr <|$rstr|> $S\n";

  rstr.pinfo();

  chkStr(rstr,S);
//chkOut();
//svar SV;
//allowDB("spe_,pexpnd")

//wdb=  DBaction((DBSTEP_),db_step)
//<<"$wdb \n"
  SV = split("estoy bien y tu");

  <<"$SV[0] $SV[1] $SV[2] $SV[3] \n";

  val = SV[0];

  <<"$val\n";

  val = SV[1];

  <<"$val\n";

  val = SV[3];

  <<"$val\n";

  Svar SV2;

  SV2="estoy bien y tu";

  SV2.split();

  <<"$SV2[0]  $SV2[3] \n";

  val2 = SV2[0];

  <<"$val2\n";

  val2 = SV2[1];

  <<"$val2\n";

  val2 = SV2[3];

  <<"$val2\n";
//ans=ask("%V $val2 $__LINE__  ynq [y]\n",db_ask);
//wdb=  DBaction((DBSTEP_),db_step)
//<<"$wdb \n"



  sv = Pset(SV);

  <<"%V $sv \n";

  sv =  a.Set(SV);

  <<"%V $sv \n";
  

wdb=  DBaction((DBSTEP_),db_step)
<<"$wdb \n"

  X[m2].Set(SV);

  X[m2].info()
  
  <<"%V $X[m2].stype \n";
ans=ask("%V $obid $__LINE__  ynq [y]\n",db_ask);
  obid = X[1].ObjID(); // TBF fails crashes ?;

  <<"X[1] $obid \n";

  obid = X[0].ObjID(); // TBF fails crashes ?;

  <<"X[0] $obid \n";

  X.pinfo();

  chkStage(" Svar Mbr reference");

  Act B;

  Act C;

  //<<" B $(IDof(&B)) \n";

  obid = B.ObjID();

  vid = B.varid();
// <<"%V$obid $(b.vid\(\))\n"

  <<"%V$obid $vid\n";

  int bs = 5;

  B.Set(bs);

  br= B.Get();

  <<"$br $bs\n";

  chkN(br,bs);

  B.Set(71);

  br= B.Get();

  <<"$br \n";

  chkN(br,71);

  B.otype = 7;

  <<"%V$B.otype \n";

  obid = C.ObjID();

  <<"%V$obid \n";

  xobid = X[2].objid();

  <<"%V$xobid \n";

  yrt = X[3].Set(7);

  yt = X[3].otype;

  <<"type %V$yrt $yt\n";

  X[3].otype = 66;

  yt = X[3].otype;

  chkN(yt,66);

  <<"type %V$yrt $yt\n";

  yrt2 = X[2].Set(8);

  yt2 = X[2].otype;

  <<"type %V$yrt $yt $yrt2 $yt2\n";

  chkStage(" Simple Get/Set");
/*
//  cmf to run over subscript of object array !!
 X[0:2].Set(4)
 yt = X[1].type
<<"type $yt \n"
*/


  <<"\n; //////////////// Direct Set-Get /////////////////\n";



  pass = 1;

  X[0].otype = 50;

  X[1].otype = 79;

  X[2].otype = 47;

  X[3].otype = 80;

  yt = X[2].otype;

  <<"47? type for 2 $yt $(typeof(yt)) \n";

  chkN(yt,47);

  X.pinfo();

  yt = X[3].otype;

  <<"80? type for X[3] $yt \n";

  chkN(yt,80);

  yt = X[0].otype;

  <<"type for 0 $yt \n";

  chkN(yt,50);

  yt = X[1].otype;

  <<"type for 1 $yt = 79 ?\n";

  chkN(yt,79) ;

  yt = X[2].otype;

  <<"otype for 2 $yt = 47 ?\n";

  chkN(yt,47);

  i = 3;

  X[i].otype = 90;

  yt = X[i].otype;

  <<"otype for $i $yt = 90 ?\n";

  chkN(yt,90);
// numberstring
//  num_type = num-str   - allow with warning?
// val = 50
//!p val

  ival = 50;

  i = 2;

  X[i].otype = ival;

  yt = X[i].otype;

  chkN(yt,ival);

  <<"otype for $i $yt = $val ?\n";

  for (i = 0; i < 4; i++) {

  X[i].otype = ival;

  yt = X[i].otype;

  <<"otype for $i $yt = $val ?\n";

  if (yt != ival) {

  pass = 0;

  }

  ival++;

  }

  <<" $yt $(typeof(yt)) \n";

  <<"PASS? $pass \n";

  chkStage(" Array Direct Get/Set");
allowDB("spe_proc,spe_vmf",0)
  <<"\n; //////////////// cmf Set-Get /////////////////\n";

  pass = 1;

  m = 4;

  m2 =3;

  X.pinfo();

  yst =  X[2].Set(m);

  <<"%V $yst\n";

//wdb=  DBaction((DBSTEP_),1)
//<<"$wdb \n"

  yst =  X[3].Set(m2);


  yst =  X[m2].Set(m2);

  <<"%V $yst\n";

  i = 2;

  yt  =  X[i].otype;

  ygt =  X[i].Get();

  <<"2 otype %V $yst $yt $ygt\n";

  chkN(yst,3);

  j = 0;

//allowDB("spe_,oo")


  for (i = 0; i < 4; i++) {

    yst =  X[i].SetO(j);

    yt = X[i].otype;

    ygt =  X[i].Get();

  <<"otype for %V $i $yst $yt $ygt $j\n";

  if (yt != ygt) {

  pass = 0;

  }
ans=ask("%V  $yt $ygt \n", db_ask);
  chkN(ygt,j);

  j++;

  }

  j = 7;

  i = 4;

  yst =  X[i].SetO(j);

  yt  =  X[i].otype;

  ygt =  X[i].Get();

  if (yt != 7) {

  pass = 0;

  }

  <<"3 otype %V$yst $yt $ygt\n";

  pass1= chkN(yst,7);

  <<"$yst $(typeof(yst)) \n";

  <<" PASS? $pass $pass1\n";

  i = 3;

  yst =  X[i].Set(8);

  yt  =  X[i].otype;

  ygt =  X[i].Get();

  if (yt != 8) {

  pass = 0;

  }

  <<"3 type %V$yst $yt $ygt\n";

  pass1= chkN(yst,8);

  <<"$yst $(typeof(yst)) \n";

  <<" PASS? $pass $pass1\n";

  for (i = 5; i >= 0; i--) {

  yt = X[i].otype;

  ygt =  X[i].Get();

  <<"type for $i  $yt $ygt \n";

  }

  X[0].otype = 2;

  yt = X[0].otype;

  <<"%V$yt  $X[0].otype \n";

  chkN(yt,2);

  X[2].otype = 28;

  yt2 =  X[2].otype;

  <<"%V$yt2  $X[2].otype \n";

  chkN(yt2,28);

  X[1].otype = 79;

  yt1 =  X[1].otype;

  <<"%V$yt1  $X[1].otype \n";

  chkN(yt1,79);

  yt = X[0].otype;

  <<"%V$yt  $X[0].otype \n";

  chkN(yt,2);

  yt = X[1].otype;

  <<"%V  $yt  $X[1].otype \n";

  yt = X[2].otype;

  <<"%V  $yt  $X[2].otype \n";

  chkN(yt,28);

  for ( i = 0; i < 4; i++) {

  yt = X[i].otype;

  <<"%V $i $yt  $X[i].otype \n";

  }

  yt = X[1].otype;

  <<"%V  $yt  $X[1].otype \n";
  chkOut()
  exit(1)

//////////////////////////  TBD //////////////////////////////////////
/*

						       RDP	XIC
1. Direct Set & Get   - Simple Class                 - OK      OK
2. cmf Set & Get      - Simple Class                 - OK      OK
3. VMF
4. Direct Set & Get   - Object arrays                - OK      OK  
5. cmf Set & Get      - Object arrays                - OK      OK
6. Direct Set & Get   - Nested Class                   OK      OK
7. Direct Set & Get   - Nested Object Arrays	       OK      OK 
8. Set & Get          - MH




FIX  --- nested class  --- each object cons pushes exit statement by one
FIX  --- nested class  







*/
//////////////////////////////////////////////////////////////////////

//==============\_(^-^)_/==================//
