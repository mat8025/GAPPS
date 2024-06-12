/* 
 *  @script mops.asl 
 * 
 *  @comment test some math SF 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.6 C-Li-C] 
 *  @date Mon Jan  4 14:15:49 2021 
 *  @cdate Sun Apr 12 13:35:08 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///    Mops -- test some SF mops
<|Use_=
  Demo  of math ops
///////////////////////
|>

#include "debug"

  if (_dblevel >0) {

  debugON();

  <<"$Use_\n";

  }
  DB_action =0

   PI = 4.0 * atan(1.0)

  chkIn();

  int a = 14;

  int b = 16;

  short xyv[20];

  xyv.pinfo();

  chkN (xyv[0],0);

  xyv.pinfo()
allowDB("array_,ds_store,spe_exp")
  xyv[{2,4,7,a}] = 36;

  xyv.pinfo()

  <<"$xyv\n";

  chkN(xyv[2],36);

  chkN(xyv[14],36);

  chkN(xyv[0],0);

  xyv[{2,4,7,b}] = 77;

  <<"$xyv\n";

  chkN(xyv[2],77);

  B=vgen(INT_,20,0,1);
//X=vgen(INT_,10,0,1)

  chkN (B[0],0);

  chkN (B[19],19);

  B[{2,4,a}] = 77;

  <<"%V$B\n";
ans=ask(DB_prompt,DB_action)
  if (ans == "q") {
    exit(-1)
  }
  
  chkN(B[2],77);

  chkN (B[0],0);


  <<"%V$B\n";


  B[0] =0;

  <<"%V$B\n";

  B[{2, 4,7,a}] = 36;

  B.pinfo()
  <<"%V$B\n";

  chkN (B[0],0);

<<"%V $a\n"

  B[{2,4 ,7,a}] = 37;

  <<"%V$B\n";
B.pinfo()
  chkN (B[0],0);

  chkN (B[4],37);

  <<"%V$B\n";
ans=ask(DB_prompt,DB_action)
  if (ans == "q") {
    exit(-1)
  }



  xyv[{2,4,7,a}] = 77;

  chkN(xyv[2],77);

  xyv[{2,4,7,a}] = 79;
/*

<<"%v $(Caz(xyv)) \n"

<<" $(typeof(xyv)) \n"

<<"%v $(Caz(xyv)) \n"

 xyv[2] = 99

testargs(" TRY HARDER $xyv[2] ")

 as = xyv[2]

<<"%v  $as \n"


   chkN(xyv[2],99)

   chkN(xyv[2],as)

*/

  int  xyz[20];
// allow auto create ? fill to highest number ?
  xyz[{2,4,7,a}] = 79;

  chkN(xyv[2],79);

  xyz.pinfo()

  sz = Caz(xyv);

<<"%V $sz\n"
ans=ask(DB_prompt,DB_action)
  if (ans == "q") {
    exit(-1)
  }
  chkN(sz,20);

  chkN(Caz(xyv),20);

  short zx[4];

  zx[0] = 1;

  zx[1] = 2;

  zx[2] = 3;

  zx[3] = 4;

  zxs = 50;

  pi = 0;

  xyv[pi++] = 700;

  xyv[pi++] = zx[3]*zxs;

  xyv[pi++] = 699;

  xyv[pi++] = zx[2]*zxs;

  xyv[pi++] = 698;

  xyv[pi++] = zx[1]*zxs;

  xyv[pi++] = 697;

  xyv[pi++] = zx[0]*zxs;

  <<" %v $pi \n";

  <<" $xyv[0] \n";

  <<" $xyv \n";

  <<" $xyv[::] \n";

  <<"%V $xyv[::] \n";

  <<"%v $(Caz(xyv)) \n";
 //  xyv[0,2,4,6] = 77

  xyv[{0,2,4,6}] = 77;

  <<"%V $xyv[::] \n";

  chkN(xyv[2],77);

  chkOut();

  chkN(xyv[6],77);

  <<"%v $xyv[::] \n";

  xyv[0,2,4,6] = Igen(4,69,1);

  <<"%v $xyv[::] \n";

  chkN(xyv[2],70);
//<<"%v $xyv[6] \n"

  chkN(xyv[6],72);

  <<" $xyv \n";

  zx[0] =23;

  <<" %v $zx \n";

  <<"%v $xyv[*] \n";

  xyv[1,3,5,7] =  zx;

  <<"%v $xyv[::] \n";

  <<" $xyv[0] \n";

  <<"%V :: $xyv[0] \n";

  zx[3] = 66;

  <<"%v $zx \n";

  for (j = 1; j < 4 ; j++) {

  zx =  zx * 2;

  <<"%v $zx \n";
//   xyv[1,3,5,7] =  zx * zxs * j

  xyv[1,3,5,7] =  zx;

  <<"%V $j :: $xyv[0] \n";

  <<"%V $j :: $xyv \n";

  }

  <<"%v $(Caz(xyv)) \n";

  chkStage("xyassign");

  N = 27;

  a = cbrt(N);

  <<"cube root of $N  is $a\n";

  chkR(a,3.0);

  N = 729;

  a = cbrt(N);

  <<"cube root of $N  is $a\n";

  chkR(a,9.0);

  chkStage("cbrt");
//============= Atof ===========//

  p = PI;

  i = 47;

  <<"%I $i    \n";

  f= 1.2;

  sz = Caz(&f);

  <<"%V $f  $sz  \n";

  f = atof("3.141593");

  sz = Caz(&f);

  <<"%V $f  $sz  \n";

  chkN(sz,0);

  <<"%V $PI \n"

  A= Split("$PI 1634 8208 9473");

  <<"%V $A \n";
  A.pinfo()


  F=Atof(A);
ans=ask(DB_prompt,DB_action)
  if (ans == "q") {
    exit(-1)
  }
 
  sz = Caz(F);

  bd = Cab(F);

  <<"%V $F  $sz $bd\n";

  chkN(sz,4);

  G = Atof(A[1]);

  sz = Caz(&G);

  bd = Cab(&G);

  <<"%V $G $sz $bd \n";

  chkN(sz,0);

  I = Atoi(A[2]);

  sz = Caz(&I);

  bd = Cab(&I);

  <<"%V $I $sz $bd \n";

  chkN(sz,0);

  chkStage("atof");

  hs = dec2hex(47806);

  <<"$hs\n";

  chkStr(hs,"BABE");

  i= hex2dec("babe");

  chkN(i,47806);

  chkStage("dec2hex");

  chkOut();

//==============\_(^-^)_/==================//
