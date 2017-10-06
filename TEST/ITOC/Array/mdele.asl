
setdebug(1,"pline","trace")

CheckIn()

 int HT[10][10]

 HT[0][0] = 0
 HT[0][5] = 5
 HT[0][7] = 7

 HT[1][0] = 10
 HT[1][5] = 15
 HT[1][7] = 17

 HT[9][7] = 47
 HT[9][8] = 79

<<"$HT \n"

jt = 0;

CT = HT[::][1:8:] 
<<"HT $(Caz(HT)) $(Cab(HT)) \n"
<<"CT $(Caz(CT)) $(Cab(CT)) \n"
<<"$CT \n"

  val = CT[0][4]

checkFNum(val,5)

 val = CT[1][4]

checkFNum(val,15)

R= vgen(INT_,10,0,1)
<<"$R\n"

T= R[2:8]

<<"$T\n"
<<"T $(Caz(T)) $(Cab(T)) \n"

checkNum(R[0],0)
checkNum(T[0],2)

CheckOut()

exit()







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