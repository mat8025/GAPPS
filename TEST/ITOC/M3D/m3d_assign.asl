setdebug(1)

CheckIn()

nrows = 10
n_feat = 8

int Nit[nrows][n_feat];

int Nic[5][100][n_feat];


Nit[::][0] = 2
Nit[::][7] = 7

fail1 = 0
fail2 = 0

  for (k = 0; k < 8; k++) {
    for (i = 0; i < 8; i++) {
       Nit[k][i] = i+k
    }
  }



  kc = 0
  kci = 0
  i = 0

<<"%V$i \n"

<<"$Nit[i][0:7:] \n"
i++
<<"$Nit[i][0:7:] \n"

<<"Nit[2:5][0:7:] \n"

<<"$Nit[2:5][0:7:] \n"


   Nic[kc][kci][::] = Nit[i][::]

<<"%V $Nic[kc][kci][0:7:] \n"

i++;

//<<"%V$i $Nit[i][0:7:] \n"

   Nic[kc][kci][::] = Nit[i][::]

<<"%V $Nic[kc][kci][0:7:] \n"

 Nic[kc][kci][0:5:] = Nit[i][2:7:]
//  <<"%V$i $Nit[i][0:7:] \n"
<<"%V $Nic[kc][kci][0:7:] \n"

i++

 Nic[kc][kci][0:5:] = Nit[i][2:7:]
//  <<"%V$i $Nit[i][0:7:] \n"
<<"%V $Nic[kc][kci][0:5:] \n"


  for (i = 0 ; i < nrows ; i++) {

  <<"%V$i $kc $kci \n"
  <<"%V$Nit[i][0:7:] \n"
   Nic[kc][kci][::] = Nit[i][::]
  <<"sh $Nic[kc][kci][0:7:] \n"
//   x= Nic[kc][kci][0] = 47

   for (j = 0; j < n_feat ; j++) {
     x= Nic[kc][kci][j]
     y= Nit[i][j]
    if (x != y) {
        fail1=1;
    }
   }

if (fail1) {
<<"%V$fail1 \n"
//ans =iread()
}


}

if (fail1) {
<<"%V$fail1 \n"
ans =iread()
}


 for (i = 0 ; i < nrows ; i++) {

   Nic[kc][kci][0:5:] = Nit[i][2:7:]
  <<"$Nit[i][0:7:] \n"
 // <<"sp $Nic[kc][kci][0:7:] \n"
//i_read()
   x1= Nic[kc][kci][0]
   y1= Nit[i][2]

   if (x1 != y1) {
        fail2++;
//	iread()
<<"%V$x1 $y1 \n"	
<<"sp $Nic[kc][kci][0:7:] \n"
  }

if (fail2) {
<<"%V$fail2 \n"
//ans =iread()
}
   kci++
  }

<<"%V$fail1 $fail2\n"


CheckNum(fail1,0)
CheckNum(fail2,0)


CheckOut();

exit();
