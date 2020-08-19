int IV[]
uchar CR[1024]

char IV[]

nbr = 20

#define ADRF_DUSECS = 5
 k = 16
 while (1) {

  CR[0:nbr] = k
  eb = nbr - 1 
  MB = CR[0:eb]

    recast(IV,"char")
    IV = MB
    recast(IV,"int")
  
  SKPDB = IV

<<" %x $CR[0:nbr] \n"
<<" $MB[0:eb] \n"

<<"\tADRF_DUSECS\t %x $SKPDB[ADRF_DUSECS]\n" 
 k++
 if (k > 34) {

     break;

 }

}