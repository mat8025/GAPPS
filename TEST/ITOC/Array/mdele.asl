
//setdebug(1)

CheckIn()

 float HT[10][10]

 HT[0][0] = 0
 HT[0][5] = 5
 HT[0][7] = 7

 HT[1][0] = 10
 HT[1][5] = 15
 HT[1][7] = 17

 HT[9][7] = 47
 HT[9][8] = 79

<<"$HT \n"

jt = 0
CT = HT[::][1:8:] 

<<"$CT \n"

val = CT[0][4]

checkFNum(val,5)

val = CT[1][4]

checkFNum(val,15)

CheckOut()

exitsi()







<<" %6.3f$HT[jt][5] \n"	
<<" %6.3f$HT[jt][7] \n"	


//<<" %6.3f$HT[jt][1:8:] "	
jt++


<<" %6.3f$HT[jt][5] \n"	
<<" %6.3f$HT[jt][7] \n"	

jt = 0



<<" %6.3f$HT[jt][5] \n"	

<<"CT %6.3f$CT[jt][5] \n"	
<<"CT %6.3f$CT[jt][7] \n"	



//<<" %6.3f$HT[jt][1:8:] "	