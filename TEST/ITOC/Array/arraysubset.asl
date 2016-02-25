
checkIn()

 B = vgen(INT_,10,0,1)
 
<<"$B\n"

 B[3,5,6] = 96

<<"$B\n"

checkNum(B[3],96)
checkNum(B[5],96)
checkNum(B[6],96)

checkNum(B[1],1)

checkOut()