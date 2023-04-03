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
#include "rgt_asl.h"
#endif

#if CPP
#include "rgt_cpp.h"

int Rgt::bitwise(Svarg * sarg)  
{
  RUN_ASL = 0;
#endif

 ////////////////////////////////////// COMMON  CODE  ASL/CPP compatible  /////////////////////


  int  j = 5;

  int  k = 1;

  int m = j & k;
  double d = 1234.567;
  chkEQ(m,1);

  
  cprintf("  j %d &  k %d BAND   m %d \n",j,k,m);  //   <<"%V $j & $k BAND  $m \n";

   QANS; printf("%s\n",Qans);
   m = 77;
  cprintf("  j %d &  k %d BAND   m %d  d %f\n",j,k,m,d);  //   <<"%V $j & $k BAND  $m \n";  
  


  QANS; printf("%s\n",Qans);
  
  k = 2;

  m = j & k;

  exit(-1);
  
  cprintf("  j %d &  k %d BAND   m %d \n",j,k,m);  //   <<"%V $j & $k BAND  $m \n";  

  chkEQ(m,0);

  k = 4;

  m = j & k;

  
  cprintf("  j %d &  k %d BAND   m %d \n",j,k,m);  //   <<"%V $j & $k BAND  $m \n";  

  chkEQ(m,4);

  m = ( j | k );

  
  cprintf("%d | %d BOR  %d \n",j,k,m);  //   <<"$j | $k BOR  $m \n";  

  chkEQ(m,5);

  k = 2;

  m = ( j | k );

  
  cprintf("  j %d |  k %d BOR   m %d \n",j,k,m);  //   <<"%V $j | $k BOR  $m \n";  

  chkEQ(m,7);

  k = 4;

  m = ( j ^ k );

  
  cprintf("%d ^ %d BXOR_  %d\n",j,k,m);  //   <<"$j ^ $k BXOR_  $m\n";  

  chkEQ(m,1);

  m = ( j ^ k );

  
  cprintf("%d BXOR_ %d  %d\n",j,k,m);  //   <<"$j BXOR_ $k  $m\n";  

  chkEQ(m,1);

  k = 1;

  m = ( j ^ k );

  
  cprintf("%d ^ %d XOR  %d\n",j,k,m);  //   <<"$j ^ $k XOR  $m\n";  

  chkEQ(m,4);

  j = 1;
//ans= i_read("3")

  m = ~j;

  
  cprintf("\n m%d   j~%d  \n",m,j);  //   <<"\n $m   ~$j  \n";  

  
  cprintf("\tj%d\n\tm%d\n",j,m);  //   <<"%x\t$j\n\t$m\n";  
//ans= i_read("4")

  m = ~k;

  
  cprintf("\n    ~k  \n");  //   <<"\n    ~k  \n";  

  
  cprintf("\t%d\n\t%d\n",k,m);  //   <<"%x\t$k\n\t$m\n";  

  
  cprintf("\t%d\n\t%d\n",k,m);  //   <<"%o\t$k\n\t$m\n";  
//ans= i_read("5")

  m =  j << 1;

  chkEQ(m,2);

  
  cprintf("\n  j << 1  \n");  //   <<"\n  j << 1  \n";  

  
  cprintf("\n\t%d\n\t%d\n",j,m);  //   <<"\n%x\t$j\n\t$m\n";  

  m =  j << 4;

  
  cprintf("\n  j << 4  \n");  //   <<"\n  j << 4  \n";  

  
  cprintf("\n\t%d\n\t%d\n",j,m);  //   <<"\n%d\t$j\n\t$m\n";  
//ans= i_read("6")

  j = 32;

  m =  j >> 4;

  chkEQ(m,2);

  
  cprintf("\n  %d >> 4  = m \n",j);  //   <<"\n  $j >> 4  = m \n";  

  
  cprintf("\n\t%d\n\t%d\n",j,m);  //   <<"\n%d\t$j\n\t$m\n";  
//ans= i_read("7")

  uchar  jc = 5;

  uchar  kc = 1;

  m = jc & kc;

  chkEQ(m,1);

  
  cprintf("  jc  &  kc  BAND   m %d \n",jc,kc,m);  //   <<"%V $jc & $kc BAND  $m \n";  

  kc = 2;

  m = jc & kc;

  
  cprintf("  jc  &  kc  BAND   m %d \n",jc,kc,m);  //   <<"%V $jc & $kc BAND  $m \n";  

  chkEQ(m,0);

  kc = 4;

  m = jc & kc;

  
  cprintf("  jc  &  kc  BAND   m %d \n",jc,kc,m);  //   <<"%V $jc & $kc BAND  $m \n";  

  chkEQ(m,4);

  m = ( jc | kc );

  
  cprintf(" |  BOR  %d \n",jc,kc,m);  //   <<"$jc | $kc BOR  $m \n";  

  chkEQ(m,5);

  kc = 2;

  m = ( jc | kc );

  
  cprintf("  jc  |  kc  BOR   m %d \n",jc,kc,m);  //   <<"%V $jc | $kc BOR  $m \n";  

  chkEQ(m,7);

  kc = 4;

  m = ( jc ^ kc );

  
  cprintf(" ^  BXOR_  %d\n",jc,kc,m);  //   <<"$jc ^ $kc BXOR_  $m\n";  

  chkEQ(m,1);

  m = ( jc ^ kc );

  
  cprintf(" BXOR_   %d\n",jc,kc,m);  //   <<"$jc BXOR_ $kc  $m\n";  

  chkEQ(m,1);

  kc = 1;

  m = ( jc ^ kc );

  
  cprintf(" ^  XOR  %d\n",jc,kc,m);  //   <<"$jc ^ $kc XOR  $m\n";  

  chkEQ(m,4);

  jc = 1;
//ans= i_read("3")

  m = ~jc;

  
  cprintf("\n %d   ~  \n",m,jc);  //   <<"\n $m   ~$jc  \n";  

  
  cprintf("\t\n\t%d\n",jc,m);  //   <<"%x\t$jc\n\t$m\n";  
//ans= i_read("4")

  m = ~kc;

  
  cprintf("\n    ~kc  \n");  //   <<"\n    ~kc  \n";  

  
  cprintf("\t\n\t%d\n",kc,m);  //   <<"%x\t$kc\n\t$m\n";  

  
  cprintf("\t\n\t%d\n",kc,m);  //   <<"%o\t$kc\n\t$m\n";  
//ans= i_read("5")

  m =  jc << 1;

  chkEQ(m,2);

  
  cprintf("\n  jc << 1  \n");  //   <<"\n  jc << 1  \n";  

  
  cprintf("\n\t\n\t%d\n",jc,m);  //   <<"\n%x\t$jc\n\t$m\n";  

  m =  jc << 4;

  
  cprintf("\n  jc << 4  \n");  //   <<"\n  jc << 4  \n";  

  
  cprintf("\n\t\n\t%d\n",jc,m);  //   <<"\n%d\t$jc\n\t$m\n";  
//ans= i_read("6")

  jc = 32;

  m =  jc >> 4;

  chkEQ(m,2);

  
  cprintf("\n   >> 4  = m \n",jc);  //   <<"\n  $jc >> 4  = m \n";  

  
  cprintf("\n\t\n\t%d\n",jc,m);  //   <<"\n%d\t$jc\n\t$m\n";  
//ans= i_read("7")

  uchar h = 0x40;

  uchar p = 0xF0;

  m = h & p;

  
  cprintf("   h  &  p  BAND   m %d \n",h,p,m);  //   <<"%V %X $h & $p BAND  $m \n";  

  chkEQ(m,0x40);

  chkN(m,0,GT_);

  chkN(m,0,NEQ_);

  ulong j1= 1;

  ulong uk = 0;

  int sz= sizeof(j1);
//j1 = 1;
//sz= sizeof(j1);

  uk = j1 << 8;

  
  cprintf("  sz %d  j1 %ld  uk %ld \n",sz,j1,uk);  //   <<"%V $sz $j1 $uk \n";  

  int i = 16;

  uk = j1 << i;

  
  cprintf("%d %ld\n",i,uk);  //   <<"$i $uk\n";  

  i = 32;

  uk = j1 << i;

  
  cprintf("%d %ld\n",i,uk);  //   <<"$i $uk\n";  

  i = 48;

  uk = j1 << i;

  
  cprintf("%d %ld\n",i,uk);  //   <<"$i $uk\n";  

  for (i= 0; i< 64 ; i++) {

  uk = j1 << i;

  
  cprintf("%d %ld\n",i,uk);  //   <<"$i $uk\n";  

  }

  j1 = uk;

  
  cprintf("  j1 %ld  uk %ld \n",j1,uk);  //   <<"%V $j1 $uk \n";  

  i = 0;

  uk = bshift(j1,i);

  
  cprintf("%d %ld \n",i,uk);  //   <<"$i $uk \n";  

  i = -1;

  uk = bshift(j1,i);

  
  cprintf("%d %ld \n",i,uk);  //   <<"$i $uk \n";  

  uk = pow(2,63);

  
  cprintf("  pow(2,63)  %ld \n",uk);  //   <<"  pow(2,63)  $uk \n";  

  
  cprintf("  j1 %ld \n",j1);  //   <<"%V $j1 \n";  

  
  cprintf("  j1 %ld \n",j1);  //   <<"%V $j1 \n";  

  i = 0;

  uk = j1 >> i;

  
  cprintf("  i %d  uk %ld   j1 %ld\n",i,uk,j1);  //   <<"%V $i $uk  $j1\n";  

  i = 1;

  uk = j1 >> i;

  
  cprintf("  i %d  uk %ld   j1 %ld\n",i,uk,j1);  //   <<"%V $i $uk  $j1\n";  

  i = 2;

  uk = j1 >> i;

  
  cprintf("%d %ld\n",i,uk);  //   <<"$i $uk\n";  

  for (i= 0; i< 64 ; i++) {

  uk = bshift(j1,-i);

  
  cprintf("%d %ld\n",i,uk);  //   <<"$i $uk\n";  

  }

  for (i= 0; i< 64 ; i++) {

  uk = j1 >> i;

  
  cprintf("%d %ld\n",i,uk);  //   <<"$i $uk\n";  

  }

  i = 16;

  uk = bshift(j1,i);

  
  cprintf("%d %ld \n",i,uk);  //   <<"$i $uk \n";  

  i = 34;

  uk = bshift(j1,i);

  
  cprintf("%d %ld \n",i,uk);  //   <<"$i $uk \n";  

  i = 63;

  uk = bshift(j1,i);

  
  cprintf("%d %ld \n",i,uk);  //   <<"$i $uk \n";  

  uk = pow(2,63);

  
  cprintf("%ld \n",uk);  //   <<"$uk \n";  

  j1 = uk;

  i = -4;

  uk = bshift(j1,i);

  
  cprintf("%d %ld %ld \n",i,j1,uk);  //   <<"$i $j1 $uk \n";  

  ulong rec = 1;

  int col = 5;

  j1 = rec;

  
  cprintf("  j1 %ld \n",j1);  //   <<"%V $j1 \n";  

  j1 = (rec << 32);

  
  cprintf("  j1 %ld \n",j1);  //   <<"%V $j1 \n";  

  j1 += col;

  
  cprintf("  j1 %ld \n",j1);  //   <<"%V $j1 \n";  

  
  cprintf("  rec %ld  col %d  j1 %ld\n",rec,col,j1);  //   <<"%V $rec $col $j1\n";  

  int r2=  j1 >> 32;

  int c2 = j1 & 0x00000000FFFFFFFF;

  
  cprintf("  r2 %d  c2 %d  j1 %ld\n",r2,c2,j1);  //   <<"%V $r2 $c2 $j1\n";  

  chkOut();

////////////////////////////////  CPP ///////////////////////////////////////////////////////


#if CPP
  }
//==============================//
 extern "C" int bitwise(Svarg * sarg)  {

   Rgt *o_rgt = new Rgt;

   Str a0 = sarg->getArgStr(0) ;
   Svar sa;
   sa.findWords(a0.cptr());
   int ret =  o_rgt->bitwise(sarg);
   return ret;
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
