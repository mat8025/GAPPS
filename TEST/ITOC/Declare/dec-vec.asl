/* 
 *  @script declare-vec.asl 
 * 
 *  @comment test vector declare {}  
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.16 C-Li-S]                                 
 *  @date Fri Feb  5 14:12:52 2021 
 *  @cdate 1/1/2018 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


#include "debug"
debugON()
  chkIn(_dblevel)




int iv[] = { 0,1,2,3,4,5,6,7,8,9, }

!piv
!iiv

chkN(iv[0],0)

chkN(iv[9],9)


char dv[] = { 'G', 84, 85, 78, 'O', 69,  75,76,77,'0' }

!pdv
!idv

chkN(dv[1],84)
chkN(dv[4],79)

char dv2[] = { 1, 2, 3, 4, 'P',76,77, }


!pdv2
!idv2


char dv3[] = { 'ABCDEF' }

chkN(dv3[1],66)
chkN(dv3[0],65)
chkN(dv3[2],67)

!pdv3
!idv3



char dv4[] = { 'ABCDEF', 'GHI', }


!pdv4
!idv4

sz=Caz(dv4)
<<"$sz  ==? 9\n"



float fv[] = { 1,2,3,4,5,6.0,7, }


!pfv
!ifv


float fv2[] = { 4.2,1.2345e3,2,3.8,4.567e4,5,6.890e-3,7, }

chkR(fv2[3],3.8)
!pfv2
!ifv2


chkOut()
