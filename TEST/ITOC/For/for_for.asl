

chkIn(_dblevel)
N =  10

int k = 0
int j = 0

 for (k = 0 ; k < N ; k++) {

 
 <<" outer %V $k  $j \n"

  for (j = 0 ; j < N ; j++) {


 <<" inner %V $k  $j\n"

    }


 }

<<" DONE %V $k $j $N \n"

chkN(k,10)

chkN(j,10)

chkOut()

