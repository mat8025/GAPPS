/* 
 *  @script class2.asl  
 * 
 *  @comment test class member set/access 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.66 C-Li-Dy] 
 *  @date 12/12/2021 09:01:30          
 *  @cdate 1/1/2003 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 */ 
;//-----------------<v_&_v>--------------------------//;                                                          


<|Use_=
   simple class svar member
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   allowErrors(-1);

   chkIn(_dblevel);
/// simple class test

   <<"simple class test\n";

   int Rec_id = 0;

   class Arec {

     public:

     svar srec;

     int a;

     int id;

     str Get( int wf)
     {
     str val;
     val = srec[wf];
     return val;
     };

   str Set(str val, int wf)
   {
   srec[wf] = val;
   return srec[wf];
   };
// currently need cmf keyword for constructor

  cmf Arec ()
  {

  id=Rec_id++;

  a = 1;
      //id = Rec_id;

  <<"constructing  %V $id  $Rec_id\n";

  };

  }
//===========================//

  Arec R;

  Arec FI[5];

  chkT(1);

  svar loc;

  loc = Split("how did we get here");

  <<"$loc[1]\n";
//<<"$loc[::]\n"

  FI[0]->srec = Split("how did we get here");

  <<"$FI[0]->srec[2] \n";

  <<"$FI[0]->srec[0:2:1] \n";

  <<"$FI[0]->srec[::] \n";

  r00 = FI[0]->srec[0];

  <<"%V $r00 \n";

  chkStr(r00,"how");

  r01 = FI[0]->srec[1];

  <<"%V $r01 \n";

  chkStr(r01,"did");

  r02 = FI[0]->Get(2);

  chkStr(r02,"we");

  <<"%V $r00 $r01 $r02\n";

  FI[1]->srec = Split("just evolved with many trials");

  <<"$FI[1]->srec[::] \n";

  r10 = FI[1]->srec[0];

  r11 = FI[1]->srec[1];

  r12 = FI[1]->Get(2);

  <<"%V $r10 $r11 $r12\n";

  r10 = FI[1]->srec[0];

  r11 = FI[1]->srec[1];

  r12 = FI[1]->srec[2];

  <<"%V $FI[1]->srec[2]\n";

  <<"%V $r10 $r11 $r12\n";

  chkStr(r10,"just");

  chkStr(r11,"evolved");

  chkStr(r12,"with");

  ans=FI[3]->Set("Yes",2);

  r32 = FI[3]->Get(2);

  <<"%V$r32 $ans\n";

  chkStr(r32,"Yes");

  r12 = FI[1]->Get(2);

  chkStr(r12,"with");


////////////////////////

  int Obid = 0;

  class Add {
  

  public:

  float x ;

  float y;

  int id;

  cmf Add()
  {
  id = Obid++;

  <<"CONS $_cobj %V $id\n";
  x = 0;
  y = 0;

  }

  real sum (real a,real b)
  {
  t = a +b;
  return t;
  }

  int sum (int a,int b)
  {
  t = a +b;
  return t;
  }

  int diff (int a,int b)
  {
//  int t;

  t = a -b;

  return t;

  }

  str say()
  {

  <<"$_proc hey there I exist\n";

  isay="hey hey";
  return ("hey hey");
   //return isay;

  }

  str isay()
  {

  <<"$_proc hey there I exist\n";

  isay="Do what I say";
  return isay;
  }

  }
//int s;

  Add  tc;   //FIX;

  s= tc->sum(4,5);

  chkN(s,9);

  <<"%V $s $(typeof(s)) \n";

  r= tc->sum(4.2,5.6);

  <<"%V $r $(typeof(r)) \n";

  chkN(r,9.8);

  Add  mc;

  s= mc->sum(4,5);

  <<"%V $s \n";

  Add  nc[2];

  s= nc[0]->sum(4,5);

  <<"%V $s $(typeof(s))\n";

  s= nc[1]->sum(47,79);

  <<"%V $s \n";

  chkN(s,126);

  s= nc[0]->diff(47,79);

  chkN(s,-32);

  <<"%V $s $(typeof(s))\n";

  s= mc->diff(47,79);

  <<"%V $s $(typeof(s))\n";

  chkN(s,-32);

  what = mc->say();

  <<"%V$what $(typeof(what))\n";

  chkStr(what,"hey hey");

  what=nc[0]->say();

  <<"%V$what $(typeof(what))\n";

  chkStr(what,"hey hey");

  what = mc->isay();

  <<"%V$what $(typeof(what))\n";

  chkStr(what,"Do what I say");




class Turnpt 
 {

 public:

  str Lat;
  str Lon;
  str Place;
  

   void Tset (svar wval) 
   {
//wval<-pinfo()
//<<"%V $wval[::]\n"
//<<"0 <|$wval[0]|>\n"
//<<"1 <|$wval[1]|>\n"
//<<"2 <|$wval[2]|>\n"
str val;
<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"

     val = dewhite(wval[0])
//val->info(1)
//<<"%V$val  \n"

     val = scut(val,1)
     val = scut(val,-1)

     Lat = wval[3]; // wayp 

     Lon = wval[4];
  };

}


Turnpt  Wtp[50];

svar SV;

    SV = split("one day at 40.09 105.09 dude")

<<"%V$SV\n"

    Wtp[1]->Tset(SV)

    <<"%V $Wtp[1]->Lat \n"
        <<"%V $Wtp[1]->Lon \n"





  chkOut();

//===***===//
