

<|Use_=
Demo  of exp-sivs;
///////////////////////
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

//filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
//filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");

chkIn(_dblevel)


int a =2;
int b = 3;

//int ab = 2 + 3

int ab = -1;

<<"%V$ab\n"

chkN(ab,-1)


ab = 2 + 3

<<"%V$ab\n"

chkN(ab,5)



b += 2;

<<"%V $b\n"

c = a - b;

<<"%V $c = $a - $b  \n"
chkN(c,-3)



ab = a + b

<<"%V $ab = $a + $b  \n"

chkN(ab,7)

ab = a + 2 * b

<<"%V$ab = $a + 2 * $b\n"

chkN(ab,12)

ab = 5 * 6 * 7;

chkN(ab,210)

<<"%V$ab = 5 * 6 * 7\n"

ab = 10  / 2  * 7;

<<"%V$ab = 10 / 2 * 7\n"

chkN(ab,35)


ab = 3 * (10 - 2 );

<<"$ab = 3 * (10 -2)\n"

chkN(ab,24)

ab = 3^^3;

<<"$ab = 3^^3 \n"


chkN(ab,27)


 ab = 3^^3 * 2;

<<"$ab = 3^^3 *2 \n"


chkN(ab,54)

int ba = 2 + 3

<<"%V$ba = 2 + 3\n"

chkN(ba,5)




int n1 = 1;
int sum = 0;



<<"%V $n1 \n"
       n1++;

<<"%V $n1 \n"



      chkN(n1,2)

     sum += n1;
<<"%V $sum\n"
chkN(sum,2);


   ++n1;

<<"%V $n1 \n"

  chkN(n1,3)


 n1 += 2

<<"%V $n1 \n"

chkN(n1,5)


   n1 -= 2

<<"%V $n1 \n"

chkN(n1,3)

<<"%V $n1 \n"
  n1 = 3;
  n1 *= 2

<<"%V $n1 \n"
chkN(n1,6)


  n1 /= 2
<<"%V $n1 \n"
chkN(n1,3)

  b = 3;
  c = 4;
  d = 5;

  a = b + c * d;

<<"%V $a = $b + $c * $d\n"

chkN(a,23);



  a = b * c + d;

<<"%V $a = $b * $c + $d\n"

chkN(a,17);


  a = b * c - d;

<<"%V $a = $b * $c - $d\n"

chkN(a,7);




chkOut()
