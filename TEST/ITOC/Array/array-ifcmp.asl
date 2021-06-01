

<|Use_=
Demo  of arraycmp;
///////////////////////
|>


#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn (_dblevel);




ushort S[10]



 S[2] = 0XBABE
 S[3] = 0XBEBA



<<"%d $S[2] $S[3] \n"


<<"%x $S[2] $S[3] \n"

  if (S[2] == 0XBABE ) {
   <<"%d $S[2] == 0xbabe \n"

 }


  int I[10]


  I[3] = 47

Ag = 47
 k = 0

while (k < 10) {

  if (I[k] == 47) {

   <<" $I[k] == 47 \n"

   chkN(k,3)
  }


  if (I[k] == 0x2f ) {

   <<" $I[k] == 0x2f\n"

  }


  if (I[k] == Ag) {

   <<"%V $k $I[k] == $Ag \n"

   chkN(k,3)
  }

   j = k


  if (I[j] == Ag) {

   <<"%V $j $I[j] == $Ag \n"
   chkN(j,3)
  }

  k++
}


chkOut()