/* 
 *  @script decc.asl 
 * 
 *  @comment char declare 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.49 C-Li-In]                               
 *  @date 08/25/2021 10:43:34 
 *  @cdate 08/25/2021 10:43:34 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//----------------------//;





<|Use_=
Demo  of declare char type

///////////////////////
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}



chkIn(_dblevel)

int iv[] = { 0,1,2,3,4,5,6,7,8,9, }

iv->info(1)
<<" $iv \n"

for (i=0;i<10;i++) {
chkN(iv[i],i)
}


char cv[] = { 'F','G','H','I','J','K','L','M','N','O' }

<<"$(vinfo(cv))\n"
<<"$cv \n"
<<"%c $cv \n"
chkN(cv[0],'F')

chkN(cv[4],'J')

chkN(cv[9],'O')



char cv2[] = { 'FGHIJKLMNO' }





<<"$(vinfo(cv2))\n"
<<"$cv2 \n"
<<"%c $cv2 \n"
chkN(cv2[0],'F')

chkN(cv2[4],'J')
chkN(cv2[5],'K')

chkN(cv2[9],'O')


char dv[] = { 'F', 71, 72, 73, 'O', '0', 76, 77,78,79, }

chkN(dv[0],'F')
chkN(dv[1],71)

chkN(dv[9],79)

<<"$(vinfo(dv))\n"
<<"$dv \n"
<<"%c $dv \n"

chkOut()
