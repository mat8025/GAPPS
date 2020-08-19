

ushort S[10]



 S[2] = 0XBABE
 S[3] = 0XBEBA



<<"%d $S[2] $S[3] \n"


<<"%x $S[2] $S[3] \n"

  if (S[2] == 0XBABE ) {
   <<"%d $S[2] == 0xbabe \n"

 }


stop!





  int I[10]


  I[3] = 47

Ag = 47
 k = 0
  while (k < 10) {

  if (I[k] == 47) {

   <<" $I[k] == 47 \n"

  }


  if (I[k] == 0x2f ) {

   <<" $I[k] == 0x2f\n"

  }


  if (I[k] == Ag) {

   <<"%V $k $I[k] == $Ag \n"

  }

j = k


  if (I[j] == Ag) {

   <<"%V $j $I[j] == $Ag \n"

  }

  k++
}

;
