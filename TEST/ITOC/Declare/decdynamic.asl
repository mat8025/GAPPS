/* 
 *  @script decdynamic.asl 
 * 
 *  @comment declare vector as dynamic  
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.4.57 C-Be-La]                                
 *  @date 08/03/2022 08:49:57 
 *  @cdate 08/03/2022 08:49:57 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//;

Str Use_= " Demo  of declare vector as dynamic  ";


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}
  
chkIn();

int IV[10];

 IV.pinfo();


int IV2[-10];

 IV2.pinfo();

 sz= IV2.getSize();

 chkT(sz,10);




int iv[] = { 0,1,2,3,4,5,6,7,8,9, };

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