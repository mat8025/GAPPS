
nrows = 10
n_feat = 8

float Nit[nrows][n_feat]

float Nic[5][100][n_feat]


Nit[::][0] = 2
Nit[::][7] = 7



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

// FIXME

   Nic[kc][kci][::] = Nit[i][::]
  <<"sh $Nic[kc][kci][0:7:] \n"

   Nic[kc][kci][1::] = Nit[i][1:7:]
  <<"sp $Nic[kc][kci][0:7:] \n"
   ans =iread()

   kci++
  }

