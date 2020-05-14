//%*********************************************** 
//*  @script mdele.asl 
//* 
//*  @comment test  multi dimn ele access 
//*  @release CARBON 
//*  @vers 1.15 P Phosphorus                                              
//*  @date Sun Feb 10 10:43:30 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
//sdb(1,@pline,@break,89)

checkIn()

 int HT[10][10]

 HT[0][0] = 0
 HT[0][5] = 5
 HT[0][7] = 7

 HT[1][1] = 10
 HT[1][5] = 15
 HT[1][7] = 17

val = 21;
  for (k = 1; k <=7; k++) {
   HT[2][k] = val++;
  }


val = 31;
  for (k = 1; k <=7; k++) {
   HT[3][k] = val++;
  }

val = 41;
  for (k = 1; k <=7; k++) {
   HT[4][k] = val++;
  }

val = 51;
  for (k = 1; k <=7; k++) {
   HT[5][k] = val++;
  }

val = 61;
  for (k = 1; k <=7; k++) {
   HT[6][k] = val++;
  }

val = 71;
  for (k = 1; k <=7; k++) {
   HT[7][k] = val++;
  }

val = 81;
  for (k = 1; k <=7; k++) {
   HT[8][k] = val++;
  }


 HT[9][7] = 47;
 HT[9][8] = 79 ;
<<"$HT \n"

jt = 0;

DT = HT

DT->info(1)
<<"$DT \n"

CT = HT[1:8:][1:7:]    ;  // TBF not selecting 2D vec correctly

<<"HT $(Caz(HT)) $(Cab(HT)) \n"
<<"CT $(Caz(CT)) $(Cab(CT)) \n"
<<"$CT \n"


CT->info(1)

sz=Caz(CT)

<<"%v $sz\n"

checkNum(sz,56)


bnds= Cab(CT)

<<"%v $bnds\n"

val = CT[0][0]

checkNum(val,10)
j = 21;

for (k=1; k<=7;k++) {
 val = CT[k][0]

 checkFNum(val,j)
 j += 10;
 <<"%V $k $val\n"
}
 val = CT[2][0]

checkFNum(val,31)




R= vgen(INT_,10,0,1)
<<"$R\n"

T= R[2:8]

<<"$T\n"
<<"T $(Caz(T)) $(Cab(T)) \n"

checkNum(R[1],1)
checkNum(T[0],2)



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

checkOut()