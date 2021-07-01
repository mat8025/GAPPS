/* 
 *  @script cast_buf.asl 
 * 
 *  @comment  Test cast of vector 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.6 C-Li-C]                                  
 *  @date Tue Jan  5 10:00:40 2021 
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


#include "debug"

chkIn(_dblevel)

uchar IV[];

uchar CR[1024];


nbr = 20

#define ADRF_DUSECS = 5

k = 16

while (1) {

  CR[0:nbr] = k;

<<"$nbr || $CR[0:nbr] \n"

  eb = nbr - 1;
  
  MB = CR[0:eb];
!i MB
sz=Caz(MB)
<<"%V $sz $nbr $eb\n"



   IV->info(1);
   
  // NV=cast(CHAR_,IV)

   //NV->info(1);

   IV = MB

   retype(INT_,IV)
   
    IV->info(1);

  Skpdb = IV;
  
  Skpdb->info(1);

<<" %x $CR[0:nbr] \n"
sz=Caz(MB)
<<"%V $sz $eb\n"

<<" $MB[0:eb] \n"

<<"$k \tADRF_DUSECS\t %x $Skpdb[ADRF_DUSECS]\n"

 k++;

retype(CHAR_,IV)


if (k > 34) {
     break;
 }


}



exit()

