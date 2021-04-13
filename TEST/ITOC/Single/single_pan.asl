///
///
///


<|Use=
Demo of pan addition
pan a = 1;
pan b = 1;
  a = a + b;

|>

proc showUse()
{
  <<"$Use\n"
}


//==================================



#include "debug"

if (_dblevel >0) {
   debugON()
   showUse();
}
  
chkIn(_dblevel)

pan a = 1

pan b = 0

//pan t = 3

//<<"$t \n"
N = 500;
for (i=0;i<N;i++)
 {
<<"$i $b  \n";  
  t= a ; 
//<<"%V$t \n"
  a = a + b;

//<<"%V$a \n"

 b = t;

//<<"%V$i $b \n"
}
chkN(i,N)
chkOut()