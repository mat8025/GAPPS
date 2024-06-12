

<|Use_=
Demo  of exp-sivs;
///////////////////////
|>
/*
#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}
*/
//filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
//filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");


chkIn()


 pc = 4.0 * 210;

<<"%V $pc \n"

chkR(pc,840)

<<"%V $pc \n"
pc->info(1)

 pc = 40.0/200;

<<"%V $pc \n"
pc->info(1)
chkR(pc,0.2)

chkOut()


dba = -1;
<<"%V $dba\n"

int aa = 67;

<<"%V$aa\n"

int ab = 2 + 3 
<<"%V$ab\n"    

chkN(ab,5)     

 ba = 3 +7;

<<"%V$ba\n"    

chkN(ba,10)     


N = 24

k = 2
ok =0

  if (k <= N) {
<<" $k  <= $N \n"
   ok = 1
<<" <= op  working!\n"
  }
  else {
<<" <= op not working! %V$k\n"
  }

chkN(1,ok)



int e = -6;
int d = 7;
int f = 14;

b = e * d;
 <<"%V$b\n"     
chkN(b,-42)

 int a = 2 + 2
<<"%V$a\n"

chkN(a,4)

b = 7 * f

<<"%V$b\n"

chkN(b,98)




chkOut()
