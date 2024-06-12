/* 
 *  @script procret.asl 
 * 
 *  @comment test return type vs proc args 
 *  @release CARBON 
 *  @vers 1.7 N Nitrogen [asl 6.3.61 C-Li-Pm] 
 *  @date 11/23/2021 12:16:24          
 *  @cdate Sat May 9 10:35:36 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

<|Use_
   Demo  of proc return ;
///////////////////////
|>

#include "debug"

   if (_dblevel >0) {

        debugON();

        <<"$Use_\n";

   }

   ask =0;

   chkIn();

   db_allow = 1 ; // set to 1 for internal debug print;

   db_ask = 0;

   allowDB("ic,opera_,spe_,svar,str_,array_parse,parse,rdp_,pex",db_allow);

   float Foo(float x,float  y)
   {

        <<"in float Foo\n";

        z = x * y;

        return z;

   }

   int Foo(int x,int  y)
   {

        <<"in int Foo $x $y \n";

        x.pinfo();

        y.pinfo();

        z = x * y;

        z.pinfo();

        return z;

   }

   x0 = 3;

   y0 = 2;

   z0 = x0 * y0;

   z0.pinfo();

   chkN(z0,6);

   a = Foo(2,3);

   a.pinfo();

   askit(0);

   chkN(a,6);

   a.pinfo();

   <<"%v $a \n";

   b = Foo(4.0,3.0);

   chkR(b,12.0);

   a = 1;

   while (a < 10) {

        c=Foo(2,a);

        <<"%V $a $c\n";

        a++;

        <<" next iteration $a\n";

   }

   b.pinfo();

   <<"%v $b \n";

   Str Mele = "XYZ";

   Mele.pinfo();

   Str say()
   {

        <<"$_proc hey there I exist\n";

        isay="hey hey";

        <<"$isay $(typeof(isay))\n";

        return isay;

   }

   ws = say();

   ws.pinfo();

   <<"<|$ws|>\n";

   chkStr(ws,"hey hey");

   Str vers2ele(Str vstr)
   {

        <<"$_proc   <| $vstr |>\n";

        vstr.pinfo();

        pmaj.pinfo();

        pmaj = atoi(spat(vstr,".",-1));

        pmaj.pinfo();

        <<"$pmaj \n";

        <<"$(typeof(pmaj)) \n";

        <<"$(ptsym(pmaj)) \n";

        pmin = atoi(spat(vstr,".",1));

        <<"$pmin $(ptsym(pmin))\n";

        elestr = pt(pmin);

        elestr.pinfo();

        Str ele = "XYZ";

        ele.pinfo();

        es= spat(elestr,",");

        <<"%V $es\n";

        es.pinfo();

        ele = spat(elestr,",");

        ele.pinfo();

        <<"$ele $(typeof(ele))\n";

        <<"$ele\n";

        return ele;

   }
//===============================

   int a1 = 2;

   int a2 = 4;

   c = Foo(a1,a2);

   chkR(c,8);

   c.pinfo();

   <<"%v $b \n";

   j = 1;

   n = 12;

   while (j < 4) {

        a = Foo(j,n);

        j.pinfo();

        <<" $j * $n  = $a\n";

        j++;

   }

   int pmaj;

   int pmin;

   cvers ="1.54";

   cvers.pinfo();

   nele = vers2ele(cvers);

   <<"%V $cvers $nele\n";

   nele.pinfo();

   chkStr(nele,"Xeon");

   int foo1(real a)
   {
        ret = 0;

        <<" $_proc foo $a \n";

        if (a > 1) {

             <<" $a > 1 should be returning 1 !\n";

             ret =  1    ; // FIX?? needs a ; statement terminator;

        }

        else if (a < 0) {

             <<" $a < 0 should be returning -1 !\n";

             ret =  -1;

        }

        else {

             <<" $a <= 1 should be returning 0 !\n";

        }

        return ret;

   }
////////////////////////////////////////

   int foo1(int a)
   {
        ret = 0;

        <<" $_proc foo $a \n";

        if (a > 1) {

             <<" $a > 1 should be returning 1 !\n";

             ret =  1;    // FIX?? needs a ; statement terminator;

        }

        else if (a < 0) {

             <<" $a < 0 should be returning -1 !\n";

             ret =  -1;

        }

        else {

             <<" $a <= 1 should be returning 0 !\n";

        }

        return ret;

   }

   int foo2(int a)
   {

        int fret = 0;

        <<" $_proc foo2 $a \n";

        if (a > 300) {

             <<" $a > 300 foo2 should be returning 30 !\n";

             fret =30;

        }

        else if (a > 200) {

             <<" $a > 200 foo2 vshould be returning 20 !\n";

             fret = 20;

        }

        else if (a > 100) {

             <<" $a > 100 foo2 should be returning 10 !\n";

             fret = 10;

        }
//////////////////////////////////////////////

        else if (a > 1) {

             <<" $a > 1 should be returning 1 !\n";

             fret=  1;

        }

        else if (a < 0) {

             <<" $a > 1 should be returning -1 !\n";

             fret=  -1;

        }

        else {

             <<" $a <= 1 should be returning 0 !\n";

        }

        <<"return $fret\n";

        return fret;

   }
//////////////////////////////////

   int foo3(real a)
   {
        int ret = 0;

        <<" $_proc foo3 $a \n";

        a.pinfo();

        if (a > 300) {

             <<" $a > 300 foo3 should be returning 30 !\n";

             ret = 30;

        }

        else if (a > 200) {

             <<" $a > 200 foo3 vshould be returning 20 !\n";

             ret = 20;

        }

        else  if (a > 100) {

             <<" $a > 100 foo3 should be returning 10 !\n";

             ret = 10;

        }

        return ret;

   }
//========================

   void goo(ptr a)
   {

        <<"$_proc $a \n";

        a.pinfo();
//  fileDB(ALLOW_,"opera_")

        $a += 1;
  // this should increment what a is pointing to a should
 // be as before

        a.pinfo();
// does'nt really return anything
// return on own crash TBF crash

        return;

   }
//==================================//

   real hoo(real a)
   {

        <<"$_proc $a\n";

        a.pinfo();

        a += 1;

        b = a;
// does'nt really return anything

        b.pinfo();

        return b;  // TBD crash;

   }
//==================================//

   int moo(double a)
   {

        <<"$_proc $a\n";

        a += 1;

        <<"%V $a\n";

        a.pinfo();

        if (a >1) a += 1;
// if (a >10)  return; // TBF needs {}

   int mb = a;

   mb += 2;

   <<"%V $a\n";

   mb.pinfo();

   return mb;  // TBD crash;

  }
//==================================//

   int roo(ptr a)
   {

        <<"$_proc $($a)\n";

        $a += 1;

        <<"%V $a\n";

        a.pinfo();

        if ($a >1) $a += 1;
// if (a >10)  return; // TBF needs {}

   int mb = $a;

   <<"%V $mb \n";

   mb += 2;

   <<"%V $a\n";

   mb.pinfo();

   return mb;  // TBD crash;

  }
//==================================//

   in = 2;

   c = foo1(in);

   <<" $in $c \n";

   chkN(c,1);

   x= sin(0.5);

   <<"%v $x\n";

   y = sin(0.5) * 2;

   <<"%V $x $y\n";

   allowDB("opera_,spe_,svar,str_,array_parse,parse,rdp_,pex",db_allow);

   c = foo1(in) * 2;

   <<" $in $c \n";

   ans = ask("%V $x $y ",0);

   chkN(c,2);
  //chkOut(1)

   in = 1;

   c = foo1(in);

   <<" $in $c \n";

   chkN(c,0);

   in = 3;

   c = foo1(in);

   <<" $in out $c \n";

   chkN(c,1);

   c = foo1(in) * 6;

   <<" $in $c \n";

   chkN(c,6);

   in = -4;

   c = foo1(in) * 6;

   <<" $in $c \n";

   chkN(c,-6);

   fin = 110.0;

   d = foo3(fin);

   <<"ret will be  $d\n";

   in = 210;

   d = foo2(in);

   <<"ret will be  $d\n";

   real rin = in;

   e = foo3(rin);

   <<"ret will be  $e\n";

   in.pinfo();

   e = foo3(in);

   askit(0);

   <<"ret will be  $e\n";

   c = foo2(in);

   c = foo2(in) * 6;

   <<"$c foo2(in) * 6\n";

   chkN(c,120);

   c = 6 * foo2(in);

   <<"$c  6 * foo2(in)\n";

   c.pinfo();

   chkN(c,120);

   in = 310;

   d = foo2(in);

   <<"ret will be $d\n";

   e = foo3(fin);

   <<"ret will be  $e\n";

   c = foo2(in) * 7;

   <<"%V $in $c \n";

   chkN(c,210);

   for (j = 0 ; j < 3; j++) {

        in = 3;

        c = foo1(in) * (j + 1);

        <<" $in  returned * 3  $c \n";

        chkN(c,(j+1));

   }

   x =1;

   xp = &x;

   xp.pinfo();

   askit(0);

   fileDB(ALLOW_,"spe_proc, opera_main");

   goo(xp);

   <<"after call goo $x\n";

   chkN(x,2);

   x.pinfo();

   xr= hoo(x);

   <<"after call hoo $x $xr\n";

   chkN(x,2);

   chkN(xr,3);

   double xm=14.0;

   mr= moo(xm);

   <<"%V $xm $mr\n";

   chkN(mr,18);

   int ixm = 14;
 //  mr= roo(&ixm)
//<<"%V $ixm $mr\n"

   chkOut(1);
//==============\_(^-^)_/==================//
