/* 
 *  @script bitwise.asl 
 * 
 *  @comment test bit ops & | ~ 
 *  @release CARBON 
 *  @vers 1.6 C Carbon [asl 6.3.5 C-Li-B] 
 *  @date Mon Jan  4 12:46:19 2021 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

//



#define ASL 1
#define CPP 0


#if ASL
//  compile.asl  when cpp compiling will re-define ASL 0 and CPP 1
#include "compile.asl"
#endif


#if ASL
#define cout //
#define COUT //
//int run_vec asl = runASL();
#define CDB ans=query("go on");
//#define CDBP (x) ans=query(x,"go on"); // asl not working
#define CDBP //
#include "debug.asl";

if (_dblevel >0) {
   debugON()
}
   chkIn(_dblevel); 
#endif


#if CPP
#warning USING_CPP
#define CDBP(x) ans=query(x,"go on",__LINE__,__FILE__);
#define CDB ans=query("?","go on",__LINE__,__FILE__);
#define chkEQ(x,y)  chkN(x,y,EQU_, __LINE__);
#define BXOR_ ^
#include <iostream>
#include <ostream>

#include "vec.h"
#include "uac.h"
#include "gline.h"
#include "glargs.h"
//  IF USING  graphics
#include "winargs.h"
#include "woargs.h"
#include "vargs.h"
#include "gevent.h"


int Rgt::bitwise(Svarg * sarg)  
{
  Str ans = "?";
  printf("bitwise\n");
  cout << " bitwise test  " << ans << endl;
  RUN_ASL = 0;

#endif
 ////////////////////////////////////// COMMON  CODE  ASL/CPP compatible  /////////////////////



  int  j = 5;

  int  k = 1;

  int m = j & k;

  chkEQ(m,1);

  <<"%V $j & $k BAND  $m \n";
  

  k = 2;

  m = j & k;

  <<"%V $j & $k BAND  $m \n";

  chkEQ(m,0);

  k = 4;

  m = j & k;

  <<"%V $j & $k BAND  $m \n";

  chkEQ(m,4);

  m = ( j | k );

  <<"$j | $k BOR  $m \n";

  chkEQ(m,5);

  k = 2;

  m = ( j | k );

  //<<"%V $j | $k BOR  $m \n";

  chkEQ(m,7);

  k = 4;

  m = ( j ^ k );

  //<<"$j ^ $k BXOR_  $m\n";

  chkEQ(m,1);

  m = ( j ^ k );

  //<<"$j BXOR_ $k  $m\n";

  chkEQ(m,1);

  k = 1;

  m = ( j ^ k );

  //<<"$j ^ $k XOR  $m\n";

  chkEQ(m,4);

  j = 1;
//ans= i_read("3")

  m = ~j;

  //<<"\n $m   ~$j  \n";

  //<<"%x\t$j\n\t$m\n";
//ans= i_read("4")

  m = ~k;

  //<<"\n    ~k  \n";

  //<<"%x\t$k\n\t$m\n";

  //<<"%o\t$k\n\t$m\n";
//ans= i_read("5")

  m =  j << 1;

  chkEQ(m,2);

  //<<"\n  j << 1  \n";

  //<<"\n%x\t$j\n\t$m\n";

  m =  j << 4;

  //<<"\n  j << 4  \n";

  //<<"\n%d\t$j\n\t$m\n";
//ans= i_read("6")

  j = 32;

  m =  j >> 4;

  chkEQ(m,2);

  //<<"\n  $j >> 4  = m \n";

  //<<"\n%d\t$j\n\t$m\n";
//ans= i_read("7")

  uchar  jc = 5;

  uchar  kc = 1;

  m = jc & kc;

  chkEQ(m,1);

  //<<"%V $jc & $kc BAND  $m \n";

  kc = 2;

  m = jc & kc;

  //<<"%V $jc & $kc BAND  $m \n";

  chkEQ(m,0);

  kc = 4;

  m = jc & kc;

  //<<"%V $jc & $kc BAND  $m \n";

  chkEQ(m,4);

  m = ( jc | kc );

  //<<"$jc | $kc BOR  $m \n";

  chkEQ(m,5);

  kc = 2;

  m = ( jc | kc );

  //<<"%V $jc | $kc BOR  $m \n";

  chkEQ(m,7);

  kc = 4;

  m = ( jc ^ kc );

  //<<"$jc ^ $kc BXOR_  $m\n";

  chkEQ(m,1);

  m = ( jc BXOR_ kc );

  //<<"$jc BXOR_ $kc  $m\n";

  chkEQ(m,1);

  kc = 1;

  m = ( jc ^ kc );

  //<<"$jc ^ $kc XOR  $m\n";

  chkEQ(m,4);

  jc = 1;
//ans= i_read("3")

  m = ~jc;

  //<<"\n $m   ~$jc  \n";

  //<<"%x\t$jc\n\t$m\n";
//ans= i_read("4")

  m = ~kc;

  //<<"\n    ~kc  \n";

  //<<"%x\t$kc\n\t$m\n";

  //<<"%o\t$kc\n\t$m\n";
//ans= i_read("5")

  m =  jc << 1;

  chkEQ(m,2);

  //<<"\n  jc << 1  \n";

  //<<"\n%x\t$jc\n\t$m\n";

  m =  jc << 4;

  //<<"\n  jc << 4  \n";

  //<<"\n%d\t$jc\n\t$m\n";
//ans= i_read("6")

  jc = 32;

  m =  jc >> 4;

  chkEQ(m,2);

  //<<"\n  $jc >> 4  = m \n";

  //<<"\n%d\t$jc\n\t$m\n";
//ans= i_read("7")

  uchar h = 0x40;

  uchar p = 0xF0;

  m = h & p;

  //<<"%V %X $h & $p BAND  $m \n";

  chkEQ(m,0x40);

  chkN(m,0,GT_);

  chkN(m,0,NEQ_);

  ulong j1= 1;

  ulong uk = 0;

  int sz= sizeof(j1);
//j1 = 1;
//sz= sizeof(j1);

  uk = j1 << 8;

  //<<"%V $sz $j1 $uk \n";

  int i = 16;

  uk = j1 << i;

  //<<"$i $uk\n";

  i = 32;

  uk = j1 << i;

  //<<"$i $uk\n";

  i = 48;

  uk = j1 << i;

  //<<"$i $uk\n";

  for (i= 0; i< 64 ; i++) {

  uk = j1 << i;

  //<<"$i $uk\n";

  }

  j1 = uk;

  //<<"%V $j1 $uk \n";

  i = 0;

  uk = bshift(j1,i);

  //<<"$i $uk \n";

  i = -1;

  uk = bshift(j1,i);

  //<<"$i $uk \n";

  uk = pow(2,63);

  //<<"  pow(2,63)  $uk \n";

  //<<"%V $j1 \n";

  //<<"%V $j1 \n";

  i = 0;

  uk = j1 >> i;

  //<<"%V $i $uk  $j1\n";

  i = 1;

  uk = j1 >> i;

  //<<"%V $i $uk  $j1\n";

  i = 2;

  uk = j1 >> i;

  //<<"$i $uk\n";

  for (i= 0; i< 64 ; i++) {

  uk = bshift(j1,-i);

  //<<"$i $uk\n";

  }

  for (i= 0; i< 64 ; i++) {

  uk = j1 >> i;

  //<<"$i $uk\n";

  }

  i = 16;

  uk = bshift(j1,i);

  //<<"$i $uk \n";

  i = 34;

  uk = bshift(j1,i);

  //<<"$i $uk \n";

  i = 63;

  uk = bshift(j1,i);

  //<<"$i $uk \n";

  uk = pow(2,63);

  //<<"$uk \n";

  j1 = uk;

  i = -4;

  uk = bshift(j1,i);

  //<<"$i $j1 $uk \n";

  ulong rec = 1;

  int col = 5;

  j1 = rec;

  //<<"%V $j1 \n";

  j1 = (rec << 32);

  //<<"%V $j1 \n";

  j1 += col;

  //<<"%V $j1 \n";

  //<<"%V $rec $col $j1\n";

  int r2=  j1 >> 32;

  int c2 = j1 & 0x00000000FFFFFFFF;

  //<<"%V $r2 $c2 $j1\n";

  chkOut();

////////////////////////////////  CPP ///////////////////////////////////////////////////////


#if CPP
}

//==============================//

 extern "C" int bitwise(Svarg * sarg)  {

   Rgt *o_rgt = new Rgt;

   Str a0 = sarg->getArgStr(0) ;

   printf("calling rgt method for bitwise\n");

   cout << " cmd line  parameter is: "  << " a0 " <<  a0 << endl;

  Svar sa;

   cout << " paras are:  "  << a0.cptr(0) << endl;
   sa.findWords(a0.cptr());

   cout << " The cmd  args for this module are:  "  << sa << endl;

   // can use sargs to select rgt->method via name
   // so just have to edit in new mathod to rgt class definition
   // and recompile rgt -- one line change !
   // plus include this script into 


     o_rgt->bitwise(sarg);

     return 1;
  }

#endif


/////////////////////////////////// TBD /////////////////////
/*

1. Add more


 For a new script  - check it does not already exist in rgt*.h

  
   your script stem name  e.g. logic_test for logic_test.asl script

   one time

  (1)  append '#include "bitwise.asl"' to rgt_apps.h 

  (2) append  ' int bitwise (Svarg * sarg); ' rgt_methods.h

  (3) append  ' "bitwise", '  to rgt_functions.h


   to compile 
cd  ~/gapps/TEST/RGT/LIB
type make install

       make install > junk 2>&1 ; grep error junk

 for easy inspection of compile errors



*/




;//==============\_(^-^)_/==================//;
