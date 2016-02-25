
CheckIn()

nrows = 10
n_feat = 8

float Nit[nrows][n_feat]

float Nic[5][100][n_feat]


Nit[::][0] = 2
Nit[::][7] = 7

fail = 0
fail2 = 0

  for (k = 0; k < 8; k++) {
    for (i = 0; i < 8; i++) {
       Nit[k][i] = i+k
    }
  }



  kc = 0
  kci = 0


  for (i = 0 ; i < nrows ; i++) {

  <<"%V$i $kc $kci \n"
  <<"$Nit[i][0:7:] \n"

   Nic[kc][kci][::] = Nit[i][::]
  <<"sh $Nic[kc][kci][0:7:] \n"
//   x= Nic[kc][kci][0] = 47
   for (j = 0; j < 8 ; j++) {
   x= Nic[kc][kci][j]
   y= Nit[i][j]
   if (x != y) {
        fail = 1
   }
   }

   Nic[kc][kci][0:5:] = Nit[i][2:7:]
  <<"$Nit[i][0:7:] \n"
  <<"sp $Nic[kc][kci][0:7:] \n"
//i_read()
   x1= Nic[kc][kci][0]
   y1= Nit[i][2]
<<"%V$x1 $y1 \n"
   if (x1 != y1) {
        fail2 = 1
   }

  <<"sp $Nic[kc][kci][0:7:] \n"
//   ans =iread()

   kci++
  }

CheckNum(fail,0)
CheckNum(fail2,0)


CheckOut()