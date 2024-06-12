/* 
 *  @script packalot.asl 
 * 
 *  @comment test packb SF 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.28 C-Li-Ni]                                
 *  @date 02/27/2021 13:32:51 
 *  @cdate 01/01/2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn()

int i = 5;
float f = 3.1;
uchar uc = 79;
char c = 127;

long l = 1234;


int i2 ;
float f2 ;
uchar uc2 ;
char c2;
long l2;


<<"%V$i $f $uc $c $l \n"


uchar UCV[]
uchar UCV2[];



UCV[0] = 7;

<<"$UCV\n"
int IV[10];
int FV[10];

int nc;
i = 0;
f = 0.0;

while (1) {

nc = packb (UCV,"I",i)

<<"$nc  :: $UCV\n"

nc = unpackb (UCV,"I1",IV)

chkN(i,IV[0]);

nc = packb (UCV,"f",f)

<<"$nc  :: $UCV\n"
nc = unpackb (UCV,"f1",FV)

chkN(f,FV[0]);

packb (UCV,"i,f,u,c,l",i,f,uc,c,l)


unpackb (UCV,"i,f,C,C,L",&i2,&f2,&uc2,&c2,&l2)


chkN(i,i2)
chkN(f,f2)
chkN(c,c2)
chkN(uc,uc2)
chkN(l,l2)



i++;
f++;

IV = vgen(INT_,5,0,1)
<<"%V $IV\n"

packb (UCV,"I4",IV)

if (i >= 5) {
  break;
}

}

chkOut()


