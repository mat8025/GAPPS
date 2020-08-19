


include "debug"; 
   debugON(); 
   
   
   filterFuncDebug(ALLOWALL_,"xxx");
   filterFileDebug(ALLOWALL_,"yyy");


setdebug(1,@pline,@~trace,@keep); 
CheckIn()


V=vgen(INT_,60,0,1)

A3D= V

A3D->redimn(3,5,4)

<<"$A3D \n"

checkNum(A3D[0][0][0],0)

checkNum(A3D[2][4][3],59)

B3D = A3D


ID=cmpArray(A3D,B3D,"==",1)

<<"$ID\n"

A3D[1][1][1] = 101;

A3D[2][2][2] = 202;

A3D[2][4][3] = 777;

ID=cmpArray(A3D,B3D,"==",1)

<<"$ID\n"

VID=cmpArray(A3D,B3D,"!=")

<<"$VID\n"

checkOut()
