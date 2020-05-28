

include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_","hop_");


setdebug(1,@trace,@keep)

checkIn()

int iv[] = { 0,1,2,3,4,5,6,7,8,9, }

iv->info(1)
<<" $iv \n"

for (i=0;i<10;i++) {
checkNum(iv[i],i)
}


char cv[] = { 'F','G','H','I','J','K','L','M','N','O' }

<<"$(vinfo(cv))\n"
<<"$cv \n"
<<"%c $cv \n"
checkNum(cv[0],'F')

checkNum(cv[4],'J')

checkNum(cv[9],'O')



char cv2[] = { 'FGHIJKLMNO' }

<<"$(vinfo(cv2))\n"
<<"$cv2 \n"
<<"%c $cv2 \n"
checkNum(cv2[0],'F')

checkNum(cv2[4],'J')
checkNum(cv2[5],'K')

checkNum(cv2[9],'O')


char dv[] = { 'F', 71, 72, 73, 'O', '0', 76, 77,78,79, }

checkNum(dv[0],'F')
checkNum(dv[1],71)

checkNum(dv[9],79)

<<"$(vinfo(dv))\n"
<<"$dv \n"
<<"%c $dv \n"

checkOut()